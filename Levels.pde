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
  int nxtLvl;
  ImgArray hearts;
  ImgArray pieces;

  Level1() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 285));
    alien = new Alien(new PVector(385, 285), true, 3);
    alien2 = new Alien(new PVector(115, 285), true, 3);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 1);
    star = new Item(new PVector(width/2, 190), "star.png");
    piece0 = new Item(new PVector(width/2, 385), "piece_00.png");
    starOn = true;
    pieceOn = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = new ImgArray(new PVector(170, 60), 10, "default", ".png", 2); // Corrected
    lives = 3;
    nxtLvl = 1;
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
      starOn = true;
      respawnPlayer();
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        saveScreen.updateTable();
        setup(); // Restart level
        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
        pauseScreen.started = false;
      }
    }
    
    // Check if the player has completed the level
    if (detectEnd() && !pieceOn){
      nxtLvl = 2;
      //startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
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
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}

class Level2 {
  Astronaut player;
  Alien alien;
  Alien alien2;
  Alien alien3;
  Maze maze;
  Item star;
  Item piece0;
  boolean starOn;
  boolean pieceOn;
  boolean powerOn;
  boolean first;
  int lives;
  int nxtLvl;
  ImgArray hearts;
  ImgArray pieces;

  Level2() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 215));
    alien = new Alien(new PVector(90, 175), true,3);
    alien2 = new Alien(new PVector(410, 322), true,3);
    alien3 = new Alien(new PVector(235, 290), true, 3);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 5);
    star = new Item(new PVector(235, 210), "star.png");
    piece0 = new Item(new PVector(265, 390), "piece_01.png");
    starOn = true;
    pieceOn = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = level1.pieces;
    lives = 3;
    nxtLvl = 2;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(1);
    star.display(starOn);
    piece0.display(pieceOn);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
    alien3.update();
    displayPlayGUI();

    // Check if the player has collected the star
    if (star.detectPlayer(first)) {
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
    if (alien.detectPlayer() || alien2.detectPlayer() || alien3.detectPlayer()) {
      respawnPlayer();
      starOn = true;
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        setup(); // Restart level
        saveScreen.updateTable();
        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
        pauseScreen.started = false; // CHANGE TO GAME OVER SCREEN
      }
    }
    
    // Check if player has completed level
    if (detectEnd() && !pieceOn){
      nxtLvl = 3;
      //startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
    }
  }
   // Function to respawn the player at their current position
  void respawnPlayer() {
    player.updatePosition(new PVector(35, 215));
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
      pieces.update(1, "piece_01.png");
    }
  }
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}
  
class Level3 {
  Astronaut player;
  Alien alien;
  Alien alien2;
  Alien alien3;
  Alien alien4;
  Maze maze;
  Item star;
  Item piece0;
  Item piece1;
  boolean starOn;
  boolean piece0On;
  boolean piece1On;
  boolean powerOn;
  boolean first;
  int lives;
  int nxtLvl;
  ImgArray hearts;
  ImgArray pieces;

  Level3() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 170));
    alien = new Alien(new PVector(45, 300), false, 3);
    alien2 = new Alien(new PVector(205, 335), false, 3);
    alien4 = new Alien(new PVector(205, 225), false, 3);
    alien3 = new Alien(new PVector(395, 290), true, 3);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 5);
    star = new Item(new PVector(240, 225), "star.png");
    piece0 = new Item(new PVector(295, 330), "piece_02.png");
    piece1 = new Item(new PVector(395, 335), "piece_03.png");
    starOn = true;
    piece0On = true;
    piece1On = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = level2.pieces; 
    lives = 3;
    nxtLvl = 3;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(2);
    star.display(starOn);
    piece0.display(piece0On);
    piece1.display(piece1On);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
    alien3.update();
    alien4.update();
    displayPlayGUI();

    // Check if the player has collected the star
    if (star.detectPlayer(first)) {
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

    // Check if the alien collides with the player
    if (alien.detectPlayer() || alien2.detectPlayer() || alien3.detectPlayer() || alien4.detectPlayer()) {
      respawnPlayer();
      starOn = true;
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        saveScreen.updateTable();
        setup(); // Restart level
        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
        pauseScreen.started = false; // CHANGE TO GAME OVER SCREEN
      }
    }
    
    // Check if the player has completed the level
    if (detectEnd() && !piece0On && !piece1On){
      nxtLvl = 4;
      //startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
    }
  }

  // Function to respawn the player at their current position
  void respawnPlayer() {
    player.updatePosition(new PVector(35, 170));
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
      pieces.update(2, "piece_02.png");
    }
    if (!piece1On){
      pieces.update(3, "piece_03.png");
    }
  }
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}

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
  boolean starOn;
  boolean piece0On;
  boolean piece1On;
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
    piece0 = new Item(new PVector(150, 378), "piece_04.png");
    piece1 = new Item(new PVector(360, 378), "piece_05.png");
    starOn = true;
    piece0On = true;
    piece1On = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = level3.pieces; 
    lives = 3;
    nxtLvl = 4;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(3);
    star.display(starOn);
    piece0.display(piece0On);
    piece1.display(piece1On);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
    alien3.update();
    alien4.update();
    displayPlayGUI();

    // Check if the player has collected the star
    if (star.detectPlayer(first)) {
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

    // Check if the alien collides with the player
    if (alien.detectPlayer() || alien2.detectPlayer() || alien3.detectPlayer() || alien4.detectPlayer()) {
      respawnPlayer();
      starOn = true;
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        saveScreen.updateTable();
        setup(); // Restart level
        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
        pauseScreen.started = false; // CHANGE TO GAME OVER SCREEN
      }
    }
    
    // Check if the player has completed the level
    if (detectEnd() && !piece0On && !piece1On){
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
  }
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}

