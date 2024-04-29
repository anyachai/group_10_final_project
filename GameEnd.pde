class GameEnd {
  Button returnHome;
  Button exit;
  Toggle playing;
  StartScreen startScreen;
  Boolean onScreen;
  
  GameEnd (Toggle playing, StartScreen startScreen) {
    this.playing = playing;
    this.returnHome = new Button(new PVector(400, 400), new PVector(100, 50), color(0), color(255), "HOME");
    this.exit = new Button(new PVector(100, 400), new PVector(100, 50), color(0), color(255), "END");
    this.startScreen = startScreen;
    this.onScreen = false;
  }
  
  void display() {
    if (onScreen) {
      rectMode(CENTER);
      fill(255);
      textSize(40);
      textAlign(CENTER);
      textSize(40);
      textAlign(CENTER);
      text("GAME OVER!", 250, 250, 500, 300);

      returnHome.display();
      exit.display();
      imageMode(CENTER);
      image(logo, width/2, 50);
    }
  }
  
  void mouseInteract() {
    if (onScreen) {
      if (returnHome.isInside()) {
        startScreen.onScreen = true;
        onScreen = false;
      } if (exit.isInside()) {
        exit();
      }
    }
  }
}
