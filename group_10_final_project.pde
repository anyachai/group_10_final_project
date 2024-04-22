PImage logo;
Astronaut player;
Alien alien;
Alien alien2;
Maze maze;
Star star;
int level = 0; // 0 for testing purposes, level can increase if player progresses
boolean upPressed, downPressed, leftPressed, rightPressed;
boolean starOn;
boolean powerOn;
SaveSelect saveScreen;
Saves currentSave;
NameEntry nameScreen;
Toggle playing;
StartScreen startScreen;
boolean first;
int lives;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  playing = new Toggle(false);
  
  // load images
  logo = loadImage("logo.png");

  // load the level
  if (level == 0){
    setupLvl1();
  }
  
  // setup GUI screens
  nameScreen = new NameEntry(saveScreen, playing);
  currentSave = new Saves("void", 999, 9999);
  saveScreen = new SaveSelect("SaveFile.csv", currentSave, nameScreen, playing);
  saveScreen.resetSaves();
  nameScreen.saveScreen = saveScreen;
  startScreen = new StartScreen("label", "message", saveScreen);
}

void draw() {
  background(0);
  
  // Display the player/game gui
  if (playing.toggled){
    background(0);
    stroke(255);
    noFill();
    
    displayPlayGUI();
    
    if (level == 0){
      updateLvl1();
    }
  }
  
  startScreen.display();
  saveScreen.display();
  nameScreen.display();

}

void keyPressed() {
  // Set flags when keys are pressed
  if (keyCode == UP) {
    upPressed = true;
  } else if (keyCode == DOWN) {
    downPressed = true;
  } else if (keyCode == LEFT) {
    leftPressed = true;
  } else if (keyCode == RIGHT) {
    rightPressed = true;
  }
  
  nameScreen.keyInteract();
}

void keyReleased() {
  // Clear flags when keys are released
  if (keyCode == UP) {
    upPressed = false;
  } else if (keyCode == DOWN) {
    downPressed = false;
  } else if (keyCode == LEFT) {
    leftPressed = false;
  } else if (keyCode == RIGHT) {
    rightPressed = false;
  }
}

void mouseReleased() {
  while (true) {
    if (startScreen.onScreen) {
      startScreen.mouseInteract();
      break;
    }
    if (nameScreen.onScreen) {
      nameScreen.mouseInteract();
      currentSave = saveScreen.getCurrentSave();
      break;
    }
    if (saveScreen.onScreen) {
      saveScreen.mouseInteract();
      currentSave = saveScreen.getCurrentSave();
      break;
    }
  }
}

void displayPlayGUI(){
  imageMode(CENTER);
  image(logo, width/2, 50);
}

void setupLvl1(){
  first = true;
  player = new Astronaut(new PVector(35,285));
  alien = new Alien(new PVector(385,285), true);
  alien2 = new Alien(new PVector(115,285), true);
  maze = new Maze("maze_", ".png", 25, 100, 0, 2, 1);
  star = new Star(new PVector(width/2,190), "star.png");
  starOn = true;
  powerOn = false;
  lives = 3;
}

void updateLvl1() {
  maze.display(0);
  if (starOn) {
    star.display();
  }
  player.update(powerOn);
  alien.update();
  alien2.update();

  // Check if the player has collected the star
  if (star.detectPlayer(first)) {
    print("detected", first);
    first = false;
    starOn = false;
    powerOn = true; // Activate the power-up
  }
  if (powerOn && !player.powerupActive) {
    player.displayPowerup();
  } else {
    powerOn = false;
  }
  
  // Check if the alien collides with the player, Once lives = 0 game is over
  if (alien.detectPlayer() || alien2.detectPlayer()) {
    respawnPlayer();
    lives -= 1;
    if (lives == 0){
      playing.toggleOff();
      setupLvl1();
      startScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
    }
  }
}

// Function to respawn the player at their current position
void respawnPlayer() {
  // You may want to add some delay or animation here before respawning the player
  player.updatePosition(new PVector(35, 285)); // Set the player's position to a default respawn position
}
