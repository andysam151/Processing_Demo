int cols = 2000;
int rows = 4200;
int scale = 20;
float[][] terrain = new float[cols/scale][rows/scale];
float go, gox = 0;
String word = "READY?";
int moveX = 0;
int moveY = 0;
float dc = 0.1;
float dcx = 0;
boolean up, down, left, right = false;
PShape s;
float spinx, spiny = 0;

void setup(){
  fullScreen(P3D);
  textMode(SHAPE);
  smooth();
  sphereDetail(100);
  strokeWeight(1);
  s = loadShape("FIRE_ROCKET.obj");
}

void keyPressed() {
  if (keyCode == UP && up == false) up = true;
  if (keyCode == DOWN && down == false) down = true;
  if (keyCode == LEFT && left == false) left = true;
  if (keyCode == RIGHT && right == false) right = true;

}
void keyReleased() {
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
}

void draw(){
  ambientLight(102, 102, 102);
  go -= dc;
  gox -= dcx;
  
  float yoff = go;
  
    if (left && up) {
     moveX -= 5;
     moveY -= 5;
    } else if (left && down) {
     moveX -= 5;
     moveY += 5;
    } else if (right && up) {
     moveX += 5;
     moveY -= 5;
    } else if (right && down) {
     moveX += 5;
     moveY += 5;
    } else if (up) {
      moveY -= 5;
    } else if (down) {
     moveY += 5;
    } else if (left) {
     moveX -= 5;
    } else if (right) {
     moveX += 5;
    } 

  
  for (int y = 0; y < rows/scale; y++){
    float xoff = gox;
    for (int x = 0; x < cols/scale; x++){
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -400, 0);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  background(235);
  stroke(0);
  
  translate(width/2, height/2);
  
  fill(150, 0, 0);
  textSize(100);
  text(word, -textWidth(word)/2, 0); 
  
  rotateX(PI/3);
  
  pushMatrix();
  translate(moveX, moveY);
  shapeMode(CORNER);
  noStroke();
  fill(120, 50, 255);
  box(15,30,15);
  
  translate(0, 0, 35);
  shape(s,-80,-30,55,55);
  spotLight(0, 2055, 0, moveX, moveY, 0, 0, 0, -1, PI/8, 2);
  popMatrix();
  
  translate(-cols/2, -rows/2);
  stroke(235);
  
  for (int y = 0; y < rows/scale - 60; y++){
    float shade = map(y, 0, rows/scale - 60, 255, 150);
    float shade1 = 255;
    float shade2 = map(y, 0, rows/scale - 60, 255, 100);
    fill(shade1, shade2, shade);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols/scale; x++){
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
  }
  
  if (millis() > 6000 && millis() < 8000){
   word = "BEGIN";
  } else if(millis() > 8000){
    word = "";
  }
}
