public abstract class FindableObject {
  private boolean found;
  
  private FindableObject() {
    found = false;
    //img = loadImage("pretzel.png");
  }
  
  public void found() {
    found = true; 
  }
  
  public boolean isFound() {
    return found;
  }
  
  public void makeVisible(PImage img){
    image(img, 0, 0, 50, 50);
  }
}
