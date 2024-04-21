PImage logo;
Astronaut player;
Alien alien;
Alien alien2;
Maze maze;
int level = 0; // 0 for testing purposes, level can increase if player progresses
boolean upPressed, downPressed, leftPressed, rightPressed;
SaveSelect saveScreen;
Saves currentSave;
NameEntry nameScreen;
Toggle playing;
StartScreen startScreen;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  playing = new Toggle(false);
  
  // load images
  logo = loadImage("logo.png");

  player = new Astronaut(new PVector(35,285));
  alien = new Alien(new PVector(385,285), true);
  alien2 = new Alien(new PVector(115,285), true);
  maze = new Maze("maze_", ".png", 25, 100, 0, 2, 1);
  
  
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
  if (playing.toggled) {
    background(0);
    stroke(255);
    noFill();
    
    imageMode(CENTER);
    image(logo, width/2, 50);
    maze.display(0);

    player.update();
    alien.update();
    alien2.update();
    
    if (alien.detectPlayer()|alien2.detectPlayer()){
      playing.toggleOff();
      startScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
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
