class Asteroid3 extends Asteroid1 { 
  Asteroid3(String imgPath, float pos_x, float pos_y, float vel_x, float vel_y) {
    super(imgPath, pos_x, pos_y, vel_x, vel_y);
  }
  
  int type() {
    return 3;
  }
}
