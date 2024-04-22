class Astronaut {
  Sprite left;
  Sprite right;
  PVector position;
  Timer animationTimer;
  boolean moveX;
  int speed = 2;
  boolean leftFlag;
  PImage powerup;
  boolean powerOn;
  float rotationAngle = 0; // Variable to keep track of rotation angle


  Astronaut(PVector position) {
    left = new Sprite(position, 2, "astroleft_", ".png", 2, 160);
    right = new Sprite(position, 2, "astroright_", ".png", 2, 160);
    this.position = position;
    this.moveX = true;
    powerup = loadImage("powerup.png");
  }

  void update(boolean powerOn) {
    left.update();
    right.update();
    
    changeDir();
    
    // Displaying power up field if applicable
    if (powerOn){
      displayPowerup();
    }
    
    // Changing sprite direction
    if (leftFlag){
      left.display();
    } else{
      right.display();
    }
  }
  
  void changeDir(){
    if (upPressed && canMove(position.x, position.y - speed, 10, color(255))) {
      position.y -= speed;
    }
    if (downPressed && canMove(position.x, position.y + speed, 10, color(255))) {
      position.y += speed;
    }
    if (leftPressed && canMove(position.x - speed, position.y, 10, color(255))) {
      position.x -= speed;
      leftFlag = true;
    }
    if (rightPressed && canMove(position.x + speed, position.y, 10, color(255))) {
      position.x += speed;
      leftFlag = false;
    }
  }
  
  boolean canMove(float x, float y, int radius, color c) {
    for (int i = -radius; i <= radius; i++) {
      for (int j = -radius; j <= radius; j++) {
        int pixelColor = get((int)x + i, (int)y + j);
        if (pixelColor == c) {
          return false;
        }
      }
    }
      return true;
  }
  
  void displayPowerup() {
      pushMatrix(); // Save the current transformation state
      translate(position.x, position.y); // Move the origin to the position of the power-up
      rotate(rotationAngle); // Rotate the power-up by the current rotation angle
      imageMode(CENTER);
      image(powerup, 0, 0); // Display the power-up at the new origin (0, 0)
      popMatrix(); // Restore the previous transformation state
      
      // Increment the rotation angle for continuous rotation
      rotationAngle += radians(3); // Adjust the rotation speed as needed
  }

  
  
}
