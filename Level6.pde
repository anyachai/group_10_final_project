class Level6 {
    Saucers saucers = new Saucers(6);
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
                    
                    // Activate when all saucers are destroyed
                    if (saucers.saucerList.size() == 0) {
                        saucers = new Saucers(6);
                        ship = new Spaceship();
                        lasers.clear();
                        playing.toggleOff();
                        endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
                        pauseScreen.started = false;
                        return;
                    }
                }
            }
        }
    }
    
    void shipToSaucer() {
        float top_x = ship.topPoint.x, top_y = ship.topPoint.y, 
              left_x = ship.leftPoint.x, left_y = ship.leftPoint.y, 
              right_x = ship.rightPoint.x, right_y = ship.rightPoint.y;
        float saucer_x, saucer_y;
        int saucer_rad;
        
        for (int j = saucers.saucerList.size() - 1; j >= 0; j--) {
            saucer_x = saucers.saucerList.get(j).pos.x;
            saucer_y = saucers.saucerList.get(j).pos.y;
            saucer_rad = saucers.saucerList.get(j).radius;
      
            // If ship touches saucer, destroy or split it
            if ((sq(top_x-saucer_x) + sq(top_y-saucer_y) <= sq(saucer_rad)) ||
                (sq(left_x-saucer_x) + sq(left_y-saucer_y) <= sq(saucer_rad)) ||
                (sq(right_x-saucer_x) + sq(right_y-saucer_y) <= sq(saucer_rad))) {
                // Game Over goes here.
                saucers = new Saucers(6);
                ship = new Spaceship();
                lasers.clear();
                saveScreen.updateTable();
                playing.toggleOff();
                endScreen.onScreen = true; // CHANGE TO GAME OVER SCREEN
                pauseScreen.started = false;
                break;
            }
        }
    }
    
    int returnNxtLvl() {
        return 6;
    }
}
