public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
FindableObject bread, cheese, salami, lettuce, mayo, tomato, onion;
int score, screen;
PFont f;
float gameTimer;
FindableObject pretzel;

// Start screen variables
PImage startscreen, tiles;
PFont title;
int STATE, endTime = 0;
float randX, randY;
float[] randCoords = new float[200];
String[] images = {"bread.png", "cheese.png", "salami.png", "lettuce.png", "mayo.png", "tomato.png", "onion.png", "tilebackground.png"};

void setup() {
  bread = new FindableObject(images[0]);
  cheese = new FindableObject(images[1]);
  salami = new FindableObject(images[2]);
  lettuce = new FindableObject(images[3]);
  mayo = new FindableObject(images[4]);
  tomato = new FindableObject(images[5]);
  onion = new FindableObject(images[6]);
  tiles = loadImage(images[7]);
  
  score = 0;
  size(1400, 800);
  background(0);
  screen = GAME;
  gameTimer = 180;
  timer = new Timer();
  player = new Player();

  // Start screen setup
  STATE = 1;
  startscreen = loadImage("ultra.png");
  image(startscreen, 0, 0, 1400, 800);
  title = createFont("Georgia", 1000, true);
  f = createFont("Poor Richard", 48);
}

void draw() {
  // If in STATE 1, show titlescreen
  if(STATE == 1) {
    textAlign(CENTER);
    text("PRESS ANY KEY", 700, 700);
    if(keyPressed == true) {
      score = 0;
      bread.found = false;
      salami.found = false;
      lettuce.found = false;
      mayo.found = false;
      tomato.found = false;
      onion.found = false;
      cheese.found = false;
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
  if(STATE == 3) {
    background(0);
    textFont(f);
    text("You have been swallowed by the darkness", 700, 400);
  }
  if(STATE == 4) {
    background(165, 36, 165);
    textFont(f);
    fill(0);
    endTime += 1;
    text("You consumed the sandwich before the darkness consumed you.", 650, 400);
    if (endTime >= 120) {
      STATE = 1;
      endTime = 0;
      gameTimer = 180;
    }
  }
}

public void changeScreen(int newScreen) {
  screen = newScreen;
  if (screen == GAME) {
    gameTimer = 180;
    score = 0;
  }
}

private void runGame() {
  //Re-sized the background image and set the background to the image
  tiles.resize(1400, 800);
  background(tiles);
  gameTimer -= timer.timeDelta;
  player.update();
  
  //Collision handling
  if (int(player.x) <= int(cheese.x) + 50 && player.x + 40 >= cheese.x && int(player.y) + 40 >= int(cheese.y) && int(player.y) <= int(cheese.y) + 40){
    if (!cheese.isFound()) {
      cheese.found = true;
      score += 1;
    }
  }
  if (cheese.found == false) cheese.makeVisible();
  
  if (int(player.x) <= int(bread.x) + 50 && player.x + 40 >= bread.x && int(player.y) + 40 >= int(bread.y) && int(player.y) <= int(bread.y) + 40){
    if(!bread.isFound()) {
      bread.found = true;
      score += 1;
    }
  }
  if (bread.found == false) bread.makeVisible();
  
  if (int(player.x) <= int(salami.x) + 50 && player.x + 40 >= salami.x && int(player.y) + 40 >= int(salami.y) && int(player.y) <= int(salami.y) + 40){
    if (!salami.isFound()) {
      score += 1;
      salami.found = true;
    }
  }
  if (salami.found == false) salami.makeVisible();
  
  if (int(player.x) <= int(lettuce.x) + 50 && player.x + 40 >= lettuce.x && int(player.y) + 40 >= int(lettuce.y) && int(player.y) <= int(lettuce.y) + 40){
    if(!lettuce.isFound()) {
      lettuce.found = true;
      score += 1;
    }
  }
  if (lettuce.found == false) lettuce.makeVisible();
  
  if (int(player.x) <= int(mayo.x) + 50 && player.x + 40 >= mayo.x && int(player.y) + 40 >= int(mayo.y) && int(player.y) <= int(mayo.y) + 40){
    if (!mayo.isFound()) {
      mayo.found = true;
      score += 1;
    }
  }
  if (mayo.found == false) mayo.makeVisible();
  
  if (int(player.x) <= int(tomato.x) + 50 && player.x + 40 >= tomato.x && int(player.y) + 40 >= int(tomato.y) && int(player.y) <= int(tomato.y) + 40){
    if(!tomato.isFound()) {
      tomato.found = true;
      score += 1;
    }
  }
  if (tomato.found == false) tomato.makeVisible();
  
  if (int(player.x) <= int(onion.x) + 50 && player.x + 40 >= onion.x && int(player.y) + 40 >= int(onion.y) && int(player.y) <= int(onion.y) + 40){
    if (!onion.isFound()) {
      onion.found = true;
      score += 1;
    }
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
      //The value 2 is the brightness of the light. Bigger the value the brighter and
      //more washed out things become.
      float adjustBrightness = map(distance, 0, gameTimer/2, 1.7, 0.3);
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
  if (score == 7) {
    STATE = 4;
  }
  if (gameTimer <= 70) {
    gameTimer -= 3;
  }
  if (gameTimer <= 17) {
    STATE = 3;
  }
}

private void menu(){
  
}

void keyPressed() {
  if (screen == GAME) {
    if (keyCode == UP) player.move(0, 1);
    if (keyCode == DOWN) player.move(0, -1);
    if (keyCode == RIGHT) player.move(1, 0);
    if (keyCode == LEFT) player.move(-1, 0);
    if (key == 'w') player.move(0, 1);
    if (key == 's') player.move(0, -1);
    if (key == 'd') player.move(1, 0);
    if (key == 'a') player.move(-1, 0);
  }
}

void keyReleased() {
  if (screen == GAME) {
    if (keyCode == UP) player.stopMove(0, 1);
    if (keyCode == DOWN) player.stopMove(0, -1);
    if (keyCode == RIGHT) player.stopMove(1, 0);
    if (keyCode == LEFT) player.stopMove(-1, 0);
    if (key == 'w') player.stopMove(0, 1);
    if (key == 's') player.stopMove(0, -1);
    if (key == 'd') player.stopMove(1, 0);
    if (key == 'a') player.stopMove(-1, 0);
  }
}
