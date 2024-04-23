class Item{
  PVector position;
  String image;
  PImage star;
  
  Item(PVector position, String image){
    this.position = position;
    star = loadImage(image);
  }
  
  void display(boolean on){
    if (on){
      imageMode(CENTER);
      image(star, position.x, position.y);
    }
  }
  
  boolean detectPlayer(boolean first){
    if (first){
      color c = get((int)position.x, (int) position.y);
      if (c == color(#80ecff)|c == color(#4f492e)){
        return true;
      } else{
        return false;
      }
    } else{
      return false;
    }
  }
}
