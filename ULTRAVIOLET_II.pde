public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
int screen;
float gameTimer;
FindableObject pretzel;
PImage bread, cheese, salami, lettuce, mayo, tomato, onion;

// Start screen variables
PImage startscreen, flashlight;
PFont title;
int STATE;
float randX, randY;
float[] randCoords = new float[200];
String[] images = {"bread.png", "cheese.png", "salami.png", "lettuce.png", "mayo.png", "tomato.png", "onion.png"};

void setup() {
  bread = loadImage(images[0]);
  cheese = loadImage(images[1]);
  salami = loadImage(images[2]);
  lettuce = loadImage(images[3]);
  mayo = loadImage(images[4]);
  tomato = loadImage(images[5]);
  onion = loadImage(images[6]);
  
  size(1400, 800);
  background(0, 0, 0);
  screen = GAME;
  gameTimer = 0;
  timer = new Timer();
  player = new Player();
  
<<<<<<< HEAD
  // Flashlight Setup
  flashlight = loadImage("flashlight.jpg");
  flashlight.loadPixels();
=======
  for (int i = 0; i < 20; i += 2){
    randCoords[i] = int((random(50, 1350)));
    randCoords[i+1] = int((random(50, 750)));
  }
>>>>>>> ba74502c26a605f427f6f88462916ea4b80e27c4

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
  
  image(bread, randCoords[0], randCoords[1], 50, 50);
  image(cheese, randCoords[2], randCoords[3], 50, 50);
  image(salami, randCoords[4], randCoords[5], 50, 50);
  image(lettuce, randCoords[6], randCoords[7], 50, 50);
  image(mayo, randCoords[8], randCoords[9], 50, 50);
  image(tomato, randCoords[10], randCoords[11], 50, 50);
  image(onion, randCoords[12], randCoords[13], 50, 50);
  
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
