public class Player {
  private float speed;
  private float right, left, up, down;
  private float x, y;
  private float radius;

  public Player() {
    //Player properties
    radius = 20;
    speed = 5;  
    x = width/2;
    y = height/2;  
  }

  public void update() {
    //Update game
    float newX = constrain(x + (right - left), radius, width-radius);
    float newY = constrain(y + (down - up), radius, height-radius);
    boolean hasMoved = newX != x || newY != y;
    x = newX;
    y = newY;
    display();
  }

  public void move(float x, float y) {
    //Set the state of the player's movement, called in keyPressed()
    if (x == 1)
      right = speed;
    else if (x == -1)
      left = speed;
    else if (y == 1)
      up = speed;
    else if (y == -1)
      down = speed;
  }
  
  public void stopMove(float x, float y) {
    //Set the state of the player's movement, called in keyReleased()
    if (x == 1)
      right = 0;
    else if (x == -1)
      left = 0;
    else if (y == 1)
      up = 0;
    else if (y == -1)
      down = 0;
  }

  private void display() {   
    //Display flashlight
    fill(100);
    stroke(0);
    strokeWeight(2);
    
    //Calculate rotation for flashlight
    PVector mDir = getMouseDirection().mult(radius + 15);
    PVector pDir = getMouseDirection().rotate(PI/2).mult(5);
    quad(
      x + pDir.x, y + pDir.y,
      x + pDir.x + mDir.x, y + pDir.y + mDir.y,
      x - pDir.x + mDir.x, y - pDir.y + mDir.y,
      x - pDir.x, y - pDir.y
    );

    //Display player
    fill(70, 200, 100);
    stroke(0);
    strokeWeight(1);
    ellipse(x, y, radius*2, radius*2);
  }
  
  private PVector getMouseDirection() {
    return new PVector(mouseX - x, mouseY - y).normalize();
  }
}
