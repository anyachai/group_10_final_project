class StartScreen {
  String label;
  String message;
  Button start;
  Button toLeaderBoard;
  Boolean onScreen;
  SaveSelect saveScreen;
  PImage logo;
  PFont font;
  
  
  StartScreen(String label, String message, SaveSelect saveScreen, PFont font) {
    this.label = label;
    this.message = message;
    this.start = new Button(new PVector(400, 400), new PVector(100, 50), color(0), color(255), "START");
    this.onScreen = true;
    this.saveScreen = saveScreen;
    logo = loadImage("logo.png");
    this.font = font;
  }
  
  void display() {
    if (onScreen) {
      rectMode(CENTER);
      fill(255);
      textSize(40);
      textAlign(CENTER);
      textSize(25);
      textAlign(CENTER);
      
      textFont(font);
      textSize(18);
      text(message, 250, 250, 450, 300);

      start.display();
      imageMode(CENTER);
      image(logo, width/2, 50);
    }
  }
  
  void mouseInteract() {
    if (onScreen) {
      if (start.isInside()) {
        saveScreen.onScreen = true;
        onScreen = false;
      }
    }
  }
}
