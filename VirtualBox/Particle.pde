class Particle{
  PVector pos, vel, acc;
  color clr;
  Particle(float x, float y, float z, color c){
    pos = new PVector(x, y, z);
    vel = new PVector(0, random(1, 5));
    acc = new PVector(0,1);
    clr = c;
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
  
  void bounce(PVector loc){
     if (pos.x > loc.x){
      pos.x = loc.x;
      vel.mult(random(-1, -.5));
    } 
    if (pos.y > loc.y){
      pos.y = loc.y;
      vel.mult(random(-1, -.5));
    }
    if (pos.z > loc.z){
      pos.z = loc.z;
      vel.mult(random(-1, -.5));
    }
  }
  
  void checkFloor() {
    pushStyle();
    fill(color(0, 255, 255));
    if (pos.y > cubeWidth/2){
      pos.y = cubeWidth/2;
      vel.mult(random(-2, -1));
    }
    if (pos.z > cubeWidth/2){
      pos.z = cubeWidth/2;
      vel.mult(random(-2, -1));
    }
    if (pos.x > cubeWidth/2){
      pos.x = cubeWidth/2;
      vel.mult(random(-2, -1));
    }
    popStyle();
  }
  
  void display(){
    pushStyle();
    pushMatrix();
    
    float size = map(pos.y, -212, 212, .2, 1.2);
    
    noStroke();
    fill(clr);
    translate(pos.x, pos.y, pos.z);
    for (int i = 2; i < 4; i++ ) {
      ellipse(0, i*10-50,i*size,i*size);
    }
    
    popMatrix();
    popStyle();
  }
}
