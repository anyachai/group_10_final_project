class Astronaut {
  PImage[] frames;
  PVector position;
  int numFrames;
  int currentFrame;
  Timer animationTimer;
  boolean moveX;
  int speed = 2;

  Astronaut(PVector position, int numFrames, String leading, String trailing, int padding, int interval) {
    this.position = position;
    this.numFrames = numFrames;
    this.frames = new PImage[numFrames];
    this.moveX = true;

    for (int i = 0; i < numFrames; i++) {
      String imageName = leading + nf(i, padding) + trailing;
      frames[i] = loadImage(imageName);
    }

    this.animationTimer = new Timer(interval);
    this.animationTimer.start();
  }
  
    
  void update() {
    if (upPressed && canMove(position.x, position.y - speed)) {
      player.position.y -= speed;
    }
    if (downPressed && canMove(position.x, position.y + speed)) {
      player.position.y += speed;
    }
    if (leftPressed && canMove(position.x - speed, position.y)) {
      player.position.x -= speed;
    }
    if (rightPressed && canMove(position.x + speed, position.y)) {
      player.position.x += speed;
    }
    
    if (animationTimer.update()) {
      currentFrame = (currentFrame + 1) % numFrames;
    }
  }

  void display() {
    //imageMode(CORNER);
    PImage img = frames[currentFrame];
    image(img, position.x, position.y, img.width, img.height);
  }
  
  boolean canMove(float x, float y) {
  // Check if the player can move to the given position
  int playerRadius = 10;
  for (int i = -playerRadius; i <= playerRadius; i++) {
    for (int j = -playerRadius; j <= playerRadius; j++) {
      int pixelColor = get((int)x + i, (int)y + j);
      if (pixelColor == color(255)) {
        return false; // Obstacle found, can't move
      }
    }
  }
    return true;
  }

}
