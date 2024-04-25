class Level4 {
  Astronaut player;
  Alien alien;
  Alien alien2;
  Alien alien3;
  Alien alien4;
  Maze maze;
  Item star;
  Item piece0;
  Item piece1;
  Item piece2;
  Item piece3;
  Item piece4;
  Item piece5;
  boolean starOn;
  boolean piece0On;
  boolean piece1On;
  boolean piece2On;
  boolean piece3On;
  boolean piece4On;
  boolean piece5On;
  boolean powerOn;
  boolean first;
  int lives;
  int nxtLvl;
  ImgArray hearts;
  ImgArray pieces;

  Level4() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 230));
    alien = new Alien(new PVector(95, 300), true, 4);
    alien2 = new Alien(new PVector(200, 335), true, 4);
    alien4 = new Alien(new PVector(305, 225), true, 4);
    alien3 = new Alien(new PVector(405, 290), true, 4);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 5);
    star = new Item(new PVector(250, 205), "star.png");
    piece0 = new Item(new PVector(200, 420), "piece_04.png");
    piece1 = new Item(new PVector(300, 420), "piece_05.png");
    piece2 = new Item(new PVector(90, 155), "piece_06.png");
    piece3 = new Item(new PVector(200, 155), "piece_07.png");
    piece4 = new Item(new PVector(404, 155), "piece_08.png");
    piece5 = new Item(new PVector(404, 420), "piece_09.png");
    starOn = true;
    piece0On = true;
    piece1On = true;
    piece2On = true;
    piece3On = true;
    piece4On = true;
    piece5On = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = level3.pieces; 
    lives = 3;
    nxtLvl = 0;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(3);
    star.display(starOn);
    piece0.display(piece0On);
    piece1.display(piece1On);
    piece2.display(piece2On);
    piece3.display(piece3On);
    piece4.display(piece4On);
    piece5.display(piece5On);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
    alien3.update();
    alien4.update();
    displayPlayGUI();

    // Check if the player has collected the star
    if (star.detectPlayer(first)) {
      first = false;
      starOn = false;
      powerOn = true;
    }
    if (powerOn && !player.powerupActive) {
      player.displayPowerup();
    } else {
      powerOn = false;
    }

    // Check if the player has collected all the pieces
    if (piece0.detectPlayer(true)){
      piece0On = false;
    }
    
    if (piece1.detectPlayer(true)){
      piece1On = false;
    }
    if (piece2.detectPlayer(true)){
      piece2On = false;
    }
    if (piece3.detectPlayer(true)){
      piece3On = false;
    }
    if (piece4.detectPlayer(true)){
      piece4On = false;
    }
    if (piece5.detectPlayer(true)){
      piece5On = false;
    }
    // Check if the alien collides with the player
    if (alien.detectPlayer() || alien2.detectPlayer() || alien3.detectPlayer() || alien4.detectPlayer()) {
      respawnPlayer();
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        setup(); // Restart level
        startScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
      }
    }
    
    // Check if the player has completed the level
    if (detectEnd() && !piece0On && !piece1On && !piece2On && !piece3On && !piece4On && !piece5On){
      nxtLvl = 5;
      //startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
    }
  }

  // Function to respawn the player at their current position
  void respawnPlayer() {
    player.updatePosition(new PVector(35, 230));
  }
  
  // Ends the level when piece is collected and end goal is reached
  boolean detectEnd(){
    if (player.position.x >= 450 && player.position.y >= 166){
      return true;
    }else{
      return false;
    }
  }
  
  void displayPlayGUI(){
    hearts.display(8);
    pieces.display(8);
    if (!piece0On){ 
      pieces.update(4, "piece_04.png");
    }
    if (!piece1On){
      pieces.update(5, "piece_05.png");
    }
    if (!piece2On){
      pieces.update(5, "piece_06.png");
    }
    if (!piece3On){
      pieces.update(5, "piece_07.png");
    }
    if (!piece4On){
      pieces.update(5, "piece_08.png");
    }
    if (!piece5On){
      pieces.update(5, "piece_09.png");
    }
  }
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}
