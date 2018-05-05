class Drop{
  PVector pos, vel, acc;
  color clr;
  float len;
  
  Drop(float x, float y, float z){
    pos = new PVector(x, y, z);
    vel = new PVector(0, random(1, 5));
    acc = new PVector(0,1);
    len = random(5, 10);
  }
  
  void fall(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void applyForce(PVector force){
    PVector f = force.copy();
    acc.add(f);
  }
  
  void applyRestitution(float amt){
    float val = 1 - amt;
    vel.mult(val);
  }
  
  void checkFloor() {
    if (pos.y > cubeWidth/2)
      pos.y = -cubeWidth/2;
  }
  
  void display(){
    pushMatrix();
    stroke(255);
    translate(pos.x, pos.y, pos.z);
    line(0, 0, 0, len);
    popMatrix();
  }
}
