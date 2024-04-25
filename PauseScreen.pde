class PauseScreen {
  Toggle playing;
  //Button pause;
  Button resume;
  //Button mute;
  Button quit;
  ImageButton mute;
  ImageButton pause;
  Boolean started;
  Boolean muted;
  SoundFile music;
  StartScreen startScreen;
  SaveSelect saveScreen;
  PImage background;
  
  PauseScreen(Toggle playing, SoundFile music, StartScreen startScreen, SaveSelect saveScreen) {
    this.playing = playing;
    //this.pause = new Button(new PVector(475, 13), new PVector(25, 25), color(0), color(100), "P");
    this.pause = new ImageButton(new PVector(40,25), new PVector(25,25), "pause.png", "pause.png");
    this.resume = new Button(new PVector(400, 350), new PVector(140, 80), color(0), color(100), "RESUME");
    //this.mute = new Button(new PVector(250, 350), new PVector(140, 80), color(0), color(100), "MUTE");
    this.mute = new ImageButton(new PVector(250, 350), new PVector(140,80), "sound_off.png", "sound_on.png");
    this.quit = new Button(new PVector(100, 350), new PVector(140, 80), color(0), color(100), "QUIT");
    this.started = false;
    this.music = music;
    this.muted = false;
    this.startScreen = startScreen;
    this.saveScreen = saveScreen;
    this.background = loadImage("bkgd.png");
  }
  
  void display() {
    if (playing.toggled) {
      pause.display(false);
    } else if ((!playing.toggled) & started) {
      image(background, width/2, width/2);
      rectMode(CENTER);
      stroke(255);
      fill(0);
      rect(250, 250, 450, 300);
      textFont(jersey);
      textSize(100);
      textAlign(CENTER);
      fill(255);
      text("PAUSED", 250, 250);
      resume.display();
      mute.display(muted);
      quit.display();
    }
  }
  
  void mouseInteract() {
    if (pause.isInside() & playing.toggled) {
      playing.toggled = false;
    }
    if (resume.isInside() & !playing.toggled & started) {
      playing.toggled = true;
    }
    if (mute.isInside() & !playing.toggled & started) {
      if (muted) {
        music.amp(0.5);
        muted = false;
      } else {
        music.amp(0);
        muted = true;
      }
    }
    if (quit.isInside() & !playing.toggled & started) {
      playing.toggled = false;
      started = false;
      startScreen.onScreen = true;
      saveScreen.updateTable();
    }
  }
}
