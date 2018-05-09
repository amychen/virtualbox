class Ball {
  PVector pos, vel, acc;
  float size;
  color clr;
  int count;
  
  Ball(float x, float y, color c){
    pos = new PVector(x, y, -500);
    vel = new PVector(0, 0, random(30, 40));
    size = random(30, 50);
    clr = c;
    count = 0;
  }
  
  void travel(){
    size = map(pos.z, -500, 500, 50, 10); 
    pos.add(vel);
  }
 
  void checkTouched(PVector constrain){
    if (pos.z == constrain.z && pos.y == constrain.y && pos.x == constrain.x || count > 4)
    {
      fill(color(random(0, 255), random(0, 255), random(0, 255)));
      pos = new PVector((random(-cubeWidth/2, cubeWidth/2)), 
                         random(-cubeWidth/2, cubeWidth/2), -500);
      count = 0;
    } 
 
    if (pos.z >= 500)
    {
       pos.z = lerp(pos.z, 500, 0.1);
       vel.z *= -1;
       count++;
    } 
    
    if (pos.z <= -500)
    {
      pos.z = lerp(pos.z, -500, 0.1);
      vel.z *= -1;
      count++;
    }
  }
  
  void display(){
    pushMatrix();
    pushStyle();
    noStroke();
    fill(clr);
    translate(pos.x, pos.y, pos.z);
    sphere(size);
    popStyle();
    popMatrix();
  }
}
