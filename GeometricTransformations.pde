/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 56
  * 15/12/2018
**/

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int MENU_SIZE_WIDTH = 200;
int MENU_SIZE_HEIGHT = 0;
int WIDTH = SCREEN_WIDTH - MENU_SIZE_WIDTH;
int HEIGHT = SCREEN_HEIGHT - MENU_SIZE_HEIGHT;
int xMin = -10, xMax = 10, yMin = -10, yMax = 10, zMin = -1, zMax = 1;
boolean control = false;

ArrayList<Polygon> polygons;
Polygon polygon;
void setup() {
  //Remember to change here when change SCREEN_WIDTH and SCREEN_HEIGHT
  size(800, 600);
  background(0);
  
  readFigure();
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
      polygon = new Polygon(1);
      control = true;
      showMenu();
    }
    if(key == '2'){
      background(0);
      polygon = new Polygon(2);
      control = true;
      showMenu();
    }
    if (keyCode == UP){
      background(0);
      if(control) polygon.move(0, 1, 0, true);
      showMenu();
    }
    if (keyCode == DOWN){
      background(0);
      if(control) polygon.move(0, -1, 0, true);
      showMenu();
    }
    if (keyCode == LEFT){
      background(0);
      if(control) polygon.move(-1, 0, 0, true);
      showMenu();
    }
    if (keyCode == RIGHT){
      background(0);
      if(control) polygon.move(1, 0, 0, true);
      showMenu();
    }
    if (key == 'X' || key == 'x'){
      background(0);
      if(control) polygon.rotation(15, 1);
      showMenu();
    }
    if (key == 'Z' || key == 'z'){
      background(0);
      if(control) polygon.rotation(15, 2);
      showMenu();
    }
    if (key == 'Y' || key == 'y'){
      background(0);
      if(control) polygon.rotation(15, 3);
      showMenu();
    }
    if (key == 'S' || key == 's'){
      background(0);
      if(control) polygon.customScale(0.9, 0.9, 0.9, true);
      showMenu();
    }
    if (key == 'P' || key == 'p'){
      background(0);
      if(control) {
        if(polygon.projection < 5) polygon.projection += 1;
        else polygon.projection = 1;
        polygon.selectProjection();
      }
      showMenu();
    }
    if (key == '+'){
      if(control) if (polygon.variation < 3) polygon.variation += 0.5;
    }
    if (key == '-'){
      if(control) if (polygon.variation > 0.6) polygon.variation -= 0.5;
    }
}


void readFigure(){
  String[] figure = loadStrings("figure.dat");
  int aux = 0;
  //2a linha: universo
  aux = 1;
  String currentLine = figure[aux];
  int[] univ = int(split(currentLine, ' '));
  this.xMin = univ[0];
  this.xMax = univ[1];
  this.yMin = univ[2];
  this.yMax = univ[3];
  
  //3a linha: quant. obj
  aux = 2;
  currentLine = figure[aux];
  int objNum = int(currentLine.charAt(0));
  
  polygons = new ArrayList(objNum);
  
  aux = 4;
  for(int k = 0; k < objNum; k++){
   //5a linha: P L F
    currentLine = figure[aux];
    int[] plf = int(split(currentLine, ' '));
    int p = plf[0];
    int l = plf[1];
    int f = plf[2];
    
    aux++;
    double[][] points = new double[p][4];
    for(int i = 0; i < p; i++) {
      currentLine = figure[i+aux];
      int[] temp = int(split(currentLine, ' '));
      points[i][0] = temp[0];
      points[i][1] = temp[1];
      points[i][2] = temp[2];
      points[i][3] = 1;
    }
    aux += p;
    double[][] lines = new double[l][2];
    for(int i = 0; i < l; i++) {
      currentLine = figure[i+aux];
      int[] temp = int(split(currentLine, ' '));
      lines[i][0] = temp[0];
      lines[i][1] = temp[1];
    }
    
    aux += l;
    ArrayList<double[]> faces = new ArrayList(f);
    for(int i = 0; i < f; i++) {
      currentLine = figure[i+aux];
      int[] temp = int(split(currentLine, ' '));
      double[] face = new double[temp[0]+3];
      for(int j = 0; j < temp[0]; j++){
        face[j] = temp[j+1];
      }
      face[temp[0]] = temp[temp[0]+1];
      face[temp[0]+1] = temp[temp[0]+2];
      face[temp[0]+2] = temp[temp[0]+3];
      faces.add(face);
    }
    aux += f;
    currentLine = figure[aux];
    int[] rot = int(split(currentLine, ' '));
    double[] rotationXYZ = new double[3];
    rotationXYZ[0] = rot[0];
    rotationXYZ[1] = rot[1];
    rotationXYZ[2] = rot[2];
    
    aux++;
    currentLine = figure[aux];
    int[] scl = int(split(currentLine, ' '));
    double[] scaleXYZ = new double[3];
    scaleXYZ[0] = scl[0];
    scaleXYZ[1] = scl[1];
    scaleXYZ[2] = scl[2];
    
    aux++;
    currentLine = figure[aux];
    int[] trans = int(split(currentLine, ' '));
    double[] moveXYZ = new double[3];
    moveXYZ[0] = trans[0];
    moveXYZ[1] = trans[1];
    moveXYZ[2] = trans[2];
    
    aux += 2;
    Polygon polygon = new Polygon (points, lines, faces, rotationXYZ, scaleXYZ, moveXYZ); //<>//
    polygons.add(polygon); //<>//
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
  text("P. Projection", WIDTH, 330);
  text("+. Increase (+1x)", WIDTH, 390);
  text("-. Decrease (-1x)", WIDTH, 410);
  if(control){
    switch(polygon.projection){
      case 1:
        text("Cavaleira Projection", WIDTH, 500);
        break;
      case 2:
        text("Cabinet Projection", WIDTH, 500);
        break;
      case 3:
        text("Isometric Projection", WIDTH, 500);
        break;
      case 4:
        text("Point Z Projection", WIDTH, 500);
        break;
      case 5:
        text("Point X, Z Projection", WIDTH, 500);
        break;
      default:
        text("Cavaleira Projection", WIDTH, 500);
        break;
    }
  }
}
