class Alien{
  Sprite alien;
  PVector position;
  Timer animationTimer;
  boolean moveX;
  int speed;

  Alien(PVector position, boolean moveX, int speed) {
    alien = new Sprite(position, 2, "alien_", ".png", 2, 160);
    this.position = position;
    this.moveX = moveX;
    this.speed = speed;
  }
  
    
  void update() {
    alien.update();
    if (moveX) {
        boolean canMoveUp = canMove(position.x, position.y - speed, 13);
        boolean canMoveDown = canMove(position.x, position.y + speed, 13);
        
        if ((speed < 0 && canMoveUp) || (speed > 0 && canMoveDown)) {
            position.y += speed;
        } else {
            speed *= -1;
            position.y += speed;
        }
    } else {
        boolean canMoveLeft = canMove(position.x - speed, position.y, 13);
        boolean canMoveRight = canMove(position.x + speed, position.y, 13);
        
        if ((speed < 0 && canMoveLeft) || (speed > 0 && canMoveRight)) {
            position.x += speed;
        } else {
            speed *= -1;
            position.x += speed;
        }
    }
    
    alien.display();
  }
  
  boolean canMove(float x, float y, int radius) {
    for (int i = -radius; i <= radius; i++) {
      for (int j = -radius; j <= radius; j++) {
        int pixelColor = get((int)x + i, (int)y + j);
        if (pixelColor == color(255)) {
          return false;
        }
      }
    }
      return true;
  }
  
  boolean detectPlayer(){
    color c = get((int)position.x, (int) position.y);
    if (c == color(#80ecff)){
      return true;
    } else{
      return false;
    }
  }
}
