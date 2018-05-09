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
    strokeWeight(5);
    translate(pos.x, pos.y, pos.z);
    point(0,0);
    
    popMatrix();
    popStyle();
  }
}
