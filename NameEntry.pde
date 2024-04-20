class NameEntry {
  String name;
  Boolean onScreen;
  Button saveName;
  Button clearName;
  SaveSelect saveScreen;
  Toggle playing;
  
  NameEntry(SaveSelect saveScreen, Toggle playing) {
    this.name = "";
    this.onScreen = false;
    this.saveName = new Button(new PVector(375, 400), new PVector(200, 50), color(0), color(255), "SAVE NAME");
    this.clearName = new Button(new PVector(125, 400), new PVector(200, 50), color(0), color(255), "CLEAR NAME");
    this.saveScreen = saveScreen;
    this.playing = playing;
  }
  
  void keyInteract() {
    if (onScreen) {
      if (key >= 'a' && key <= 'z' && (name.length() < 11)) {
        char k = char (int (key) - 32);
        name = name + k;
      } else if (key >= 'A' && key <= 'Z' && name.length() < 11) {
        char k = key;
        name = name + k;
      }
    }
  }
  
  void display() {
    if (onScreen) {
      rectMode(CORNER);
      fill(255);
      textFont(pixel);
      textSize(40);
      textAlign(CENTER);
      text("NAME: " + name, 250, 350);
      rectMode(CENTER);
      fill(255);
      textFont(jersey);
      textSize(30);
      textAlign(CENTER);
      text("ENTER YOUR NAME", 250, 300, 400, 100);
      saveName.display();
      clearName.display();
    } else {
      name = "";
    }
      
  }
  
  void mouseInteract() {
    if (onScreen) {
      if (saveName.isInside() && (name.length() > 0)) {
        onScreen = false;
        saveScreen.currentSave.name = name;
        saveScreen.updateTable();
        playing.toggled = true;
      }
      if (clearName.isInside()) {
        name = "";
      }
    }
  }
  
}
