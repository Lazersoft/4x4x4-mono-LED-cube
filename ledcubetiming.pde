final static byte GRID = 4;  //# of squares in grid.
int DIM = 40; //pixel dimension of each grid.
int count = 0;               //what frame you're on
Rect[] rect;                 //declare the array of Rects.
PFont f;
int frameIncrease = 0; //used for small boxes

int framex = DIM * 3 * (GRID + 1);
int framey = DIM*5;  
int framexdim = DIM*4;
int frameydim = DIM;
float filly = DIM * 6.5;
int specy = DIM * 8;
float arrowy = DIM * 9.5;
float savey = DIM * 11;
float exporty = DIM * 12.5;
boolean player = false;
int maxCount;
PrintWriter output;
int clearRow=5;
int timing[] = new int[1000];

void setup(){
  size(DIM * 4 * (GRID + 1) - DIM,DIM*17,OPENGL);
  f=createFont("Serif",20);
  textFont(f);
  rect = new Rect[4];
  for(int i = 0; i < 4; i++)
    rect[i] = new Rect(i); 
}


void draw(){
  //println(maxCount);
  background(206);
  //println(maxCount + ","+count);
  for(int i = 0; i < 4; i++)
    rect[i].drawRect(i);
drawButtons();
//rect(DIM*2,DIM*13.5,10,10);
noFill();
//for(int i=0;i<6;i++)
//rect(DIM*0.5 + DIM*3.05*i,DIM*14,DIM*2.8,DIM*2.8);
//rectangle that highlights current small box
if(count < 4)
rect(DIM*0.5 + DIM*3.05*count,DIM*14,DIM*2.8,DIM*2.8);
else
rect(DIM*0.5 + DIM*3.05*3,DIM*14,DIM*2.8,DIM*2.8);
drawBoxes();
drawSmallBoxes();
fill(0);
text(timing[count],width-DIM/2,DIM*4.6);
}

void keyPressed(){
  println(keyCode);
  if(key == ENTER || keyCode == 32){
       count++;
      maxCount++; 
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){

                      rect[i].leds[count][row][col] = rect[i].leds[count-1][row][col]; //prevent leds from resetting after frame increases
                }
                if(count > 3) frameIncrease++;
} 
   if(keyCode==RIGHT){
     if(count < maxCount){
        count++;
        if(count >3)
        frameIncrease++;
      }
   }
   if(keyCode==LEFT){
     if(count > 0){
        count--;
        if(count >2)
        frameIncrease--;
      }
   }
   if(keyCode==UP){
     if(timing[count] < 99)
      timing[count]++; 
   }
   if(keyCode==DOWN){
    if(timing[count] > 0)
       timing[count]--;
   }
   for(int i=0;i<4;i++)
   if(keyCode==49+i)
   clearRow=i;

}

