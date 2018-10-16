/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 5
  * 16/10/2018
**/

class Polygon {
  private double[][] points;
  private double[][] pointsScreen;
  private double[][] lines;
  private int[] colorBorder;
  private int[] colorInside;
  private boolean fill;
  private int type;
  int projection = 1;
  double variation = 1;
  
  Polygon(int object){
    this.type = object;
    if (object == 1) createCube();
    else if (object == 2) createPyramid(); 
  }
  
  double[][] getPoints(){
    return this.points;
  }
  
  double[][] getPointsScreen(){
    return this.pointsScreen;
  }
  
  double[][] getLines(){
    return this.lines;
  }
  
  int[] getColorBorder(){
    return this.colorBorder;
  }
  
  int[] getColorInside(){
    return this.colorInside;
  }
  
  boolean isFill(){
    return this.fill;
  }
  
  private void createCube(){
    double[][] points = new double[8][4];
    
    //p1
    points[0][0] = -1;
    points[0][1] = 1;
    points[0][2] = 1;
    points[0][3] = 1;
    
    //p2
    points[1][0] = 1;
    points[1][1] = 1;
    points[1][2] = 1;
    points[1][3] = 1;
    
    //p3
    points[2][0] = 1;
    points[2][1] = -1;
    points[2][2] = 1;
    points[2][3] = 1;
    
    //p4
    points[3][0] = -1;
    points[3][1] = -1;
    points[3][2] = 1;
    points[3][3] = 1;
    
    //p5
    points[4][0] = -1;
    points[4][1] = 1;
    points[4][2] = -1;
    points[4][3] = 1;
    
    //p6
    points[5][0] = 1;
    points[5][1] = 1;
    points[5][2] = -1;
    points[5][3] = 1;
    
    //p6
    points[6][0] = 1;
    points[6][1] = -1;
    points[6][2] = -1;
    points[6][3] = 1;
    
    //p7
    points[7][0] = -1;
    points[7][1] = -1;
    points[7][2] = -1;
    points[7][3] = 1;
    
    int[] colorBorder = {
      randomGen(1, 256), 
      randomGen(1, 256), 
      randomGen(1,256)
    };
    int[] colorInside = {
      randomGen(1, 256), 
      randomGen(1, 256), 
      randomGen(1,256)
    };
    
    this.points = points;
    this.colorBorder = colorBorder;
    this.colorInside = colorInside;
    this.fill = false;
    chooseProjection();
  }
  
  private void createPyramid() {
    double[][] points = new double[5][4];
    
    //p1
    points[0][0] = 0;
    points[0][1] = 3;
    points[0][2] = 0;
    points[0][3] = 1;
    
    //p2
    points[1][0] = -0.5;
    points[1][1] = 0.5;
    points[1][2] = -0.5;
    points[1][3] = 1;
    
    //p3
    points[2][0] = 1;
    points[2][1] = 0;
    points[2][2] = -0.5;
    points[2][3] = 1;
    
    //p4
    points[3][0] = 0.5;
    points[3][1] = -0.5;
    points[3][2] = 0.5;
    points[3][3] = 1;
    
    //p5
    points[4][0] = -1;
    points[4][1] = 0;
    points[4][2] = 0.5;
    points[4][3] = 1;
    
    int[] colorBorder = {
      randomGen(1, 256), 
      randomGen(1, 256), 
      randomGen(1,256)
    };
    int[] colorInside = {
      randomGen(1, 256), 
      randomGen(1, 256), 
      randomGen(1,256)
    };
    
    this.points = points;
    this.colorBorder = colorBorder;
    this.colorInside = colorInside;
    this.fill = false;
    
    chooseProjection();
  } //<>//
  
  void move(double x, double y, double z, boolean var){
    if(var){
      x *= variation;
      y *= variation;
      z *= variation;
    }
    
    double[][] m = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {x, y, z, 1},
    };
    int size = 0;
    
    if(type == 1) size = 8;
    else size = 5;
    
