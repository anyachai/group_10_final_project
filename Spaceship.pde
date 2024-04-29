class Spaceship {
    PImage shipSprite = loadImage("spaceship.png");
    PVector pos = new PVector(width/2, height/2);
    float angle = 0;
    PVector vel = new PVector(10,0);
    PVector topPoint = new PVector(0,0), 
    leftPoint = new PVector(0,0), rightPoint = new PVector(0,0);

    void display() {
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(angle + HALF_PI);
        image(shipSprite, 0, 0);
        popMatrix();
        
        if (upPressed) {
            pos.add(PVector.fromAngle(angle).mult(5));
        } if (downPressed) {
            pos.add(PVector.fromAngle(angle).mult(-5));
        } if (leftPressed) {
            angle -= 0.1;
        } if (rightPressed) {
            angle += 0.1;
        }
        
        topPoint = pos.copy().add(PVector.fromAngle(angle).mult(10));
        leftPoint = pos.copy().add(PVector.fromAngle(angle+2.3562).mult(10));
        rightPoint = pos.copy().add(PVector.fromAngle(angle-2.3562).mult(10));
        //fill(#ffffff);
        //ellipse(topPoint.x, topPoint.y, 10, 10);
        //ellipse(leftPoint.x, leftPoint.y, 10, 10);
        //ellipse(rightPoint.x, rightPoint.y, 10, 10);
        
        if (pos.x < -30) {
            pos.x += width + 30;
        } else if (pos.x > width + 30) {
            pos.x -= width + 30;
        } else if (pos.y < -30) {
            pos.y += height + 30;
        } else if (pos.y > height + 30) {
            pos.y -= height + 30;
        }
    }
}

class Laser {
    PVector pos, vel;
    
    Laser(PVector _pos, float _angle) {
        pos = _pos;
        vel = PVector.fromAngle(_angle).mult(10);
    }
    
    void display() {
        ellipseMode(CENTER);
        fill(#ffff00);
        noStroke();
        ellipse(pos.x, pos.y, 10, 10);
        pos.add(vel);
    }
    
    boolean ofScreen() {
        return pos.x < 0 || pos.x > 500 || pos.y < 0 || pos.y > 500;
    }
}
