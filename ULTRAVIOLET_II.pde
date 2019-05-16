public final int GAME = 0, MENU = 1;

Player player;
Timer timer;
FindableObject bread, cheese, salami, lettuce, mayo, tomato, onion;
int score;
int screen;
float gameTimer; 

// Start screen variables
PImage startscreen;
PFont title;
int STATE;
float randX, randY;
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
    score = 0;
  }
}

private void runGame() {
  background(201, 21, 214);
  gameTimer += timer.timeDelta;
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
