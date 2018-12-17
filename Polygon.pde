/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 7
  * 17/12/2018
**/

class Polygon {
  private double[][] points;
  private double[][] pointsScreen;
  private int[][] lines;
  private ArrayList<double[]> faces;
  private int[] colorBorder;
  private double xd = 0, yd = 0, zd = 0; 
  private int zMed;
  private TableP[] sides;
  int projection = 1;
  double variation = 1;
  
  Polygon(double[][] points, 
          int[][] lines, 
          ArrayList<double[]> faces, 
          double[] rot, 
          double[] scl,
          double[] mv) {
    this.points = points;
    this.lines = lines;
    this.faces = faces;
    
    int[] colorBorder = {
      randomGen(1, 256), 
      randomGen(1, 256), 
      randomGen(1,256)
    };
    this.colorBorder = colorBorder;
   
    rotation(rot[0], 1);
    rotation(rot[1], 2);
    rotation(rot[2], 3);
    customScale(scl[0], scl[1], scl[2], true);
    move(mv[0], mv[1], mv[2], true);
  }
  
  void move(double x, double y, double z, boolean var){
    if(var){
      x *= variation;
      y *= variation;
      z *= variation;
    }
    
    xd += x;
    yd += y;
    zd += z;
    
    double[][] m = {
      {1, 0, 0, 0},
      {0, 1, 0, 0},
      {0, 0, 1, 0},
      {x, y, z, 1},
    };
    int size = this.points.length;
    
    points = multM(points, m, size);
    selectProjection();
  }
  
  void customScale(double x, double y, double z, boolean var){
    if(var){
      x *= variation;
      y *= variation;
      z *= variation;
    }
    int size = this.points.length;
    
    double[][] m = {
      {1,     0,   0, 0},
      {0,     1,   0, 0},
      {0,     0,   1, 0},
      {-xd, -yd, -zd, 1},
    };
    points = multM(points, m, size);
    
    double[][] m1 = {
      {x, 0, 0, 0},
      {0, y, 0, 0},
      {0, 0, z, 0},
      {0, 0, 0, 1},
    };
    points = multM(points, m1, size);
    
    double[][] m2 = {
      {1,   0,  0, 0},
      {0,   1,  0, 0},
      {0,   0,  1, 0},
      {xd, yd, zd, 1},
    };
    points = multM(points, m2, size);
    
    selectProjection();
  }
  
  void rotation(double angle, int typeR){
    float rad = (float) angle*3.141592/180;
    
    int size = this.points.length;
    
    double[][] m = {
      {1,     0,   0, 0},
      {0,     1,   0, 0},
      {0,     0,   1, 0},
      {-xd, -yd, -zd, 1},
    };
    points = multM(points, m, size);
    
    switch(typeR){
      case 1: //XY
        double[][] rxy = {
          {cos(rad),  sin(rad), 0, 0},
          {-sin(rad), cos(rad), 0, 0},
          {0,         0,        1, 0},
          {0,         0,        0, 1},
        };
        points = multM(points, rxy, size);
        break;
      case 2: //ZX
        double[][] rzx = {
          {cos(rad), 0, -sin(rad), 0},
          {0,        1,         0, 0},
          {sin(rad), 0,  cos(rad), 0},
          {0,        0,         0, 1},
        };
        points = multM(points, rzx, size);
        break;
      case 3: //YZ
        double[][] ryz = {
          {1,         0,        0, 0},
          {0,  cos(rad), sin(rad), 0},
          {0, -sin(rad), cos(rad), 0},
          {0,         0,        0, 1},
        }; 
        points = multM(points, ryz, size);
        break;
    }
    
    double[][] m2 = {
      {1,   0,  0, 0},
      {0,   1,  0, 0},
      {0,   0,  1, 0},
      {xd, yd, zd, 1},
    };
    points = multM(points, m2, size);
    
    selectProjection();
  }
  
