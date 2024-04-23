class ImgArray {
  PImage[] imgs;
  PVector position;
  int numFrames;
  String leading;
  String trailing;
  int padding;
  
  ImgArray(PVector position, int numFrames, String leading, String trailing, int padding) {
    this.position = position;
    this.numFrames = numFrames;
    this.leading = leading;
    this.trailing = trailing;
    this.padding = padding;
    
    imgs = new PImage[numFrames];
    for (int i = 0; i < numFrames; i++) {
      String imageName = leading + trailing;
      imgs[i] = loadImage(imageName);
    }
  }
  
  void display(int spacing) {
    float x = position.x;
    for (int i = 0; i < numFrames; i++) {
      image(imgs[i], x, position.y);
      x += imgs[i].width + spacing;
    }
  }
  
  void update(int indexToUpdate, String imageName) {
    if (indexToUpdate >= 0 && indexToUpdate < numFrames) {
      imgs[indexToUpdate] = loadImage(imageName);
    } else {
      println("Invalid index");
    }
  }
}
