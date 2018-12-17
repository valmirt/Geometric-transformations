/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 7
  * 17/12/2018
**/

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int MENU_SIZE_WIDTH = 250;
int MENU_SIZE_HEIGHT = 0;
int WIDTH = SCREEN_WIDTH - MENU_SIZE_WIDTH;
int HEIGHT = SCREEN_HEIGHT - MENU_SIZE_HEIGHT;
int xMin = -10, xMax = 10, yMin = -10, yMax = 10, zMin = -1, zMax = 1;
boolean control = false;
int i = -1;
int maxObjs;

ArrayList<Polygon> polygons;
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
    if(keyCode == TAB){
      control = false;
      background(0); //<>//
      if(i < maxObjs-1) i++;
      else i = 0;
      polygons.get(i).drawObject();
      showMenu();
    }
     if(keyCode == SHIFT){
      control = false;
      background(0);
      if(i > 0) i--;
      else i = maxObjs-1;
      polygons.get(i).drawObject();
      showMenu();
    }
     if(keyCode == ENTER){
       control = true;
    }
    
    if (keyCode == UP){
      if(control) {
        background(0);
        polygons.get(i).move(0, 1, 0, true);
        polygons.get(i).drawObject();
        showMenu();  
      }
    }
    if (keyCode == DOWN){
      if(control) {
        background(0);
        polygons.get(i).move(0, -1, 0, true);
        polygons.get(i).drawObject();
        showMenu();
      }
    }
    if (keyCode == LEFT){
      if(control) {
        background(0);
        polygons.get(i).move(-1, 0, 0, true);
        polygons.get(i).drawObject();
        showMenu();
      }
    }
    if (keyCode == RIGHT){
      if(control) {
        background(0);
        polygons.get(i).move(1, 0, 0, true);
        polygons.get(i).drawObject();
        showMenu();  
      }
    }
    if (key == 'X' || key == 'x'){
      if(control) {
        background(0);
        polygons.get(i).rotation(15, 1);
        polygons.get(i).drawObject();
        showMenu();
      }
    }
    if (key == 'Z' || key == 'z'){
      if(control) {
        background(0);
        polygons.get(i).rotation(15, 2);
        polygons.get(i).drawObject();
        showMenu();  
      }
    }
    if (key == 'Y' || key == 'y'){
      if(control) {
        background(0);
        polygons.get(i).rotation(15, 3);
        polygons.get(i).drawObject();
        showMenu();
      }
    }
    if (key == 'S' || key == 's'){
      if(control) {
        background(0);
        polygons.get(i).customScale(0.9, 0.9, 0.9, true);
        polygons.get(i).drawObject();
        showMenu();
      }
    }
    if (key == 'P' || key == 'p'){
      if(control) {
        background(0);
        if(polygons.get(i).projection < 5) polygons.get(i).projection += 1;
        else polygons.get(i).projection = 1;
        polygons.get(i).selectProjection();
        polygons.get(i).drawObject();
        showMenu();  
      }
    }
    if (key == '+'){
      if(control) if (polygons.get(i).variation < 3) polygons.get(i).variation += 0.5;
    }
    if (key == '-'){
      if(control) if (polygons.get(i).variation > 0.6) polygons.get(i).variation -= 0.5;
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
  int[] objNum = int(split(currentLine, ' '));
  this.maxObjs = objNum[0];
  
  polygons = new ArrayList(objNum[0]);
  
  aux = 4;
  for(int k = 0; k < objNum[0]; k++){
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
    int[][] lines = new int[l][2];
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
      double[] face = new double[temp[0]+4];
      for(int j = 0; j <= temp[0]; j++){
        face[j] = temp[j];
      }
      face[temp[0]+1] = temp[temp[0]+1];
      face[temp[0]+2] = temp[temp[0]+2];
      face[temp[0]+3] = temp[temp[0]+3];
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
    Polygon polygon = new Polygon (points, lines, faces, rotationXYZ, scaleXYZ, moveXYZ);
    polygons.add(polygon);
  }
}

void showMenu(){
  textSize(16);
  text("Menu:", WIDTH, 30);
  text("TAB/SHIFT. Select polygon", WIDTH, 60);
  text("ENTER. Confirm polygon", WIDTH, 90);
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
    switch(polygons.get(i).projection){
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
