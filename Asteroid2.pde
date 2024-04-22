class Asteroid2 extends Asteroid1 {   
  Asteroid2(String imgPath, float pos_x, float pos_y, float vel_x, float vel_y) {
    super(imgPath, pos_x, pos_y, vel_x, vel_y);
  }
  
  int type() {
    return 2;
  }
}
