Level1 level1;
Toggle playing;
NameEntry nameScreen;
SaveSelect saveScreen;
Saves currentSave;
StartScreen startScreen;
PImage logo;
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  
  // Create instances of GUI screens
  logo = loadImage("logo.png");
  playing = new Toggle(false);
  nameScreen = new NameEntry(saveScreen, playing);
  currentSave = new Saves("void", 999, 9999);
  saveScreen = new SaveSelect("SaveFile.csv", currentSave, nameScreen, playing);
  saveScreen.resetSaves();
  nameScreen.saveScreen = saveScreen;
  startScreen = new StartScreen("label", "message", saveScreen);
  
  // Setup level
  level1 = new Level1();
}

void draw() {
  background(0);
  
  // Display the player/game gui
  if (playing.toggled){
    background(0);
    stroke(255);
    noFill();
    
    // Update level
    level1.update(upPressed, downPressed, leftPressed, rightPressed);
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