  private void obliqueProjection(int typeP){
    double[][] pointsScreen;
    int h, w;
    double dx, dy, cos, m;
    
    h = yMax - yMin;
    w = xMax - xMin;
    
    if(typeP == 1) cos = (sqrt(2))/2; //Cavaleira
    else cos = (cos(30*3.141592/180))/2; //Cabinet
    
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = this.points.length;
    pointsScreen = new double[size][4];
    
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
  }
  
  private void isometricProjection(){
    double[][] pointsScreen;
    int h, w;
    double dx, dy, m;
    
    h = yMax - yMin;
    w = xMax - xMin;
    
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = this.points.length;
    pointsScreen = new double[size][4];
    
    for(int i = 0; i < size; i++){
      //x', y', z'
      pointsScreen[i][0] = points[i][0] - xMin;
      pointsScreen[i][1] = yMax - points[i][1];
      pointsScreen[i][2] = zMax - points[i][2];
      
      //x'', y'', z''
      pointsScreen[i][0] = pointsScreen[i][0] * m + dx;
      pointsScreen[i][1] = pointsScreen[i][1] * m + dy;
      pointsScreen[i][2] = pointsScreen[i][2] * m;
    }
    
    double[][] isometric = {
      {0.707,  0.408, 0, 0},
      {0,      0.816, 0, 0},
      {0.707, -0.408, 0, 0},
      {0,      0,     0, 1},
    };
    
    pointsScreen = multM(pointsScreen, isometric , size);
    this.pointsScreen = pointsScreen;
  }
  
  private void perspectiveProjection(int typeP){
    double[][] pointsScreen;
    int h, w;
    double dx, dy, m, fz = 1000, fx = 5;
    
    h = yMax - yMin;
    w = xMax - xMin;
    
    if((WIDTH/w) <= (HEIGHT/h)) m = (WIDTH/w);
    else m = (HEIGHT/h);
    
    dx = (WIDTH - w * m) / 2;
    dy = (HEIGHT - h * m) / 2;
    
    int size = this.points.length;
    pointsScreen = new double[size][4];
    
    for(int i = 0; i < size; i++){
      //x', y', z'
      pointsScreen[i][0] = points[i][0] - xMin;
      pointsScreen[i][1] = yMax - points[i][1];
      pointsScreen[i][2] = -1 - points[i][2];
      
      //x'', y'', z''
      pointsScreen[i][0] = pointsScreen[i][0] * m + dx;
      pointsScreen[i][1] = pointsScreen[i][1] * m + dy;
      pointsScreen[i][2] = pointsScreen[i][2] * m;
      
      //x''', y''', z'''
      if(typeP == 1){ //Ponto de fuga Z
        pointsScreen[i][0] /= 1 - pointsScreen[i][2] / fz;
        pointsScreen[i][1] /= 1 - pointsScreen[i][2] / fz;
        pointsScreen[i][2] = 0;
      } else {
        //Ponto de fuga X Z
      }
    }
    
    this.pointsScreen = pointsScreen;
  }
  
  void selectProjection(){
    switch (projection){
      case 1:
        obliqueProjection(1);
        break;
      case 2:
        obliqueProjection(2);
        break;
      case 3:
        isometricProjection();
        break;
      case 4:
        perspectiveProjection(1);
        break;
      case 5:
        perspectiveProjection(2);
        break;
      default:
        obliqueProjection(1);
        break;
    }
  }
  
