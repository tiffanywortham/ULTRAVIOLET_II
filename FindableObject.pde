public abstract class FindableObject {
  protected boolean flagged;
  
  protected FindableObject() {
    flagged = false;
  }
  
  public void flag() {
    flagged = true; 
  }
  
  public boolean isFlagged() {
    return flagged;
  }
}
