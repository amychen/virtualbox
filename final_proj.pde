//https://github.com/MOQN/IMA-Kinetic-Interfaces/blob/master/w09_kinect/_ForWindows/w09_05_kinect_pointCloud_registeredImage/w09_05_kinect_pointCloud_registeredImage.pde
PImage depthImg;
PImage colorImg;
float cubeWidth;

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Grass> grasses = new ArrayList<Grass>();

Ball ball;

void setup(){
  size(1200, 600, P3D);
  kinectSetup();
  
  //depthImg = new PImage(kinect2.WIDTHDepth, kinect2.HEIGHTDepth, ARGB);
  depthImg = new PImage(wndWidth, wndHeight, ARGB);
  colorImg = new PImage(wndWidth, wndHeight, ARGB);
  
  initGUI();
  cubeWidth = wndWidth/1.25;
  color c = color(215, 186, 255);
  ball = new Ball(random(-cubeWidth, cubeWidth), random(-cubeWidth, cubeWidth), 
                  random(-cubeWidth, cubeWidth), c);
                  
  for (float x = -cubeWidth/2; x < cubeWidth/2; x += random(10,20)){
    for (float z = -cubeWidth/2; z < cubeWidth/2; z += random(10,20)){
      grasses.add(new Grass(x, cubeWidth/2, z));
      //grasses.add(new Grass(-cubeWidth/2+150, cubeWidth/2+150, -cubeWidth/2-300));
    }
  }
  
}

void draw(){
  background(0);
  
  pushMatrix();
  translate(width / 2, height / 2);
  
  initBox();
  enableSkeleton();
  
  colorImg = kinect2.getRegisteredImage().copy();
  
  //int[] rawDepth = kinect2.getRawDepthData();
  int[] rawDepth = kinect2.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];
    int x = i % kinect2.depthWidth;
    int y = floor(i / kinect2.depthWidth);
    
    tMin = int(thresholdRange.getArrayValue(0));
    tMax = int(thresholdRange.getArrayValue(1));
    
    float px = map(x, 0, wndWidth, -wndWidth/2, wndWidth/2);
    float py = map(y, 0, wndHeight, -wndHeight/2, wndHeight/2);
    float pz = map(depth, 1, 4499, 200, -200);
    
    if ((depth >= tMin && depth <= tMax && depth != 0) &&
       (x % pointSpaces == 0 && y % pointSpaces == 0)){
        float r = red(colorImg.pixels[i]);
        float g = green(colorImg.pixels[i]);
        float b = blue(colorImg.pixels[i]);
        points.add(new Point(px, py, pz, color(r, g, b)));
    } else 
    {
      color clr = color(234, 242, 255);
      if ((x % rainAmt == 0 && y % rainAmt == 0 )){
        particles.add(new Particle(random(-200, 200), 
                                   random(-cubeWidth/2, cubeWidth/2), 
                                   random(-cubeWidth/2, cubeWidth/2), clr));
      }
    }
  }
  
  grassDisplay();
  pointDisplay();
  ballDisplay();
  
  ellipse(leftHand.x, leftHand.y, 10, 10);
  
  for (int i = 0; i < particles.size(); i++){
    Particle p = particles.get(i);
    PVector gravity = new PVector(0, 1);
    boolean particleTouched = false;
    boolean ballTouched = false;
    for (Point pt : points) {
      PVector ptparticle = PVector.sub(pt.pos, p.pos); 
      PVector ptBall = PVector.sub(pt.pos, ball.pos); 
      float ptparticleSq = ptparticle.magSq();
      float ptBallSq = ptBall.magSq();
      if (ptparticleSq < 900) {
        particleTouched = true;
      } 
      if (ptBallSq < 900) {
        ballTouched = true;
      }
    }
    if (particleTouched){
      p.bounce(p.pos);
      particles.remove(i);
    } else {
      p.applyForce(gravity);
      p.checkFloor();
      p.fall();
    }
    p.applyRestitution(.1);
    p.display();
    
    if (ballTouched) {
      stroke(random(0,255), random(0,255), random(0,255));
      ball.checkTouched(leftHand);
      ball.checkTouched(rightHand);
      ball.checkTouched(leftFoot);
      ball.checkTouched(rightFoot);
    }
  }
  
  deletePointDisplay();
  
  imageMode(CENTER);
  image(depthImg, 0, 0);
  popMatrix();
}
