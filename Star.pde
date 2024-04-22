class Star{
  PVector position;
  String image;
  PImage star;
  
  Star(PVector position, String image){
    this.position = position;
    star = loadImage(image);
  }
  
  void display(){
    imageMode(CENTER);
    image(star, position.x, position.y);
  }
  
  boolean detectPlayer(boolean first){
    if (first){
      color c = get((int)position.x, (int) position.y);
      if (c == color(#80ecff)){
        return true;
      } else{
        return false;
      }
    } else{
      return false;
    }
  }
  
}
