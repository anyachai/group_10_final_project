class Button {
  PVector position;
  PVector dimension;
  color Color;
  color outline;
  String label;
  
  Button(PVector position, PVector dimension, color Color, color outline, String label) {
    this.position = position;
    this.dimension = dimension;
    this.Color = Color;
    this.label = label;
    this.outline = outline;
  }
    
  void display() {
    rectMode(CENTER);
    stroke(outline);
    if (isInside()) {
      fill(100);
    } else {
    fill(Color);
    }
    rect(position.x, position.y, dimension.x, dimension.y);
    textFont(jersey);
    textSize(dimension.y * .6);
    textAlign(CENTER);
    fill(255);
    text(label, position.x, position.y);
  }
  
  Boolean isInside() {
    return ((mouseX < (position.x + .5 * dimension.x)) & 
    (mouseX > (position.x - .5 * dimension.x)) &
    (mouseY < (position.y + .5 * dimension.y)) &
    (mouseY > (position.y - .5 * dimension.y)));
  }
  
  void isClicked() {
  }
}
