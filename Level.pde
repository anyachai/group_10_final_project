class Level1 {
  Astronaut player;
  Alien alien;
  Alien alien2;
  Maze maze;
  Item star;
  Item piece0;
  boolean starOn;
  boolean pieceOn;
  boolean powerOn;
  boolean first;
  int lives;
  ImgArray hearts;
  ImgArray pieces;

  Level1() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 285));
    alien = new Alien(new PVector(385, 285), true);
    alien2 = new Alien(new PVector(115, 285), true);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 1);
    star = new Item(new PVector(width/2, 190), "star.png");
    piece0 = new Item(new PVector(width/2, 385), "piece_00.png");
    starOn = true;
    pieceOn = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 45), 3, "heart", ".png", 2);
    pieces = new ImgArray(new PVector(170, 60), 10, "default", ".png", 2);
    lives = 3;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(0);
    star.display(starOn);
    piece0.display(pieceOn);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
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

    // Check if the player has collected the piece
    if (piece0.detectPlayer(true)){
      pieceOn = false;
    }

    // Check if the alien collides with the player
    if (alien.detectPlayer() || alien2.detectPlayer()) {
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
    if (detectEnd() && !pieceOn){
      playing.toggleOff();
      setup(); // Restart level
      startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
    }
  }

  // Function to respawn the player at their current position
  void respawnPlayer() {
    player.updatePosition(new PVector(35, 285));
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
    if (!pieceOn){
      pieces.update(0, "piece_00.png");
    }
  }
}
