public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
FindableObject bread, cheese, salami, lettuce, mayo, tomato, onion;
int score;
int screen;
<<<<<<< HEAD
float gameTimer;
FindableObject pretzel;
PImage bread, cheese, salami, lettuce, mayo, tomato, onion, tiles;
=======
float gameTimer; 
>>>>>>> e4aff71872934946aa0dbe5a4dd14e36d7275b35

// Start screen variables
PImage startscreen;
PFont title;
int STATE;
float randX, randY;
<<<<<<< HEAD
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
  
=======
String[] images = {"bread.png", "cheese.png", "salami.png", "lettuce.png", "mayo.png", "tomato.png", "onion.png"};

void setup() {
  
  bread = new FindableObject(images[0]);
  cheese = new FindableObject(images[1]);
  salami = new FindableObject(images[2]);
  lettuce = new FindableObject(images[3]);
  mayo = new FindableObject(images[4]);
  tomato = new FindableObject(images[5]);
  onion = new FindableObject(images[6]);
  
  score = 0;
>>>>>>> e4aff71872934946aa0dbe5a4dd14e36d7275b35
  
  size(1400, 800);
  background(0, 0, 0);
  screen = GAME;
  gameTimer = 150;
  timer = new Timer();
  player = new Player();

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
<<<<<<< HEAD
    gameTimer = 160;
=======
    gameTimer = 0;
    score = 0;
>>>>>>> e4aff71872934946aa0dbe5a4dd14e36d7275b35
  }
}

private void runGame() {
  //Re-sized the background image and set the background to the image
  tiles.resize(1400, 800);
  background(tiles);
  gameTimer -= timer.timeDelta;
  print(gameTimer + "\n");
  player.update();
  
  //Collision handling
  if (int(player.x) <= int(cheese.x) + 20 && player.x >= cheese.x - 20 && int(player.y) >= int(cheese.y) - 20 && int(player.y) <= int(cheese.y) + 20){
    cheese.found = true;
    score += 1;
  }
  if (cheese.found == false) cheese.makeVisible();
  
  if (int(player.x) <= int(bread.x) + 20 && player.x >= bread.x - 20 && int(player.y) >= int(bread.y) - 20 && int(player.y) <= int(bread.y) + 20){
    bread.found = true;
    score += 1;
  }
  if (bread.found == false) bread.makeVisible();
  
  if (int(player.x) <= int(salami.x) + 20 && player.x >= salami.x - 20 && int(player.y) >= int(salami.y) - 20 && int(player.y) <= int(salami.y) + 20){
    salami.found = true;
    score += 1;
  }
  if (salami.found == false) salami.makeVisible();
  
  if (int(player.x) <= int(lettuce.x) + 20 && player.x >= lettuce.x - 20 && int(player.y) >= int(lettuce.y) - 20 && int(player.y) <= int(lettuce.y) + 20){
    lettuce.found = true;
    score += 1;
  }
  if (lettuce.found == false) lettuce.makeVisible();
  
  if (int(player.x) <= int(mayo.x) + 20 && player.x >= mayo.x - 20 && int(player.y) >= int(mayo.y) - 20 && int(player.y) <= int(mayo.y) + 20){
    mayo.found = true;
    score += 1;
  }
  if (mayo.found == false) mayo.makeVisible();
  
  if (int(player.x) <= int(tomato.x) + 20 && player.x >= tomato.x - 20 && int(player.y) >= int(tomato.y) - 20 && int(player.y) <= int(tomato.y) + 20){
    tomato.found = true;
    score += 1;
  }
  if (tomato.found == false) tomato.makeVisible();
  
  if (int(player.x) <= int(onion.x) + 20 && player.x >= onion.x - 20 && int(player.y) >= int(onion.y) - 20 && int(onion.y) <= int(onion.y) + 20){
    onion.found = true;
    score += 1;
  }
  if (onion.found == false) onion.makeVisible();
  
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
      float adjustBrightness = map(distance, 0, gameTimer/2, 2, 0.3);
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
