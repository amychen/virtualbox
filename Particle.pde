class Particle{
  
  Particle(float x, float y, float z){
    PVector pos = new PVector(x, y, z);
  }
  
  void update(){
    
  }
  
  void display(){
    pushMatrix();
    popMatrix();
  }
}