void mousePressed(){
  
  for(int n=0; n < 4; n++) //change the status of an LED
    for (int row = 0; row != GRID; ++row)
    for (int col = 0; col != GRID; ++col) {
      if(mouseX>(row*DIM + DIM * n * (GRID + 1)) && mouseX<(row*DIM + DIM * n * (GRID + 1) +DIM) && mouseY>(col*DIM) && mouseY<(col*DIM +DIM))
       rect[n].leds[count][row][col]= !rect[n].leds[count][row][col];
    }

    //if frame button is pressed
    if(mouseX>(framex) && mouseX<(framex + framexdim/3) && mouseY>(framey) && mouseY<(framey + frameydim)){
      if(count++ ==maxCount){
      
      maxCount++; 
      }
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){

                      rect[i].leds[count][row][col] = rect[i].leds[count-1][row][col]; //prevent leds from resetting after frame increases
                }
                if(count > 3) frameIncrease++;
     }
     //if insert button is pressed
    if(mouseX>(framex+framexdim/3) && mouseX<(framex + 2* framexdim/3) && mouseY>(framey) && mouseY<(framey + frameydim)){
      count++;
      maxCount++;
      for(int q=maxCount;q>count;q--)
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){

                      rect[i].leds[q][row][col] = rect[i].leds[q-1][row][col]; //prevent leds from resetting after frame increases
                }
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){

                      rect[i].leds[count][row][col] = rect[i].leds[count-1][row][col]; //prevent leds from resetting after frame increases
                }
                if(count > 3) frameIncrease++;
     }
     //if delete frame button is pressed
     if(mouseX>(framex + 2*framexdim/3) && mouseX<(framex + framexdim) && mouseY>(framey) && mouseY<(framey + frameydim)){
       //maxCount--;
      for(int j=count;j<maxCount;j++)
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){

                      rect[i].leds[j][row][col] = rect[i].leds[j+1][row][col];
                      
                }
                maxCount--;
                for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col)
                      rect[i].leds[maxCount+1][row][col] = false;
     }
    
    //if fill button is pressed
    if(mouseX>(framex) && mouseX<(framex + framexdim/2) && mouseY>(filly) && mouseY<(filly + frameydim)){ 
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col)
                      rect[i].leds[count][row][col] = true; //fill
    }
    
    //if clear button is pressed
    if(mouseX>(framex+framexdim/2) && mouseX<(framex + framexdim) && mouseY>(filly) && mouseY<(filly + frameydim)){ 
      //for(int z=0; z< 4; z++)
      if(clearRow != 5){
        for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){
                      rect[clearRow].leds[count][row][col] = false;
                 }
         clearRow=5;
      }
      else
      for(int i=0; i< 4; i++)
            for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){
                      rect[i].leds[count][row][col] = false; //fill
 
                }
    }
    
    //if left arrow is pressed
    if(mouseX>(framex) && mouseX<(framex + framexdim/2) && mouseY>(arrowy) && mouseY<(arrowy + frameydim)){
      if(count > 0){
        count--;
        if(count >2)
        frameIncrease--;
      }
    }
    
    //if right arrow is pressed
    if(mouseX>(framex+framexdim/2) && mouseX<(framex+framexdim/2 + framexdim/2) && mouseY>(arrowy) && mouseY<(arrowy + frameydim)){
      if(count < maxCount){
        count++;
        if(count >3)
        frameIncrease++;
      }
    }
    //if save button is pressed
    if(mouseX>(framex) && mouseX<(framex+framexdim/2) && mouseY>(savey) && mouseY<(savey + frameydim)){
      //saver();
      selectOutput("Select a file to save to","saver");
    }
    //if load button is pressed
    if(mouseX>(framex+framexdim/2) && mouseX<(framex+framexdim) && mouseY>(savey) && mouseY<(savey + frameydim)){
      selectInput("Select a file to load from","load");
    }
    //if export button is pressed
    if(mouseX>(framex) && mouseX<(framex+framexdim/2) && mouseY>(exporty) && mouseY<(exporty + frameydim)){
      export();
    }
    
    //if spec1 is pressed
    if(mouseX>(framex + 0*framexdim/3) && mouseX<(framex + framexdim/3) && mouseY>(specy) && mouseY<(specy + frameydim)){
      if(clearRow != 5)
       for(int i=0;i<4;i++)
        for (int row = 0; row != GRID; ++row)
                for (int col = 0; col != GRID; ++col){
                      rect[i].leds[count][row][col] = rect[clearRow].leds[count][row][col]; 
                }
    }
}

int rotateAmount = 0;
void drawBoxes(){
  pushMatrix();

  translate(DIM*7, DIM*9, 0); 
 rotateY(rotateAmount);
  if(mousePressed && mouseY > DIM*4 && mouseX < (width - DIM*4) && mouseY < DIM*13.5)
  rotateAmount = pmouseX / 100;
  //rotateZ(pmouseY / 100);
      fill(0);
  text("Front",-DIM*0.3,DIM*3.2,DIM*4);
  noFill();
  box(DIM*6);
  fill(0);
  text("Front",DIM*4,DIM*13.5);

  translate(DIM*3 - DIM * 8,DIM*3,DIM*3 - DIM * 6);

  for(int k=0;k<4;k++){
      for(int j=0;j<4;j++){
          for(int i=0; i < 4; i++){
              translate(DIM*2,0,0);
              if(!rect[k].leds[count][i][j] == true)
              fill(206);
              else
              fill(0,0,255);
              box(DIM/2);
          }
      translate(0,0,DIM * 2);
      translate(-DIM*8,0,0);
      } 
  translate(0,-DIM*2,-DIM*8);
  }
  
  popMatrix();

}

void drawSmallBoxes(){
  pushMatrix();
 // for(int i=0;i<6;i++)
//rect(DIM/1.4 + DIM *3 * i,DIM*14,DIM *2.5,DIM * 2.5);
  DIM = DIM / 4;
  translate(0, DIM*61, 0); 
  noFill();
  int q,w;
    if(count < 4){
    q = 0;
    w=6;
    }
    else{
    q = count-3;
    w=count+3;
    }
  //for(int q = count; q < count + 6;q++){
    for(q = q; q <w;q++){
    pushMatrix();
    //rotateX(PI/12 * q);
    translate(DIM* 8 + DIM * 12 * q,0,0);
    translate(-DIM*12*frameIncrease,0,0);
    noFill();
    box(DIM*6);
  

  translate(DIM*3 - DIM * 8,DIM*3,DIM*3 - DIM * 6);

  for(int k=0;k<4;k++){
      for(int j=0;j<4;j++){
          for(int i=0; i < 4; i++){
              translate(DIM*2,0,0);
              if(!rect[k].leds[q][i][j] == true)
              fill(206);
              else
              fill(0,0,255);
              box(DIM/2);
          }
      translate(0,0,DIM * 2);
      translate(-DIM*8,0,0);
      } 
  translate(0,-DIM*2,-DIM*8);
  
  }
  popMatrix();
  }
  popMatrix();
  DIM = DIM * 4;
}

