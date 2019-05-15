public abstract class FindableObject {
  private boolean found;
  
  private FindableObject() {
    found = false;
  }
  
  public void found() {
    found = true; 
  }
  
  public boolean isFound() {
    return found;
  }
}
