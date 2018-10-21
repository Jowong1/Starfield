Particle[] particles;
Particle spots;
Particle big;
double rectSize = 0;
int onClick = 0;
boolean expand = true;
double fader = 0;
double whiteColor = 10;
boolean magnify = false;
float spread = 0.0;
float ellpShader = 0.0;
//
void setup()
{
  size(800,800);
  background(0);
  noStroke();
  particles = new Particle[500];
  for(int nI = 0; nI < particles.length; nI++){
      particles[nI] = new NormalParticle();
  }
  big = new JumboParticle();
  spots = new OddBallParticle(width/2, height/2, -0.02, 30.0); // s => -0.1 is very cool too!
}
//void mouseClicked(){
//  onClick = onClick + 1;
//  if(expand == true){
//    expand = false;
//  }else{
//    expand = true;
//  }
//}
void mousePressed(){
  onClick = onClick + 1;
  magnify = true;
  if(expand == true){
    expand = false;
  }else{
    expand = true;
  }
}
void mouseReleased(){
  magnify = false;
}
  
void draw()
{
  fill(0,0,0,(float)fader);
  fader = fader + 0.01;
  //rect(0,0,800,800);
  fill(0,0,0,100);
  //rect(0,0,800,800);
  //rect(mouseX-(float)rectSize/2,mouseY-(float)rectSize/2,(float)rectSize,(float)rectSize);
  ellipse(mouseX,mouseY,(float)rectSize,(float)rectSize);
  for(int i = 0; i < particles.length; i++){
    particles[i].move();
    particles[i].show();
  }
  big.move();
  big.show();
  spots.move();
  spots.show();
}
class NormalParticle implements Particle
{
  double myX, myY, mySpeed, myAngle, myRotate;
  double mySize = 1;
  //int myAngle;
  NormalParticle(){
    myAngle = (Math.random()*2 * Math.PI);
    mySpeed = (Math.random()*15);
    //d = Math.random()*400;
    //spd = .1;//(Math.random()*6)+1;
    //tha = (Math.random()*4*(Math.PI)-(2*(Math.PI))); //Use radians, 30 degrees
    //eys = color(255);
    myX = (Math.sin(5)*2)+400;
    myY = (Math.cos(5)*2)+400;
    //myRotate = (int)(Math.random()*2)-1;
    myRotate = 10;
  }
void move(){
    myX = (Math.cos(myAngle)*mySpeed) + myX;
    myY = (Math.sin(myAngle)*mySpeed) + myY;
    //spd = spd + 0.5;
    // out = out-0.0008;
    //if (rot > 0){
    //  tha = (tha + 0.05);//out;
    //}else if (rot < 0 ){
    //  tha = (tha - 0.05);
    //}else{
    //  tha = tha + 0;
    //}
  }
  void show(){
    int randomFade = (int)(Math.random()*50)+0;
    fill((float)whiteColor,(float)whiteColor,(float)whiteColor,randomFade);
    ellipse((float)myX, (float)myY, (float)mySize, (float)mySize);
    whiteColor = whiteColor + 0.0005;
    mySize = mySize + 0.1;
    if(magnify == true){
      rectSize = rectSize + 0.005;
    }
    //if(rectSize < 200 && onClick == 1){
    //  rectSize = rectSize + 0.005;
    //}else if(rectSize < 400 && onClick == 2 && rectSize > 199){
    //  rectSize = rectSize + 0.005;
    //}else if(rectSize < 600 && onClick == 3 && rectSize > 399){
    //  rectSize = rectSize + 0.005;
    //}else if(rectSize < 2000 && onClick == 4 && rectSize > 599){
    //  rectSize = rectSize + 0.005;
    //}else if(rectSize < 200 && onClick == 2){
    //  onClick = 2;
    //  if(expand == true){
    //    rectSize = rectSize + 0.005;
    //  }
    //}
  }
}
interface Particle
{
  public void show();
  public void move();
}
class OddBallParticle implements Particle //uses an interface
{
  float x, y, speed;
    float angle = 0.0;
    float dim;
  OddBallParticle(float xpos, float ypos, float s, float d) {
      x = xpos;
      y = ypos;
    speed = s;
    dim = d;
  }
  void move() {
    angle += speed;
    speed = speed + 0.000001;
    ellpShader = ellpShader + 0.05;
  }
  void show() {
    noStroke();
    pushMatrix();
    translate(x, y);
    angle += speed;
    rotate(angle);
    fill((float)whiteColor, (float)whiteColor, (float)whiteColor, ellpShader);
    ellipse((dim/2) + spread, spread, dim, dim);
    ellipse((dim/2) + spread, spread, dim, dim);
    spread = spread + 0.1;
    popMatrix();
  }
}
class JumboParticle extends NormalParticle //uses inheritance
{
  JumboParticle(){
    mySize = 20;
    mySpeed = 3;
  }
}
