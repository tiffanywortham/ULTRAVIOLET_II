public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
int screen;
float gameTimer;

// Start screen variables
PImage startscreen, flashlight;
PFont title;
int STATE;

void setup() {
  size(1400, 800);
  background(0, 0, 0);
  screen = GAME;
  gameTimer = 0;
  timer = new Timer();
  player = new Player();
  
  // Flashlight Setup
  flashlight = loadImage("flashlight.jpg");
  flashlight.loadPixels();

  // Start screen setup
  STATE = 1;
  startscreen = loadImage("ultra.png");
  image(startscreen, 0, 0, 1400, 800);
  title = createFont("Georgia", 1000, true);
}

void draw() {
  // If in STATE 1, show titlescreen
  if(STATE == 1) {
    textAlign(CENTER);
    text("PRESS ANY KEY", 700, 700);
    if(keyPressed == true) {
      STATE = 2;
    }
  }
  // Else if in STATE 2, show game
  if(STATE == 2) {
    timer.update();
  
    switch (screen) {
    //Determine whether to show game screen, or menu screen
    case GAME: 
      runGame();
      break;
    case MENU:
      menu();
      break;
    }
    
    tint(255, 0);
    flashlight();
  }
}

public void changeScreen(int newScreen) {
  screen = newScreen;
  
  if (screen == GAME) {
    //Set the game timer to 0
    gameTimer = 0;
  }
}

private void flashlight() {
  for (int x = 0; x < flashlight.width; x++) {
    for (int y = 0; y < flashlight.height; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*flashlight.width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red (flashlight.pixels[loc]);
      //g = green (img.pixels[loc]);
      //b = blue (img.pixels[loc]);
      // Calculate an amount to change brightness based on proximity to the mouse
      float maxdist = 50;//dist(0,0,width,height);
      float d = dist(x, y, mouseX, mouseY);
      float adjustbrightness = 255*(maxdist-d)/maxdist;
      r += adjustbrightness;
      //g += adjustbrightness;
      //b += adjustbrightness;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255);
      //g = constrain(g, 0, 255);
      //b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      //color c = color(r, g, b);
      color c = color(r);
      pixels[y*width + x] = c;
    }
  }
  updatePixels();
}

private void runGame() {
  background(201, 21, 214);
  gameTimer += timer.timeDelta;
  player.update();
}

private void menu(){
  
}

void keyPressed() {
  if (screen == GAME) {
    if (keyCode == UP) player.move(0, 1);
    if (keyCode == DOWN) player.move(0, -1);
    if (keyCode == RIGHT) player.move(1, 0);
    if (keyCode == LEFT) player.move(-1, 0);
  }
}

void keyReleased() {
  if (screen == GAME) {
    if (keyCode == UP) player.stopMove(0, 1);
    if (keyCode == DOWN) player.stopMove(0, -1);
    if (keyCode == RIGHT) player.stopMove(1, 0);
    if (keyCode == LEFT) player.stopMove(-1, 0);
  }
}
