class Rect {
int number;

public Rect(int number){
  this.number = number;
}

final static byte GRID = 4; //# of squares in grid
final static short DIM = 40;
boolean[][][] leds = new boolean[1000][GRID][GRID];




public void drawRect(int number){
   for (int row = 0; row != GRID; ++row)
    for (int col = 0; col != GRID; ++col) {
      fill(255);
     if(leds[count][row][col] == true)
     fill(0,0,255);
      rect(row*DIM + DIM * number * (GRID + 1) ,col*DIM,DIM,DIM); 
  
    }

  
}
  
  
  
  
  
  
  
  
  
}
