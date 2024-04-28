class Level6 {
    Saucers saucers = new Saucers(8);
    Spaceship ship = new Spaceship();
    ArrayList<Laser> lasers = new ArrayList<Laser>();
    int cooldown = 0;
    
    void update() {
        saucers.display(); // Show all saucers
        ship.display(); // Show player
        
        if (spacePressed && (cooldown == 0)) {
            // Pass the copy. Do not pass the reference!
            lasers.add(new Laser(ship.pos.copy(), ship.angle));
            cooldown = 10;
        }
        if (cooldown > 0) {cooldown -= 1;} // Cooldown timer
        
        for (int i = lasers.size() - 1; i >= 0; i--) {
            lasers.get(i).display();
            
            if (lasers.get(i).ofScreen()) {
                // Remove lasers off screen
                lasers.remove(lasers.get(i));
            }
        }
        
        // Destroy saucers with lasers
        laserToSaucer();
        shipToSaucer();
    }

    void laserToSaucer() {
        float laser_x, laser_y, saucer_x, saucer_y, laser_vx, laser_vy;
        int saucer_rad;
      
        for (int i = lasers.size() - 1; i >= 0; i--) {
            laser_x = lasers.get(i).pos.x;
            laser_y = lasers.get(i).pos.y;
        
            for (int j = saucers.saucerList.size() - 1; j >= 0; j--) {
                saucer_x = saucers.saucerList.get(j).pos.x;
                saucer_y = saucers.saucerList.get(j).pos.y;
                saucer_rad = saucers.saucerList.get(j).radius;
          
                // If laser touches saucer, destroy or split it
                if (sq(laser_x-saucer_x) + sq(laser_y-saucer_y) <= sq(saucer_rad)) {
                    laser_vx = lasers.get(i).vel.x * 0.3;
                    laser_vy = lasers.get(i).vel.y * 0.3;
                    saucers.burst(j, saucer_x, saucer_y, laser_vx, laser_vy);
                    //currentScore++;
                }
            }
        }
    }
    
    void shipToSaucer() {
        float saucer_x, saucer_y;
        int saucer_rad;
      
        
        for (int j = saucers.saucerList.size() - 1; j >= 0; j--) {
            saucer_x = saucers.saucerList.get(j).pos.x;
            saucer_y = saucers.saucerList.get(j).pos.y;
            saucer_rad = saucers.saucerList.get(j).radius;
      
            // If laser touches saucer, destroy or split it
            if (sq(ship.pos.x-saucer_x) + sq(ship.pos.y-saucer_y) <= sq(saucer_rad)) {
                // Game Over goes here.
                noLoop();
            }
        }
    }
}
