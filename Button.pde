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

class ImageButton {
  PVector position;
  PVector dimension;
  PImage image0;
  PImage image1;
  String label;

  ImageButton(PVector position, PVector dimension, String image0, String image1) {
    this.position = position;
    this.dimension = dimension;
    this.image0 = loadImage(image0);
    this.image1 = loadImage(image1);
  }

  void display(boolean clicked) {
    imageMode(CENTER);
    pushStyle();
    if (isInside()) {
      tint(100);
    }
    if (!clicked){
      image(image0, position.x, position.y);
    } else{
      image(image1, position.x, position.y);
    }
    popStyle(); 
  }
  
  Boolean isInside() {
    return ((mouseX < (position.x + .5 * dimension.x)) & 
    (mouseX > (position.x - .5 * dimension.x)) &
    (mouseY < (position.y + .5 * dimension.y)) &
    (mouseY > (position.y - .5 * dimension.y)));
  }
}
