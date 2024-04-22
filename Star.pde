class Star{
  PVector position;
  String image;
  PImage star;
  
  Star(PVector position, String image){
    this.position = position;
    star = loadImage(image);
  }
  
  void display(boolean on){
    if (on){
    imageMode(CENTER);
    image(star, position.x, position.y);
    } 
  }
  
  boolean detectPlayer(){
    color c = get((int)position.x, (int) position.y);
    if (c == color(#80ecff)){
      return true;
    } else{
      return false;
    }
  } 
  
}
