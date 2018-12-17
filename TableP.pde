/** Universidade Federal de Góias
  * Computação Gráfica 
  *
  * Valmir Torres de Jesus Junior
  * Atividade individual 7
  * 17/12/2018
**/

class TableP {
  private int side;
  private int yMin;
  private int yMax;
  private int xTy;
  private float coef;
  
  TableP(int side, int yMin, int yMax, int xTy, float coef){
    this.side = side;
    this.yMin = yMin;
    this.yMax = yMax;
    this.xTy = xTy;
    this.coef = coef;
  }
  
  int getSide(){
    return this.side;
  }
  
  int getYMin(){
    return this.yMin;
  }
  
  int getYMax(){
    return this.yMax;
  }
  
  int getXTY(){
    return this.xTy;
  }
  
  float getCoef(){
    return this.coef;
  }
}