void drawButtons(){
  fill(206);
   rect(framex,framey,framexdim/3,frameydim);
   rect(framex+framexdim/3,framey,framexdim/3,frameydim);
   rect(framex+2*framexdim/3,framey,framexdim/3,frameydim);
  fill(0);
  text(count,width - DIM, height - DIM / 6); 
  fill(0,0,255);
  rect(framex,filly,framexdim/2,frameydim);
  fill(255,255,255);
  rect(framex+framexdim/2,filly,framexdim/2,frameydim);
    fill(160);
  rect(framex,arrowy,framexdim/2,frameydim);
  rect(framex+framexdim/2,arrowy,framexdim/2,frameydim);
  fill(100);
  rect(framex,savey,framexdim/2,frameydim);
  rect(framex+framexdim/2,savey,framexdim/2,frameydim);
  fill(60);
  rect(framex,exporty,framexdim,frameydim);
  fill(200);
  rect(framex,specy,framexdim/3,frameydim);
  rect(framex+framexdim/3,specy,framexdim/3,frameydim);
   rect(framex+2*framexdim/3,specy,framexdim/3,frameydim);
}

void export(){
  output = createWriter("cube.txt");
  output.print("{");
  for(int i=0;i<=maxCount;i++){
  for(int k=0;k<4;k++){
    int anum=0;
    byte q=0;
  for (int col = GRID -1 ; col != -1; --col){
   // for (int col = 0 ; col != GRID; ++col){
   // byte q = 0;
    //anum="";//binary(0);
    
    for (int row = 0; row != GRID; ++row)
       {
         //output.print(anum);
        if(rect[k].leds[i][row][col] != false)
       // output.print("1");
        anum+=(pow(2,q));
        q++;
       }
      }
      output.print(anum);
      
      output.print(",");
   }
   output.print(timing[i]+1);
   if(i == maxCount){
      }
      else
   output.print(",");
  }
  output.print("};");
 output.flush(); 
}

void saver(File selection){
  output = createWriter(selection);
    for(int i=0;i<=maxCount;i++){
        for(int k=0;k<4;k++){
         // for (int row = 0; row != GRID; ++row){
          for (int col = 0 ; col != GRID; ++col){
          //  for (int col = 0 ; col != GRID; ++col){
            for (int row = 0; row != GRID; ++row){
              if(rect[k].leds[i][row][col] != false)
                output.print("1");
              else
                output.print("0");
             }
         }
      }
      if(timing[i] < 10)
      output.print("0");
  output.print(timing[i]);    
   }
   output.flush();
}

void load(File selection){
  byte b[] = loadBytes(selection);
  int row=0;
  int col=0;
  boolean firstTime = true;
  maxCount = int(b.length/64) - 1;
  //if(maxCount > 5)
  //count = maxCount - 5;
  for(int i=0 ;i<=maxCount;i++){
   // firstTime=true;
    row=0;
    col=0;
  for(int z=0 +66*i;z < 64 + 66 *i;z++){
    if ((z-i*2) % 16 ==0) firstTime = true;
        if(b[z] - 48 == 1){
        
        rect[(z-i*2) % 64 /16].leds[i][row][col] = true;
        println("row:"+row+" col: "+col);
       //rect[z % 64 /16].leds[i][3-col][row] = true;
        }
        else{
        rect[(z-i*2) % 64 /16].leds[i][row][col] = false;
        }
       //rect[z % 64 /16].leds[i][3-col][row] = false;
        //text(b[z],DIM,height/2);
        //row = (row + 1) % 4;
        //if(z % 4 == 0 && firstTime == false)
        if(row % 4 ==3)
        col = (col + 1) % 4;
        //firstTime=false;
        row = (row + 1) % 4;
        //row = (row + 1) % 4;
        //firstTime = false;
  }
    println("TEST" + i);
    timing[i] = (b[64 + 66 * i] - 48) * 10 + (b[65+66*i]-48);
  }
}

/*void load(File selection){
  byte b[] = loadBytes(selection);
  int row=0;
  int col=0;
  boolean firstTime = true;
  maxCount = int(b.length/64) - 1;
  //if(maxCount > 5)
  //count = maxCount - 5;
  for(int i=0 ;i<=maxCount;i++){
   // firstTime=true;
    row=0;
    col=0;
  for(int z=0 +64*i;z < 64 + 64 *i;z++){
    if (z % 16 ==0) firstTime = true;
        if(b[z] - 48 == 1){
        
        rect[z % 64 /16].leds[i][row][col] = true;
        println("row:"+row+" col: "+col);
       //rect[z % 64 /16].leds[i][3-col][row] = true;
        }
        else{
        rect[z % 64 /16].leds[i][row][col] = false;
        }
       //rect[z % 64 /16].leds[i][3-col][row] = false;
        //text(b[z],DIM,height/2);
        //row = (row + 1) % 4;
        //if(z % 4 == 0 && firstTime == false)
        if(row % 4 ==3)
        col = (col + 1) % 4;
        //firstTime=false;
        row = (row + 1) % 4;
        //row = (row + 1) % 4;
        //firstTime = false;
  }
    println("TEST" + i);
    timing[0]=0;
  }
}*/
