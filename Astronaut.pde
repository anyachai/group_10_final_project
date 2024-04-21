class Astronaut {
  Sprite left;
  Sprite right;
  PVector position;
  Timer animationTimer;
  boolean moveX;
  int speed = 2;
  boolean leftFlag;

  Astronaut(PVector position) {
    left = new Sprite(position, 2, "astroleft_", ".png", 2, 160);
    right = new Sprite(position, 2, "astroright_", ".png", 2, 160);
    this.position = position;
    this.moveX = true;
  }

  void update() {
    left.update();
    right.update();
    
    changeDir();
    
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
  
}
