class SaveButton {
  PVector position;
  color Color;
  color outline;
  Saves info;
  
  SaveButton (PVector position, color Color, color outline, Saves info) {
    this.position = position;
    this.Color = Color;
    this.info = info;
    this.outline = outline;
  }
  
  void display() {
    rectMode(CENTER);
    textFont(jersey);
    stroke(outline);
    if (isInside()) {
      fill(100);
    } else {
      fill(Color);
    }
    rect(position.x, position.y, 450, 100);
    fill(100);
    rect(position.x - 175, position.y, 100, 100);
    fill(255);
    textSize(70);
    textAlign(CENTER);
    textFont(jersey);
    text(str(info.saveNumber), position.x - 175, position.y + 25);
    textFont(pixel);
    textSize(35);
    text(info.name, position.x + 50, position.y - 15);
    text("LEVEL " + str(info.level), position.x + 50, position.y + 35);
  }
  
  Boolean isInside() {
    return ((mouseX < (position.x + 225)) & 
    (mouseX > (position.x - 225)) &
    (mouseY < (position.y + 50)) &
    (mouseY > (position.y - 50)));
  }
}