  void drawObject(){
    for (int i = 0; i < this.lines.length; i++){
      linhaDDA((int) this.pointsScreen[this.lines[i][0]-1][0],
               (int) this.pointsScreen[this.lines[i][0]-1][1],
               (int) this.pointsScreen[this.lines[i][1]-1][0],
               (int) this.pointsScreen[this.lines[i][1]-1][1],
               this.colorBorder[0],
               this.colorBorder[1],
               this.colorBorder[2]);
    }
    paintFace(); //<>//
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
  
  void paintFace(){
    //Determinar qual face sera pintada primeiro
    
    //Observador: (Px, Py, Pz)
    //Se n*l = 0, o observador esta perpendicular ao plano
    //Se n*l > 0, o plano esta visivel
    //Se n*l < 0, o plano esta invisivel
    
    //n*l = nx * (Px - P2x) + ny * (Py - P2y) + nz * (Pz - P2z)
    //nx = (P3y - P2y)*(P1z - P2z)-(P1y-P2y)*(P3z-P2z)
    //ny = (P3z - P2z)*(P1x - P2x)-(P1z-P2z)*(P3x-P2x)
    //nz = (P3x - P2x)*(P1y - P2y)-(P1x-P2x)*(P3y-P2y)
    //lx = (Px - P2x)
    //ly = (Py - P2y)
    //lz = (Pz - P2z)
    
    int temp = 0;
    double[] face = faces.get(temp);
    int n = (int)face[0];
    int[][]facePoints = new int[n][4];
    
    //Recuperando os pontos da face
    for(int i = 0; i < n; i++){
      //recuperando xi e yi
      facePoints[i][0] = (int) this.pointsScreen[(int) face[i+1]-1][0];
      facePoints[i][1] = (int) this.pointsScreen[(int) face[i+1]-1][1];
      //recuperando xf e yf
      if (i == n-1){
        facePoints[i][2] = (int) this.pointsScreen[(int) face[1]-1][0];
        facePoints[i][3] = (int) this.pointsScreen[(int) face[1]-1][1];
      } else {
        facePoints[i][2] =  (int) this.pointsScreen[(int) face[i+2]-1][0];
        facePoints[i][3] =  (int) this.pointsScreen[(int) face[i+2]-1][1];
      }
    }
    
    customFill(facePoints, (int) face[n+1], (int) face[n+2], (int) face[n+3]);
  }
  
  private void customFill(int[][] facePoints, int r, int g, int b){ 
    calculateTable(facePoints);
    int p = facePoints.length;
    FloatList aux = new FloatList();
    
    for(int yVarredura = 0; yVarredura < SCREEN_WIDTH; yVarredura++) {
      for(int i = 0; i < p; i++) {
        if((yVarredura <= sides[i].yMax) && (yVarredura >= sides[i].yMin)){
          if(sides[i].yMin != sides[i].yMax){
            float temp = sides[i].coef * (yVarredura - sides[i].yMin) + sides[i].xTy;
            aux.append(temp);
          }
        }
      }
      
      if(aux.size() > 0 && aux.size() % 2 != 0) {
        aux.sort();
        
        for(int i = 0; i < aux.size(); i++) {
          for(int j = i + 1; j < aux.size(); j++){
            if(round(aux.get(i)) == round(aux.get(j))){
              aux.remove(i);
              break;
            }
          }
        }
      }
      
      if (aux.size() > 0 && aux.size() % 2 == 0){
        aux.sort();
        
        for (int i = 0; i < aux.size(); i = i + 2)
          linhaDDA((int) aux.get(i)+1, 
                   yVarredura, 
                   (int) aux.get(i+1)-1,
                   yVarredura, 
                   r, g, b);
                  
      }
      aux.clear();
    } 
  }
  
  private void calculateTable(int[][] facePoints) {
    int p = facePoints.length;
    sides = new TableP[p];
    int yMin, yMax, xTy;
    float coef;
    
    for (int i = 0; i < p; i++){
      if (facePoints[i][1] <= facePoints[i][3]) {
        yMin = facePoints[i][1]; 
        yMax = facePoints[i][3];
        xTy = facePoints[i][0];
      } else {
        yMin = facePoints[i][3]; 
        yMax = facePoints[i][1];
        xTy = facePoints[i][2];
      }
      if ((float)facePoints[i][1] - facePoints[i][3] == 0) coef = 0;
      else coef = ((float)(facePoints[i][0]-facePoints[i][2])/(float)(facePoints[i][1]-facePoints[i][3]));     
      sides[i] = new TableP(i+1, yMin, yMax, xTy, coef);
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
    return temp;
  }
  
  private int randomGen(int first, int last) {
    int temp = (int) random(first, last);
    return temp;
  }
}
