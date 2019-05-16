class FindableObject {
  boolean found;
  PImage img;
  float xPos, yPos;
  float x, y;
  
  FindableObject(String imgName) {
    found = false;
    img = loadImage(imgName);
    xPos = random(0, 1350);
    yPos = random(0, 750);
    
    x = this.xPos;
    y = this.yPos;
  }
  
  void found() {
    found = true; 
  }
  
  boolean isFound() {
    return found;
  }
  
  void makeVisible(){
    image(img, xPos, yPos, 50, 50);
  }
  
}
