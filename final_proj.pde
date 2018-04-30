//https://github.com/MOQN/IMA-Kinetic-Interfaces/blob/master/w09_kinect/_ForWindows/w09_05_kinect_pointCloud_registeredImage/w09_05_kinect_pointCloud_registeredImage.pde
PImage depthImg;
PImage colorImg;

ArrayList<Point> points = new ArrayList<Point>();

void setup(){
  size(1000, 600, P3D);
  kinectSetup();
  
  //depthImg = new PImage(kinect2.WIDTHDepth, kinect2.HEIGHTDepth, ARGB);
  depthImg = new PImage(wndWidth, wndHeight, ARGB);
  colorImg = new PImage(wndWidth, wndHeight, ARGB);
  
  initGUI();
}

void draw(){
  background(0);
  
  pushMatrix();
  //float rotY = map(mouseX, 0, width, -PI, PI);
  float rotY = frameCount * 0.01;
  
  translate(width / 2, height / 2);
  rotateY(rotY);
  
  stroke(214, 230, 255);
  fill(214, 230, 255, 70);
  hint(DISABLE_DEPTH_TEST);
  box(wndWidth/1.3);
  
  colorImg = kinect2.getRegisteredImage().copy();
  
  //int[] rawDepth = kinect2.getRawDepthData();
  int[] rawDepth = kinect2.getRawDepth();
  depthImg.loadPixels();
  
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];
    int x = i % kinect2.depthWidth;
    int y = floor(i / kinect2.depthWidth);
    
    tMin = int(thresholdRange.getArrayValue(0));
    tMax = int(thresholdRange.getArrayValue(1));
    
    if (depth >= tMin && depth <= tMax && depth != 0) {
      if (x % pointSpaces == 0 && y % pointSpaces == 0){
        float r = red(colorImg.pixels[i]);
        float g = green(colorImg.pixels[i]);
        float b = blue(colorImg.pixels[i]);
        
        float px = map(x, 0, wndWidth, -wndWidth/2, wndWidth/2);
        float py = map(y, 0, wndHeight, -wndHeight/2, wndHeight/2);
        float pz = map(depth, 1, 4499, 500, -500);
        
        depthImg.pixels[i] = color(r, g, b);
        points.add(new Point(px, py, pz, color(r, g, b)));
      }
    } else {
      depthImg.pixels[i] = color(0, 0, 0, 0);
    }
  }
  depthImg.updatePixels();
  
  for (Point p : points) {
    p.display();
  }
  
  while (points.size() > 1000){
    points.remove(0);
  }
  
  imageMode(CENTER);
  image(depthImg, 0, 0);
  popMatrix();
}
