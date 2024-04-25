import processing.sound.*;
Level1 level1;
Level2 level2;
Level3 level3;
Toggle playing;
NameEntry nameScreen;
SaveSelect saveScreen;
Saves currentSave;
StartScreen startScreen;
PauseScreen pauseScreen;
SoundFile music;
PImage logo;
PFont jersey;
PFont pixel;
boolean upPressed, downPressed, leftPressed, rightPressed;
int level;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  
  // Create instances of GUI screens
  logo = loadImage("logo.png");
  playing = new Toggle(false);
  nameScreen = new NameEntry(saveScreen, playing, pauseScreen);
  currentSave = new Saves("void", 999, 9999);
  saveScreen = new SaveSelect("SaveFile.csv", currentSave, nameScreen, playing, pauseScreen);
  saveScreen.resetSaves();
  nameScreen.saveScreen = saveScreen;
  pauseScreen = new PauseScreen(playing, music, startScreen, saveScreen);
  nameScreen.pauseScreen = pauseScreen;
  saveScreen.pauseScreen = pauseScreen;
  startScreen = new StartScreen("label", "message", saveScreen);
  pauseScreen.startScreen = startScreen;
  pauseScreen.saveScreen = saveScreen;
  
  //SOUND
  music = new SoundFile(this, "8bit.mp3");
  music.amp(0.50); // Set volume to 50%
  music.play();
  pauseScreen.music = music;
  
  // Load level = DEPENDS ON SAVE FILE
  level = 1;
  
  // Setup level
  level1 = new Level1();
  level2 = new Level2();
  level3 = new Level3();
  
  // Setup font
  jersey = createFont("Jersey10-Regular.ttf",100);
  pixel = createFont("PixelifySans.ttf",100);
  textFont(jersey);
}

void draw() {
  background(0);
  
  // Display the player/game gui
  if (playing.toggled){
    background(0);
    stroke(255);
    noFill();
    
    // Update level
    if (level == 1 ){
      level1.update(upPressed, downPressed, leftPressed, rightPressed);
    }
    if (level == 2 || level1.returnNxtLvl() == 2){
      level2.update(upPressed, downPressed, leftPressed, rightPressed);
    }
    if (level == 3 || level2.returnNxtLvl() == 3){
      level3.update(upPressed, downPressed, leftPressed, rightPressed);
    }
  }
  
  startScreen.display();
  saveScreen.display();
  nameScreen.display();
  pauseScreen.display();
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
    break;
  }
  pauseScreen.mouseInteract();
}
