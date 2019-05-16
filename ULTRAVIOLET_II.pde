public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
int screen;
float gameTimer;
FindableObject pretzel;
PImage bread, cheese, salami, lettuce, mayo, tomato, onion, tiles;

// Start screen variables
PImage startscreen;
PFont title;
int STATE;
float randX, randY;
float[] randCoords = new float[200];
String[] images = {"bread.png", "cheese.png", "salami.png", "lettuce.png", "mayo.png", "tomato.png", "onion.png", "tilebackground.png"};

void setup() {
  bread = loadImage(images[0]);
  cheese = loadImage(images[1]);
  salami = loadImage(images[2]);
  lettuce = loadImage(images[3]);
  mayo = loadImage(images[4]);
  tomato = loadImage(images[5]);
  onion = loadImage(images[6]);
  tiles = loadImage(images[7]);
  
  
  size(1400, 800);
  background(0, 0, 0);
  screen = GAME;
  gameTimer = 0;
  timer = new Timer();
  player = new Player();
  
  for (int i = 0; i < 20; i += 2){
    randCoords[i] = int((random(50, 1350)));
    randCoords[i+1] = int((random(50, 750)));
  }

  // Start screen setup
  STATE = 1;
  startscreen = loadImage("ultra.png");
  image(startscreen, 0, 0, 1400, 800);
  title = createFont("font", 1000, true);
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
  }
}

public void changeScreen(int newScreen) {
  screen = newScreen;
  if (screen == GAME) {
    //Set the game timer to 0
    gameTimer = 0;
  }
}

private void runGame() {
  //Re-sized the background image and set the background to the image
  tiles.resize(1400, 800);
  background(tiles);
  gameTimer += timer.timeDelta;
  player.update();
  
  image(bread, randCoords[0], randCoords[1], 50, 50);
  image(cheese, randCoords[2], randCoords[3], 50, 50);
  image(salami, randCoords[4], randCoords[5], 50, 50);
  image(lettuce, randCoords[6], randCoords[7], 50, 50);
  image(mayo, randCoords[8], randCoords[9], 50, 50);
  image(tomato, randCoords[10], randCoords[11], 50, 50);
  image(onion, randCoords[12], randCoords[13], 50, 50);
  
  loadPixels();
 // Loop through each pixel in the window
  for (int x = 0; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {

      // Pixel location
      int loc = x + y*width;

      // Get R,G,B from each pixel
      float r = red  (pixels[loc]);
      float g = green(pixels[loc]);
      float b = blue (pixels[loc]);

      // Calculate an amount to change brightness
      // based on proximity to the mouse
      float distance = dist(x, y, mouseX, mouseY);

      // The closer the pixel is to the mouse, the lower the value of "distance" 
      // We want closer pixels to be brighter, however, so we invert the value using map()
      // Pixels with a distance of 50 (or greater) have a brightness of 0.0 (or negative which is equivalent to 0 here)
      // Pixels with a distance of 0 have a brightness of 1.0.
      //Where the value 50 is will change the radius of the light. 
      //The value 2 is the brightness of the light. Bigger the value the brighter and
      //more washed out things become.
      float adjustBrightness = map(distance, 0, 50, 2, 0);
      r *= adjustBrightness;
      g *= adjustBrightness;
      b *= adjustBrightness;

      // Constrain RGB to between 0-255
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      pixels[loc] = c;
    }
  }

  updatePixels();
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
