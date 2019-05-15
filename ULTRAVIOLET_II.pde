public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
int screen;
float gameTimer;
FindableObject pretzel;
PImage img;

// Start screen variables
PImage startscreen;
PFont title;
int STATE;

void setup() {
  img = loadImage("pretzel.png");
  size(1400, 800);
  background(0, 0, 0);
  screen = GAME;
  gameTimer = 0;
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
    gameTimer = 0;
  }
}

private void runGame() {
  background(201, 21, 214);
  gameTimer += timer.timeDelta;
  player.update();
  
  pretzel.makeVisible(img);
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
