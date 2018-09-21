/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 3
  * 21/09/2018
**/

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int MENU_SIZE_WIDTH = 200;
int MENU_SIZE_HEIGHT = 0;
int WIDTH = SCREEN_WIDTH - MENU_SIZE_WIDTH;
int HEIGHT = SCREEN_HEIGHT - MENU_SIZE_HEIGHT;
int xMin = -10, xMax = 10, yMin = -10, yMax = 10, zMin = -1, zMax = 1;
boolean control = false;

Polygon polygon;

void setup() {
  //Remember to change here when change SCREEN_WIDTH and SCREEN_HEIGHT
  size(800, 600);
  background(0);
  showMenu();
}

void draw() {
}

void keyPressed(){
    if (keyCode == 27){
        exit();
    }
    if (key == '1'){
      background(0);
      showMenu();
      polygon = new Polygon(1);
      control = true;
    }
    if(key == '2'){
      background(0);
      showMenu();
      polygon = new Polygon(2);
      control = true;
    }
    if (keyCode == UP){
      background(0);
      showMenu();
      if(control) polygon.move(0, 1, 0);
    }
    if (keyCode == DOWN){
      background(0);
      showMenu();
      if(control) polygon.move(0, -1, 0);
    }
    if (keyCode == LEFT){
      background(0);
      showMenu();
      if(control) polygon.move(-1, 0, 0);
    }
    if (keyCode == RIGHT){
      background(0);
      showMenu();
      if(control) polygon.move(1, 0, 0);
    }
    if (key == 'X' || key == 'x'){
      background(0);
      showMenu();
      if(control) polygon.rotationXY();
    }
    if (key == 'Z' || key == 'z'){
      background(0);
      showMenu();
      if(control) polygon.rotationZX();
    }
    if (key == 'Y' || key == 'y'){
      background(0);
      showMenu();
      if(control) polygon.rotationYZ();
    }
    if (key == 'S' || key == 's'){
      background(0);
      showMenu();
      if(control) polygon.customScale();
    }
    if (key == '+'){
      if(control) if (polygon.variation < 3) polygon.variation += 1;
    }
    if (key == '-'){
      if(control) if (polygon.variation > 1) polygon.variation -= 1;
    }
}

void showMenu(){
  textSize(16);
  text("Menu:", WIDTH, 30);
  text("1. Cube", WIDTH, 60);
  text("2. Pyramid", WIDTH, 90);
  text("Controls:", WIDTH, 150);
  text("Arrows. Move", WIDTH, 180);
  text("X. Rotation XY", WIDTH, 210);
  text("Z. Rotation ZX", WIDTH, 240);
  text("Y. Rotation YZ", WIDTH, 270);
  text("S. Scale", WIDTH, 300);
  text("+. Increase (+1x)", WIDTH, 360);
  text("-. Decrease (-1x)", WIDTH, 390);
}
