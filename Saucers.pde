class Saucers {
    int saucerLimit; // Maximum number of saucers
    ArrayList<SaucerA> saucerList = new ArrayList<SaucerA>();
    
    Saucers(int saucerPopulation) {
        saucerLimit = saucerPopulation;
        for (int i = 0; i < saucerLimit; i++) {
            //saucerList.add(newSaucer(i));
            switch(i%3) {
                case 0: 
                    saucerList.add(new SaucerC("saucerC", 4, true, 0, 0, 0, 0));
                    break;
                case 1:
                    saucerList.add(new SaucerB("saucerB", 3, true, 0, 0, 0, 0));
                    break;
                case 2:
                    saucerList.add(new SaucerA("saucerA", 2, true, 0, 0, 0, 0));
                    break;
            }
        }
    }
    
    // Randomly generate new saucer on the edge
    //SaucerA newSaucer() {
    //    float r = random(3);
        
    //    if (r <= 1) {
    //        return new SaucerA("saucerA", 2, true, 0, 0, 0, 0);
    //    } else if (r <= 2) {
    //        return new SaucerB("saucerB", 3, true, 0, 0, 0, 0);
    //    } else {
    //        return new SaucerC("saucerC", 4, true, 0, 0, 0, 0);
    //    }
    //}
    
    void display() {
        for (SaucerA i : saucerList) {
            i.display();
        }
        
        // Enable or disable new saucers to spawn
        //if (saucerList.size() < saucerLimit) {
        //    saucerList.add(newSaucer());
        //}
    }
    
    void burst(int i, float pos_x, float pos_y, float vel_x, float vel_y) {         
        switch(saucerList.get(i).type) {
            case 2: 
                saucerList.add(new SaucerA("saucerA", 2, false, 
                               pos_x + 12*vel_y, pos_y - 12*vel_x, vel_y, -vel_x));
                saucerList.add(new SaucerA("saucerA", 2, false,
                               pos_x - 12*vel_y, pos_y + 12*vel_x, -vel_y, vel_x));
                break;
            case 3:
                saucerList.add(new SaucerB("saucerB", 3, false,
                               pos_x + 16*vel_y, pos_y - 16*vel_x, vel_y, -vel_x));

                saucerList.add(new SaucerB("saucerB", 3, false,
                               pos_x - 16*vel_y, pos_y + 16*vel_x, -vel_y, vel_x));
                break;
        }
        
        saucerList.remove(i);
    }
}

class SaucerA {
    PImage outerBody, innerBody1, innerBody2; // First layer, On & off states of the second layer
    PVector pos, vel; // Position and Velocity of saucer
    int radius; // Size of the saucer
    float[] angPos; // Angular positions of the layers
    float[] angVel; // Angular velocity of the layers
    int[] flashTimes; // flash times for flashable components
    int type;
  
    SaucerA(String fileName, int animationLayers, boolean edgeSpawn, 
            float spawnX, float spawnY, float velX, float velY) {
        // Initialize rotating layers/components of the saucer
        outerBody = loadImage(fileName + 0 + ".png");
        innerBody1 = loadImage(fileName + 1 + ".png");
        innerBody2 = loadImage(fileName + 2 + ".png");
        radius = outerBody.width/2;
        
        // Initialize angular positions & velocity of each rotating layer
        angPos = new float[animationLayers];
        angVel = new float[animationLayers];
        for (int i = 0; i < animationLayers; i++) {
            angPos[i] = random(1);
            angVel[i] = random(0.001, 0.006);
        }
        
        // Initialize flash times for flashable components
        flashTimes = new int[animationLayers - 1];
        for (int i = 0; i < animationLayers - 1; i++) {
            flashTimes[i] = int(random(50));
        }
    
        // Spawn on the edge or on the screen
        if (edgeSpawn) {
            spawnOnEdge();
            vel = PVector.random2D().mult(3);
        } else {
            pos = new PVector(spawnX, spawnY);
            vel = new PVector(velX, velY);
        }
        
        // Saucer type
        type = 1;
    }
  
