PImage logo;
void setup() {
  // Setup framerate, size, background
  frameRate(60);
  size(500, 500);
  background(0);
  
  // Display game display area (don't know what to call it)
  stroke(255);
  noFill();
  rect(25, 100, 450, 375);
  
  // load images
  logo = loadImage("logo.png");
}

void draw(){
  // Display game GUI
  imageMode(CENTER);
  image(logo, width/2, 50);
}
