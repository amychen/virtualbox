//https://github.com/MOQN/IMA-Kinetic-Interfaces/blob/master/w09_kinect/_ForWindows/w09_05_kinect_pointCloud_registeredImage/w09_05_kinect_pointCloud_registeredImage.pde
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Drop> drop = new ArrayList<Drop>();
ArrayList<Grass> grasses = new ArrayList<Grass>();
ArrayList<Butterfly> butterflies = new ArrayList<Butterfly>();
PImage colorImg;
float cubeWidth = 0;
boolean ballTouched = false;
boolean particleTouched = false;

Ball ball;
Butterfly butterfly;

void setup(){
  size(1540, 1100, P3D);
  
  sphereDetail(10);
  
  kinectSetup();
  cubeWidth = width/2.3;
  colorImg = new PImage(wndWidth, wndHeight, ARGB);
  
  initGUI();
  color c = color(215, 186, 255);
  ball = new Ball(0, 0, 0, c);
  
  for (int i = 0; i < 4; i++){
    butterflies.add(new Butterfly(random(-cubeWidth/2, cubeWidth), 
                                  random(-cubeWidth/2, cubeWidth), 
                                  random(-cubeWidth/2, cubeWidth)));
  }
  
  for (float x = -cubeWidth/2+25; x < cubeWidth/2; x += 30){
    for (float z = -cubeWidth/2+25; z < cubeWidth/2; z += 30){
      grasses.add(new Grass(x + random(-15, 15), cubeWidth/2, z + random(-15, 15)));
      
      if (x % rainAmt <100  && z % rainAmt < 100){
        drop.add(new Drop(random(-cubeWidth/2, cubeWidth/2), 
                           random(-cubeWidth/2, cubeWidth/2), 
                           random(-cubeWidth/2, cubeWidth/2)));
      }
      
    }
  }
}

void draw(){
  background(0);
  
  //image(colorImg, 0,0);
  enableSkeleton();
  updateRegisteredImage();
  
  pushMatrix();
  translate(width / 2, height / 2);
  
  initBox();
  butterflyDisplay();
  grassDisplay();
  pointDisplay();
  ballDisplay();
  
  tMin = int(thresholdRange.getArrayValue(0));
  tMax = int(thresholdRange.getArrayValue(1));
  int[] rawDepth = kinect2.getRawDepthData();
  for (int i=0; i < rawDepth.length; i += 10) {
    
    int depth = rawDepth[i];
    int x = i % wndWidth;
    int y = floor(i / wndWidth);
    
    if ((depth >= tMin && depth <= tMax && depth != 0) &&
    (x % pointSpaces == 0 && y % pointSpaces == 0)){
      
      float px = map(x, 0, wndWidth, -wndWidth/2, wndWidth/2);
      float py = map(y, 0, wndHeight, -wndHeight/2, wndHeight/2);
      float pz = map(depth, 1, 4499, 500, -500);
      
      float r = red(colorImg.pixels[i]);
      float g = green(colorImg.pixels[i]);
      float b = blue(colorImg.pixels[i]);
      
      fill(color(r, g, b));
      pushMatrix();
      translate(px, py + wndWidth/4, pz);
      ellipse(0, 0, 10, 10);
      popMatrix();
    }
  }
  
  for (int i = 0; i < drop.size(); i++){
    Drop d = drop.get(i);
    PVector gravity = new PVector(0, 1);
    for (Point pt : points) {
      PVector ptparticle = PVector.sub(pt.pos, d.pos); 
      PVector ptBall = PVector.sub(pt.pos, ball.pos); 
      float ptparticleSq = ptparticle.magSq();
      float ptBallSq = ptBall.magSq();
      if (ptparticleSq < 1600) {
        particleTouched = true;
        break;
      } 
      if (ptBallSq < 1600) {
        ballTouched = true;
        break;
      }
    }
    if (particleTouched){
      drop.remove(i);
    } else {
      d.applyForce(gravity);
      d.checkFloor();
      d.fall();
    }
    d.applyRestitution(.1);
    d.display();
  }
  
  if (ballTouched) {
    stroke(random(0,255), random(0,255), random(0,255));
    ball.checkTouched(leftHand);
    ball.checkTouched(rightHand);
    ball.checkTouched(leftFoot);
    ball.checkTouched(rightFoot);
  }
  
  deletePointDisplay();
  popMatrix();
  
  fill(255);
  text(frameRate, 10, 20);
}
