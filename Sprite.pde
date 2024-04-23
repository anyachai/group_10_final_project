class Sprite {
  PImage[] right;
  PImage[] left;
  PImage[] frames;
  int numFrames;
  int currentFrame;
  PVector position;
  Timer animationTimer;
  boolean applyTint;

  Sprite(PVector position, int numFrames, String leading, String trailing, int padding, int interval) {
    this.position = position;
    this.numFrames = numFrames;
    this.right = new PImage[numFrames];
    this.left = new PImage[numFrames];
    this.frames = new PImage[numFrames];
    
    for (int i = 0; i < numFrames; i++) {
        String imageName = leading + nf(i, padding) + trailing;
        frames[i] = loadImage(imageName);
    }
    
    this.animationTimer = new Timer(interval);
    this.animationTimer.start();
  }

  void update() {
    if (animationTimer.update()) {
      currentFrame = (currentFrame + 1) % numFrames;
    }
  }

  void display() {
    imageMode(CENTER);
    PImage img = frames[currentFrame];
    image(img, position.x, position.y, img.width, img.height);
  }
}
