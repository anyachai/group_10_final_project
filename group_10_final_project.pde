import processing.sound.*;
Level1 level1;
Level2 level2;
Level3 level3;
Level4 level4;
Level5 level5;
Level6 level6;
Toggle playing;
NameEntry nameScreen;
SaveSelect saveScreen;
Saves currentSave;
StartScreen startScreen;
PauseScreen pauseScreen;
GameEnd endScreen;
SoundFile music;
PImage logo;
PFont jersey;
PFont pixel;
boolean upPressed, downPressed, leftPressed, rightPressed, spacePressed;
int level;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  
  // Setup font
  jersey = createFont("Jersey10-Regular.ttf",100);
  pixel = createFont("PixelifySans.ttf",100);
  
  // Create instances of GUI screens
  logo = loadImage("logo.png");
  playing = new Toggle(false);
  nameScreen = new NameEntry(saveScreen, playing, pauseScreen);
  currentSave = new Saves("void", 999, 9999);
  saveScreen = new SaveSelect("SaveFile.csv", currentSave, nameScreen, playing, pauseScreen);
  //saveScreen.resetSaves(); // <-- comment this out to stop saves from resetting at game launch
  nameScreen.saveScreen = saveScreen;
  pauseScreen = new PauseScreen(playing, music, startScreen, saveScreen);
  nameScreen.pauseScreen = pauseScreen;
  saveScreen.pauseScreen = pauseScreen;
  startScreen = new StartScreen("label", "SPACESHIP DECIMUS IS BROKEN AND IT'S UP TO YOU TO COLLECT THE MISSING PIECES, PUT IT TOGETHER, AND FLY BACK TO YOUR PLANET! TO EXIT EACH MAZE LEVEL, USE THE ARROW KEYS TO MOVE AROUND COLLECT ALL THE AVAILABLE PIECES. AFTER FIVE MAZE LEVELS, USE THE ARROW KEYS TO FLY YOUR SHIP AND USE THE SPACEBAR TO SHOOT! WATCH OUT FOR ALIENS AND ASTEROIDS THOUGH, THEY COULD KILL YOU!", saveScreen, pixel);
  pauseScreen.startScreen = startScreen;
  pauseScreen.saveScreen = saveScreen;
  endScreen = new GameEnd(playing, startScreen);
  
  //SOUND
  music = new SoundFile(this, "8bit.mp3");
  music.amp(0.50); // Set volume to 50%
  music.play();
  pauseScreen.music = music;
  
  // Load level = DEPENDS ON SAVE FILE
  //level = 1;
  
  // Setup level
  level1 = new Level1();
  level2 = new Level2();
  level3 = new Level3();
  level4 = new Level4();
  level5 = new Level5();
  level6 = new Level6();
  

  textFont(jersey);
}

void draw() {
  background(0);
  
  // Display the player/game gui
  if (playing.toggled){
    background(0);
    stroke(255);
    noFill();
    if (currentSave.level != level) {
      level1 = new Level1();
      level2 = new Level2();
      level3 = new Level3();
      level4 = new Level4();
      level5 = new Level5();
      level6 = new Level6();
    }
      
    level = currentSave.level;
    //println(currentSave.name);
    
    // Update level
    switch(currentSave.level) {
      case 1: 
        level1.update(upPressed, downPressed, leftPressed, rightPressed);
        level = level1.returnNxtLvl();
        currentSave.level = level1.returnNxtLvl(); 
        break;
        
      case 2:
        level2.update(upPressed, downPressed, leftPressed, rightPressed);
        level = level2.returnNxtLvl();
        currentSave.level = level2.returnNxtLvl(); 
        break;
        
      case 3:
        level3.update(upPressed, downPressed, leftPressed, rightPressed);
        level = level3.returnNxtLvl();
        currentSave.level = level3.returnNxtLvl(); 
        break;
        
      case 4:
        level4.update(upPressed, downPressed, leftPressed, rightPressed);
        level = level4.returnNxtLvl();
        currentSave.level = level4.returnNxtLvl(); 
        break;
        
      case 5:
        level5.update(upPressed, downPressed, leftPressed, rightPressed);
        level = level5.returnNxtLvl();
        currentSave.level = level5.returnNxtLvl(); 
        break;
        
      case 6:
        level6.update();
        currentSave.level = level6.returnNxtLvl();
        break;
    }
  }
  
  startScreen.display();
  saveScreen.display();
  nameScreen.display();
  pauseScreen.display();
  endScreen.display();
}

void gameEnder() {
  endScreen.onScreen = true;
  playing.toggled = false;
  pauseScreen.started = false;
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
  } if (key == 32) {
    spacePressed = true;
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
  } if (key == 32) {
    spacePressed = false;
  } if ((key == BACKSPACE) & playing.toggled) {
    gameEnder();
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
    if (endScreen.onScreen) {
      endScreen.mouseInteract();
      break;
    }
    break;
  }
  pauseScreen.mouseInteract();
}
