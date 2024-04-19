PImage logo;
Astronaut player;
Maze maze;
int level = 0; // 0 for testing purposes, level can increase if player progresses
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup() {
  // Setup framerate, size, background
  background(0);
  frameRate(35);
  size(500, 500);
  
  // load images
  logo = loadImage("logo.png");
  PVector location = new PVector(35,285);
  player = new Astronaut(location, 2, "astro_", ".PNG", 2, 160);
  maze = new Maze("maze_", ".png", 25, 100, 0, 2, 1);
}

void draw() {
  // Display game GUI
  background(0);
  stroke(255);
  noFill();
  maze.display(0);
  imageMode(CENTER);
  image(logo, width/2, 50);
  
  
  // Display the player
  player.update();
  player.display();
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
