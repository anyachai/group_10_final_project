class Asteroids {
  ArrayList<Asteroid1> List = new ArrayList<Asteroid1>();
  //Asteroid1[] List = new Asteroid1[7];

  Asteroids() {
    for (int i = 0; i < 12; i++) {
      List.add(newAsteroid());
    }
    //for (int i = 0; i < List.length; i++) {
    //  if (i <= 4) {
    //    List[i] = new Asteroid1("asteroid1.png");
    //  } else if (i < 6) {
    //    List[i] = new Asteroid2("asteroid2.png");
    //  } else {
    //    List[i] = new Asteroid3("asteroid3.png");
    //  }
  }
  
  void display() {
    for (Asteroid1 i : List) {
      i.display();
    }
    
    if (List.size() < 12) {
      List.add(newAsteroid());
    }
  }
  
  Asteroid1 newAsteroid() {
    float r = random(3);
      
    if (r <= 1) {
      return new Asteroid1("asteroid1.png", 0, 0, 0, 0);
    } else if (r <= 2) {
      return new Asteroid2("asteroid2.png", 0, 0, 0, 0);
    } else {
      return new Asteroid3("asteroid3.png", 0, 0, 0, 0);
    }
  }
  
  void burst(int i, float bul_vx, float bul_vy) {
    int type = List.get(i).type();
    float pos_x = List.get(i).pos.x;
    float pos_y = List.get(i).pos.y;
    //float vel_x = -List.get(i).vel.y;
    //float vel_y = List.get(i).vel.x;
    float vel_x = -bul_vy;
    float vel_y = bul_vx;
    
    if (type == 3) {
      List.add(new Asteroid2("asteroid2.png", pos_x + 48*vel_x, 
                                              pos_y + 48*vel_y, 
                                              vel_x, vel_y));
      List.add(new Asteroid2("asteroid2.png", pos_x - 48*vel_x, 
                                              pos_y - 48*vel_y, 
                                              -vel_x, -vel_y));
    } else if (type == 2) {
      List.add(new Asteroid1("asteroid1.png", pos_x + 32*vel_x, 
                                              pos_y + 32*vel_y, 
                                              vel_x, vel_y));
      List.add(new Asteroid1("asteroid1.png", pos_x - 32*vel_x, 
                                              pos_y - 32*vel_y, 
                                              -vel_x, -vel_y));
    }
    List.remove(i);
  }
}
