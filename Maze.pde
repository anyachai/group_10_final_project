class Maze{
  PImage[] mazes;
  String leading;
  String trailing;
  int x;
  int y;
  int level;
  int padding;
  
  Maze(String leading, String trailing, int x, int y, int level, int padding, int numLevels){
    this.x = x;
    this.y = y;
    this.level = level;
    this.mazes = new PImage[numLevels];
    
    for (int i = 0; i < numLevels; i++) {
      String imageName = leading + nf(i, padding) + trailing;
      //print(imageName);
      mazes[i] = loadImage(imageName);
    }
  }
  
  void display(int level){
    imageMode(CORNER);
    image(mazes[level], x, y);
    rectMode(CORNER);
    rect(25, 100, 450, 375);
  }

}