class Level5 {
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
  boolean starOn;
  boolean piece0On;
  boolean piece1On;
  boolean piece2On;
  boolean piece3On;
  boolean powerOn;
  boolean first;
  int lives;
  int nxtLvl;
  ImgArray hearts;
  ImgArray pieces;

  Level5() {
    setup();
  }

  void setup() {
    first = true;
    player = new Astronaut(new PVector(35, 200));
    alien = new Alien(new PVector(180, 215), true, 3);
    alien2 = new Alien(new PVector(214, 366), false, 3);
    alien3 = new Alien(new PVector(140, 350), true, 3);
    alien4 = new Alien(new PVector(366, 288), true, 3);
    maze = new Maze("maze_", ".png", 25, 100, 0, 2, 5);
    star = new Item(new PVector(136, 366), "star.png");
    piece0 = new Item(new PVector(280, 204), "piece_06.png");
    piece1 = new Item(new PVector(404, 364), "piece_07.png");
    piece2 = new Item(new PVector(180, 204), "piece_08.png");
    piece3 = new Item(new PVector(272, 370), "piece_09.png");
    starOn = true;
    piece0On = true;
    piece1On = true;
    piece2On = true;
    piece3On = true;
    powerOn = false;
    hearts = new ImgArray(new PVector(40, 60), 3, "heart", ".png", 2);
    pieces = level4.pieces; 
    lives = 3;
    nxtLvl = 5;
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
    maze.display(4);
    star.display(starOn);
    piece0.display(piece0On);
    piece1.display(piece1On);
    piece2.display(piece2On);
    piece3.display(piece3On);
    player.update(upPressed, downPressed, leftPressed, rightPressed, powerOn);
    alien.update();
    alien2.update();
    alien3.update();
    alien4.update();
    displayPlayGUI();

    // Check if the player has collected the star
    if (star.detectPlayer(first)) {
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
    
    // Check if the alien collides with the player
    if (alien.detectPlayer() || alien2.detectPlayer() || alien3.detectPlayer() || alien4.detectPlayer()) {
      respawnPlayer();
      starOn = true;
      lives -= 1;
      hearts.update(lives, "dead.png");
      if (lives == 0){
        playing.toggleOff();
        saveScreen.updateTable();
        setup(); // Restart level
        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
        pauseScreen.started = false; // CHANGE TO GAME OVER SCREEN
      }
    }
    
    // Check if the player has completed the level
    if (detectEnd() && !piece0On && !piece1On && !piece2On && !piece3On){
      nxtLvl = 6;
      //startScreen.onScreen = true; // CHANGE TO NEXT LEVEL SCREEN
    }
  }

  // Function to respawn the player at their current position
  void respawnPlayer() {
    player.updatePosition(new PVector(35, 200));
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
      pieces.update(6, "piece_06.png");
    }
    if (!piece1On){
      pieces.update(7, "piece_07.png");
    }
    if (!piece2On){
      pieces.update(8, "piece_08.png");
    }
    if (!piece3On){
      pieces.update(9, "piece_09.png");
    }
  }
  
  int returnNxtLvl(){
    return nxtLvl;
  }
}
