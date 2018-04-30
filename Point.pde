class Point {
  PVector pos;
  color clr;
  Point(float x, float y, float z, color c){
    pos = new PVector(x, y, z);
    clr = c;
  }
  
  void display(){
    pushStyle();
    pushMatrix();
    
    stroke(clr);
    translate(pos.x, pos.y, pos.z);
    ellipse(0,0, 2, 2);
    
    popMatrix();
    popStyle();
  }
  
}
