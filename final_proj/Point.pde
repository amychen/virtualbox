class Point {
  PVector pos;
  color clr;
  
  Point(float x, float y, float z, color c){
    pos = new PVector(x, y, z);
    clr = c;
  }
  void display(){
    //pushStyle();
    stroke(clr);
    strokeWeight(5);
    point(pos.x,pos.y, pos.z);
    //popStyle();
  }
}