    points = multM(points, m, size);
  }
  
  void customScale(double x, double y, double z, boolean var){
    if(var){
      x *= variation;
      y *= variation;
      z *= variation;
    }
    
    double[][] m = {
      {x, 0, 0, 0},
      {0, y, 0, 0},
      {0, 0, z, 0},
      {0, 0, 0, 1},
    };
    int size = 0;
    
    if(type == 1) size = 8;
    else size = 5;
    
    points = multM(points, m, size);
  }
  
  void rotationXY(double angle){
    float rad = (float) angle*3.141592/180;
    double[][] m = {
      {cos(rad),  sin(rad), 0, 0},
      {-sin(rad), cos(rad), 0, 0},
      {0,         0,        1, 0},
      {0,         0,        0, 1},
    };
    int size = 0;
    
    if(type == 1) size = 8;
    else size = 5;
    
    points = multM(points, m, size);
  }
  
  void rotationZX(double angle){
    float rad = (float) angle*3.141592/180;
    double[][] m = {
      {cos(rad), 0, -sin(rad), 0},
      {0,        1,         0, 0},
      {sin(rad), 0,  cos(rad), 0},
      {0,        0,         0, 1},
    };
    int size = 0;
    
    if(type == 1) size = 8;
    else size = 5;
    
    points = multM(points, m, size);
  }
  
  void rotationYZ(double angle){
    float rad = (float) angle*3.141592/180;
    double[][] m = {
      {1,         0,        0, 0},
      {0,  cos(rad), sin(rad), 0},
      {0, -sin(rad), cos(rad), 0},
      {0,         0,        0, 1},
    };
    int size = 0;
    
    if(type == 1) size = 8;
    else size = 5;
    
    points = multM(points, m, size);
  }
  
  private void cavaleiraProjection(){
    double[][] pointsScreen;
    int h, w, p;
    double dx, dy, cos, m;
    
    h = yMax - yMin;
    w = xMax - xMin;
    p = zMax - zMin;
    
    cos = (sqrt(2))/2;
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = 0;
    if (type == 1) {
      pointsScreen = new double[8][4];
      size = 8;
    }
    else {
      pointsScreen = new double[5][4];
      size = 5;
    }
    for(int i = 0; i < size; i++){
      //x', y', z'
      pointsScreen[i][0] = points[i][0] - xMin;
      pointsScreen[i][1] = yMax - points[i][1];
      pointsScreen[i][2] = zMax - points[i][2];
      
      //x'', y'', z''
      pointsScreen[i][0] = pointsScreen[i][0] * m + dx;
      pointsScreen[i][1] = pointsScreen[i][1] * m + dy;
      pointsScreen[i][2] = pointsScreen[i][2] * m;
      
      //x''', y''', z'''
      pointsScreen[i][0] = pointsScreen[i][0] + pointsScreen[i][2] * cos;
      pointsScreen[i][1] = pointsScreen[i][1] - pointsScreen[i][2] * cos;
      pointsScreen[i][2] = 0;
    }
    
    this.pointsScreen = pointsScreen;
    drawObject();
  }
  
  private void cabinetProjection(){
    double[][] pointsScreen;
    int h, w, p;
    double dx, dy, cos, m;
    
    h = yMax - yMin;
    w = xMax - xMin;
    p = zMax - zMin;
    
    cos = (sqrt(2)/2)/2;
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = 0;
    if (type == 1) {
      pointsScreen = new double[8][4];
      size = 8;
    }
    else {
      pointsScreen = new double[5][4];
      size = 5;
    }
    for(int i = 0; i < size; i++){
      //x', y', z'
      pointsScreen[i][0] = points[i][0] - xMin;
      pointsScreen[i][1] = yMax - points[i][1];
      pointsScreen[i][2] = zMax - points[i][2];
      
      //x'', y'', z''
      pointsScreen[i][0] = pointsScreen[i][0] * m + dx;
      pointsScreen[i][1] = pointsScreen[i][1] * m + dy;
      pointsScreen[i][2] = pointsScreen[i][2] * m;
      
      //x''', y''', z'''
      pointsScreen[i][0] = pointsScreen[i][0] + pointsScreen[i][2] * cos;
      pointsScreen[i][1] = pointsScreen[i][1] - pointsScreen[i][2] * cos;
      pointsScreen[i][2] = 0;
    }
    
    this.pointsScreen = pointsScreen;
    drawObject();
  }
  
  private void isometricProjection(){
    double[][] pointsScreen;
    int h, w, p;
    double dx, dy, cos, m;
    
    h = yMax - yMin;
    w = xMax - xMin;
    p = zMax - zMin;
    
    cos = (sqrt(2)/2);
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = 0;
    if (type == 1) {
      pointsScreen = new double[8][4];
      size = 8;
    }
    else {
      pointsScreen = new double[5][4];
      size = 5;
    }
    for(int i = 0; i < size; i++){
      //x', y', z'
      pointsScreen[i][0] = points[i][0] - xMin;
      pointsScreen[i][1] = yMax - points[i][1];
      pointsScreen[i][2] = 10 - points[i][2];
      
      //x'', y'', z''
      pointsScreen[i][0] = pointsScreen[i][0] * m + dx;
      pointsScreen[i][1] = pointsScreen[i][1] * m + dy;
      pointsScreen[i][2] = pointsScreen[i][2] * m;
      
      //x''', y''', z'''
      pointsScreen[i][0] = pointsScreen[i][0] + pointsScreen[i][2] * cos;
      pointsScreen[i][1] = pointsScreen[i][1] - pointsScreen[i][2] * cos;
      pointsScreen[i][2] = 0;
    }
    
    double[][] isometric = {
      {0.707,  0.408, 0, 0},
      {0,      0.816, 0, 0},
      {0.707, -0.408, 0, 0},
      {0,      0,     0, 1},
    };
    
    pointsScreen = multM(pointsScreen, isometric , size);
    this.pointsScreen = pointsScreen;
    drawObject();
  }
  
  private void vanishingPointZProjection(){
    
  }
  
  private void vanishingPointXZProjection(){
    
  }
  
  void chooseProjection(){
    switch (projection){
      case 1:
        cavaleiraProjection();
        break;
      case 2:
        cabinetProjection();
        break;
      case 3:
        isometricProjection();
        break;
      case 4:
        vanishingPointZProjection();
        break;
      case 5:
        vanishingPointXZProjection();
        break;
      default:
        cavaleiraProjection();
        break;
    }
  }
  
  private void drawObject(){
    int size = 0;
    if(type == 1) {
      this.lines = new double[12][6];
      size = 12;
      int i = 0;
      int j = 4;
      int k = 8;
      for(int s = 0; s < 4; s++){
        //recuperando xi, yi e zi 
        lines[i][0] = pointsScreen[s][0];
        lines[i][1] = pointsScreen[s][1];
        lines[i][2] = pointsScreen[s][2];
        
        lines[j][0] = pointsScreen[s][0];
        lines[j][1] = pointsScreen[s][1];
        lines[j][2] = pointsScreen[s][2];
        
        lines[k][0] = pointsScreen[s+4][0];
        lines[k][1] = pointsScreen[s+4][1];
        lines[k][2] = pointsScreen[s+4][2];
        
        //recuperando xf, yf e zf
        if (s == 3){
          lines[i][3] = pointsScreen[0][0];
          lines[i][4] = pointsScreen[0][1];
          lines[i][5] = pointsScreen[0][2];
          
          lines[j][3] = pointsScreen[s+4][0];
          lines[j][4] = pointsScreen[s+4][1];
          lines[j][5] = pointsScreen[s+4][2];
          
          lines[k][3] = pointsScreen[4][0];
          lines[k][4] = pointsScreen[4][1];
          lines[k][5] = pointsScreen[4][2];
        } else {
          lines[i][3] = pointsScreen[s+1][0];
          lines[i][4] = pointsScreen[s+1][1];
          lines[i][5] = pointsScreen[s+1][2];
          
          lines[j][3] = pointsScreen[s+4][0];
          lines[j][4] = pointsScreen[s+4][1];
          lines[j][5] = pointsScreen[s+4][2];
          
          lines[k][3] = pointsScreen[s+5][0];
          lines[k][4] = pointsScreen[s+5][1];
          lines[k][5] = pointsScreen[s+5][2];
        }
        i++;
        j++;
        k++;
      }
    } else {
      size = 8;
      this.lines = new double[8][6];
      for(int s = 0; s < 4; s++){
        //recuperando xi, yi e zi 
        lines[s][0] = pointsScreen[s+1][0];
        lines[s][1] = pointsScreen[s+1][1];
        lines[s][2] = pointsScreen[s+1][2];
        
        //recuperando xf, yf e zf
        if (s == 3){
          lines[s][3] = pointsScreen[1][0];
          lines[s][4] = pointsScreen[1][1];
          lines[s][5] = pointsScreen[1][2];
        } else {
          lines[s][3] = pointsScreen[s+2][0];
          lines[s][4] = pointsScreen[s+2][1];
          lines[s][5] = pointsScreen[s+2][2];
        }
      }
      
      for (int i = 4; i < 8; i++) {
        //recuperando xi, yi e zi 
        lines[i][0] = pointsScreen[0][0];
        lines[i][1] = pointsScreen[0][1];
        lines[i][2] = pointsScreen[0][2];
        
        //recuperando xf, yf e zf
        lines[i][3] = pointsScreen[i-3][0];
        lines[i][4] = pointsScreen[i-3][1];
        lines[i][5] = pointsScreen[i-3][2];
      }
    }
    for (int i = 0; i < size; i++) {
      linhaDDA((int)lines[i][0], 
               (int)lines[i][1], 
               (int)lines[i][3], 
               (int)lines[i][4], 
               colorBorder[0], 
               colorBorder[1], 
               colorBorder[2]);
    }
  }
  
  private void linhaDDA(int xi, int yi, int xf, int yf, int r, int g, int b) {
    int dx = xf - xi, dy = yf - yi, steps, k;
    float incX, incY, x = xi, y = yi;
    
    if (abs(dx) > abs(dy)) steps = abs(dx);
    else steps = abs(dy);
    
    incX = dx / (float) steps;
    incY = dy / (float) steps;
    
    stroke(r, g, b);
    point((int) x, (int) y);
    for (k = 0; k < steps; k++){
      x += incX;
      y += incY;
      
      point((int) x, (int) y);
    }
  }
  
  private double[][] multM(double[][] m1, double m2[][], int size){
    double result;
    double [][] temp = new double[size][4];
    for(int i = 0; i < size; i++) {
      for(int j = 0; j < 4; j++) {
        result = 0;
        for(int k = 0; k < 4; k++)
          result = result + (m1[i][k] * m2[k][j]);
        temp[i][j] = result;
      }
  }
    return temp; //<>//
  }
  
  private int randomGen(int first, int last) {
    int temp = (int) random(first, last);
    return temp;
  }
}
