ArrayList<Drop> drop = new ArrayList<Drop>();
ArrayList<Grass> grasses = new ArrayList<Grass>();
ArrayList<Butterfly> butterflies = new ArrayList<Butterfly>();
ArrayList<Ball> balls = new ArrayList<Ball>();

int[] rawDepth;

PImage colorImg;
float cubeWidth = 0;
float life = 5;

Ball ball;
Butterfly butterfly;

void setup() {
  //size(1500, 1140, P3D); 
  fullScreen(P3D);
  sphereDetail(10);

  kinectSetup();
  cubeWidth = width/3;
  colorImg = new PImage(wndWidth, wndHeight, ARGB);
  initGUI();
  color c = color(215, 186, 255);
  //ball = new Ball(0, 0, c);
  balls.add(new Ball(0, 0, c));
  for (int i = 0; i < 4; i++) {
    butterflies.add(new Butterfly(random(-cubeWidth/2, cubeWidth), 
      random(-cubeWidth/2, cubeWidth), 
      random(-cubeWidth/2, cubeWidth)));
  }

  for (float x = -cubeWidth/2; x < cubeWidth/2; x += 35) {
    for (float z = -cubeWidth/2; z < cubeWidth/2; z += 35) {
      grasses.add(new Grass(x + random(-15, 15), cubeWidth/2, z + random(-15, 15)));

      if (x % rainAmt < 100 && z % rainAmt < 100){
        drop.add(new Drop(random(-cubeWidth/2, cubeWidth/2), 
                           random(-cubeWidth/2, cubeWidth/2), 
                           random(-cubeWidth/2, cubeWidth/2)));
      }
    }
  }
}

void draw() {
  background(0);
  rawDepth = kinect2.getRawDepthData();

  updateRegisteredImage();
  enableSkeleton();
  displaySkeleton();

  if (life >= 0 && skeletonExist()){
    pushMatrix();
    translate(width / 2, height / 2);
  
    initBox();
  
    butterflyDisplay();
    grassDisplay();
  
    tMin = int(thresholdRange.getArrayValue(0));
    tMax = int(thresholdRange.getArrayValue(1));
    float px = 0, py = 0, pz = 0;
    for (int y = 0; y < wndHeight; y += pointSpaces) {
      for (int x = 0; x < wndWidth; x += pointSpaces) {
        int i = x + y * wndWidth;
        int depth = rawDepth[i];
        if (depth > tMin && depth < tMax && depth != 0) {
          px = map(x, 0, wndWidth, -cubeWidth/2, cubeWidth/2);
          py = map(y, 0, wndHeight, -cubeWidth/2, cubeWidth/2);
          pz = map(depth, 1, 4499, 500, -500);
  
          float r = red(colorImg.pixels[i]);
          float g = green(colorImg.pixels[i]);
          float b = blue(colorImg.pixels[i]);
          
          pushStyle();
          stroke(color(r, g, b));
          strokeWeight(10);
          point(px, py, pz);
          popStyle();
          
          
          for (Ball bl : balls){
            PVector ballPt = PVector.sub(bl.pos, new PVector(px, py, pz)); 
            float ballPtSq = ballPt.magSq();
             if (ballPtSq < 50) {
               ellipse(bl.pos.x, bl.pos.y, 100, 100);
               pushMatrix();
               rotateY(PI);
               textSize(200);
               fill(255);
               text("Gotcha" , 0, 0);
               popMatrix();
               life--;
               
               balls = new ArrayList<Ball>();
               break;
             } 
          }
        }
      }
    }
    
  
    if (frameCount % 100 == 0) {
      color c = color(random(0, 255), random(0, 255), random(0, 255));
      if (balls.size() < 7) {
        balls.add(new Ball(random(-cubeWidth/2, cubeWidth/2), 
          random(-cubeWidth/2, cubeWidth/2), c));
      } else {
        balls.remove(0);
      }
    }
  
    for (int i = 0; i < balls.size(); i++) {
      Ball b = balls.get(i);
      if (!handOverHead())
        b.travel();
      b.display();     
   
      b.checkTouched(new PVector(0, 0, 0));
    }
  
    PVector gravity = new PVector(0, 1);
    for (Drop d : drop) {
      d.applyForce(gravity);
      d.fall();
      d.applyRestitution(.1);
      if (!handOverHead())
        d.display();
        
      d.checkFloor(); 
    }
    popMatrix();
  } else {
    fill(255);
    text("Game Over", 0, 0);
  }
  fill(255);
  textSize(50);
  //text(frameRate, 10, 260);
  text("Life " + life, 100, 300);
}
