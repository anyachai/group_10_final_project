class Astronaut {
  Sprite left;
  Sprite right;
  PVector position;
  Timer animationTimer;
  int speed = 2;
  boolean leftFlag;
  PImage powerup;
  float rotationAngle = 0; 
  boolean powerupActive;
  Timer powerupTimer;

  Astronaut(PVector position) {
    left = new Sprite(position, 2, "astroleft_", ".png", 2, 160);
    right = new Sprite(position, 2, "astroright_", ".png", 2, 160);
    this.position = position;
    powerup = loadImage("powerup.png");
    powerupTimer = new Timer(10000);
    powerupActive = false; // Initially power-up is not active
  }

  void update(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed, boolean powerOn) {
    left.update();
    right.update();
    
    changeDir(upPressed, downPressed, leftPressed, rightPressed);
    
    // Start the power-up display if activated and not already active
    if (powerOn && !powerupActive) {
        powerupActive = true;
        powerupTimer.start();
        println("Power-up activated, timer started");
    }
    
    // Check if power-up duration has expired
    if (powerupActive) {
        // Update the power-up timer
        if (powerupTimer.update()) {
            println("Power-up timer ended");
            powerupActive = false; // Turn off the power-up
        }
    }
    
    // Changing sprite direction
    if (leftFlag) {
        left.display();
    } else {
        right.display();
    }
    
    if (powerupActive) {
        displayPowerup();
    }
  }
  
  void changeDir(boolean upPressed, boolean downPressed, boolean leftPressed, boolean rightPressed) {
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
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotationAngle);
    imageMode(CENTER);
    image(powerup, 0, 0);
    popMatrix();

    rotationAngle += radians(3);
  }
  
  void updatePosition(PVector position){
    left.position = position;
    right.position = position;
    this.position = position;
  }
}
