public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
int screen;
float gameTimer;

void setup() {
  size(1400, 800);
  background(201, 21, 214);
  screen = GAME;
  gameTimer = 0;
  timer = new Timer();
  player = new Player();
}

void draw() {
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
