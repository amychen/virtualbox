class Ball {
  PVector pos, vel, acc;
  float size;
  color clr;
  
  Ball(float x, float y, float z, color c){
    pos = new PVector(x, y, z);
    vel = new PVector(random(1,5), random(1,5), random(1,5));
    size = random(20, 50);
    clr = c;
  }
  
  void travel(){
    pos.add(vel);
  }
  
  void checkTouched(PVector constrain){
    if (pos.x < -constrain.x){
      pos.x = lerp(pos.x, -constrain.x, 0.1);
      vel.x *= -1;
    } else if (pos.x > constrain.x){
      pos.x = lerp(pos.x, constrain.x, 0.1);
      vel.x *= -1;
    }
    
    if (pos.y < -constrain.y){
      pos.y = lerp(pos.y, -constrain.y, 0.1);
      vel.y *= -1;
    } else if (pos.y > constrain.y ){
      pos.y = lerp(pos.y, constrain.y, 0.1);
      vel.y *= -1;
    }
    
    if (pos.z < -constrain.z){
      pos.z = lerp(pos.z, -constrain.z, 0.1);
      vel.z *= -1;
    } else if (pos.z > constrain.z){
       pos.z = lerp(pos.z, constrain.z, 0.1);
       vel.z *= -1;
    }
  }
  
  void display(){
    pushMatrix();
    pushStyle();
    stroke(clr);
    translate(pos.x, pos.y, pos.z);
    rotateX(frameRate*0.01);
    sphere(size);
    popStyle();
    popMatrix();
  }
}
