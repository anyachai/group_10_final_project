class Asteroid1 {
  PImage img;
  PVector pos, vel;
  int radius; 
  float rad = 0;
  
  Asteroid1(String imgPath, float pos_x, float pos_y, float vel_x, float vel_y) { 
    img = loadImage(imgPath);
    radius = img.width/2;
    if ((vel_x == 0) && (vel_y == 0)) {
      this.pos = edgeSpawn(radius);
      this.vel = PVector.random2D();
    } else {
      this.pos = new PVector(pos_x, pos_y);
      this.vel = new PVector(vel_x, vel_y);
    }
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(TWO_PI * rad);
    image(img, -radius, -radius);
    popMatrix();
    
    rad = (rad + 0.005) % 1;
    
    pos.add(vel);
    
    if (pos.x < -radius) {
      pos.x += width + 2 * radius;
    } else if (pos.x > width + radius) {
      pos.x -= width + 2 * radius;
    } else if (pos.y < -radius) {
      pos.y += height + 2 * radius;
    } else if (pos.y > height + radius) {
      pos.y -= height + 2 * radius;
    }
  }
  
  PVector edgeSpawn(int radius) {
    float r = random(4);
    
    if (r <= 1) {
      return new PVector(width*random(1), -radius);
    } else if (r <= 2) {
      return new PVector(width*random(1), height+radius);
    } else if (r <= 3) {
      return new PVector(-radius, height*random(1));
    } else {
      return new PVector(width+radius, height*random(1));
    }
  }
  
  int type() {
    return 1;
  }
    
  //void spawn() {
  //  pos = initialPos(radius);
  //}
}
