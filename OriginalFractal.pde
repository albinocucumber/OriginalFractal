float startSize = 200;
float angle1, angle2;
Particle [] quantum = new Particle[500];

void setup() {
  size(800, 500);
  noSmooth();
  for(int i = 0; i < quantum.length; i++){
    quantum[i] = new Particle();
  }
}

void draw() {
  background(0);
  for(int i = 0; i < quantum.length; i++){
    quantum[i].move();
    quantum[i].show();
  }
  stroke(210,105,30);
  fill(34,139,34);
  rect(0, height / 2 + startSize, width, height);
  translate(width / 2, height / 2 + startSize);
  angle1 = map(mouseY, 0, height, 0, PI); //angle between branches
  angle2 = map(mouseX, 0, width, -HALF_PI, HALF_PI);  //angle of center branch from center
  drawFractal(startSize);
}

void drawFractal(float lineSize) {
  if (lineSize > 1) {
    if (lineSize != startSize) {
      rotate(angle2);
    }
    translate(0, -lineSize);
    line(0, 0, 0, lineSize);
    rotate(-angle1);
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      drawFractal(lineSize / 2);
      popMatrix();
      rotate(angle1);
    }
  }
}

class Particle{
  float myX, myY;
  double speed, myAngle, distance;
  int myColor, mySize;
  Particle(){
    myX = (float)((Math.random() * 50) + 375);
    myY = (float)((Math.random() * 50) + 375);
    mySize = (int)(Math.random() * 4 + 1);
    distance = dist(250, 250, myX, myY);
    myAngle = Math.random() * TWO_PI;
    myColor = color((int)(Math.random()* 255 + 150),(int)(Math.random()* 255 + 150), (int)(Math.random()* 255 + 150));
  }
  void move(){
    if((myX > 800 || myX < 0) || (myY > 800 || myY < 0)){
      myX = (float)((Math.random() * 50) + 375);
      myY = (float)((Math.random() * 50) + 375);
    }
    if(mousePressed && mouseButton == LEFT){
      speed = distance/10;
    } else if(mousePressed && mouseButton == RIGHT){
      speed = distance/50;
    } else {
      speed = distance/20;
    }
    myX += speed * Math.cos(myAngle);
    myY += speed * Math.sin(myAngle);
  }
  void show(){
    stroke(myColor);
    fill(myColor);
    ellipse(myX, myY, mySize, mySize);
  }
}