    void spawnOnEdge() {
        float r = random(4);

        if (r < 1) {
            pos = new PVector(width*random(1), -radius);
        } else if (r < 2) {
            pos = new PVector(width*random(1), height+radius);
        } else if (r < 3) {
            pos = new PVector(-radius, height*random(1));
        } else {
            pos = new PVector(width+radius, height*random(1));
        }
    }

    void display() {
        pushMatrix();
        translate(pos.x, pos.y);
        // Animate first rotating layer
        animateBody(false, angPos[0], 0, outerBody, outerBody);
        // Animate second rotating layer
        animateBody(true, -angPos[1], flashTimes[0], innerBody1, innerBody2);
        popMatrix();

        updateAngPos();
        move();  
    }

    // Animating the flashing components
    void animateBody(boolean isFlashing, float angPos, int flashTime, PImage flashOn, PImage flashOff) {
        imageMode(CENTER);
        pushMatrix();
        rotate(TWO_PI * angPos);
        if (isFlashing) {
            if ((frameCount % 60 >= flashTime) && 
                (frameCount % 60 <= flashTime + 10)) {
                image(flashOn, 0, 0);
            } else {
                image(flashOff, 0, 0);
            }
        } else {
            image(flashOn, 0, 0);
        }
        popMatrix();
    }
    
    void updateAngPos() {
        for (int i = 0; i < angPos.length; i++) {
            angPos[i] = (angPos[i] + angVel[i]) % 1;
        }
    }
  
    void move() {
        pos.add(vel);

        // Saucers wrap around at the boundary
        if (pos.x < -2*radius) {
            pos.x += width + 4*radius;
        } else if (pos.x > width + 2*radius) {
            pos.x -= width + 4*radius;
        } else if (pos.y < -2*radius) {
            pos.y += height + 4*radius;
        } else if (pos.y > height + 2*radius) {
            pos.y -= height + 4*radius;
        }
    }
}

class SaucerB extends SaucerA {
    PImage innerBody3, innerBody4; // On & off states of the third layer
    
    SaucerB(String fileName, int animationLayers, boolean edgeSpawn, 
            float spawnX, float spawnY, float velX, float velY) {
        super(fileName, animationLayers, edgeSpawn, spawnX, spawnY, velX, velY);
        innerBody3 = loadImage(fileName + 3 + ".png");
        innerBody4 = loadImage(fileName + 4 + ".png");
        type = 2;
    }
    
    void display() {
        pushMatrix();
        translate(pos.x, pos.y);
        animateBody(false, angPos[0], 0, outerBody, outerBody);
        animateBody(true, -angPos[1], flashTimes[0], innerBody1, innerBody2);
        // Animate third rotating layer
        animateBody(true, angPos[2], flashTimes[1], innerBody3, innerBody4);
        popMatrix();

        updateAngPos();
        move();  
    }
}

class SaucerC extends SaucerB {
    PImage innerBody5, innerBody6; // On & off states of the fourth layer
    
    SaucerC(String fileName, int animationLayers, boolean edgeSpawn, 
            float spawnX, float spawnY, float velX, float velY) {
        super(fileName, animationLayers, edgeSpawn, spawnX, spawnY, velX, velY);
        innerBody5 = loadImage(fileName + 5 + ".png");
        innerBody6 = loadImage(fileName + 6 + ".png");
        type = 3;
    }
    
    void display() {
        pushMatrix();
        translate(pos.x, pos.y);
        animateBody(false, angPos[0], 0, outerBody, outerBody);
        animateBody(true, -angPos[1], flashTimes[0], innerBody1, innerBody2);
        animateBody(true, -angPos[1], flashTimes[1], innerBody3, innerBody4);
        // Animate fourth rotating layer
        animateBody(true, angPos[2], flashTimes[2], innerBody5, innerBody6);
        popMatrix();

        updateAngPos();
        move();  
    }
}
