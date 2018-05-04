class Grass {
  PVector pos, growthRate, floor;
  PShape grass;
  float tipHeight;
  
  Grass(float x, float y, float z) {
    pos = new PVector(x, y, z);
    floor = new PVector(x, y, z);
    growthRate = new PVector(0, random(-1, -.2), 0);
    tipHeight = random(20, 65);
  }
  
  void grow(){
    PVector dist = PVector.sub(pos, floor); 
    float grassSq = dist.magSq();
    if (grassSq < tipHeight * tipHeight)
      pos.add(growthRate);
  }
  
  void display(){
    pushMatrix();
    pushStyle();
    
    stroke(33, 150, 80);
    fill(33, 150, 80);
    
    grass = createShape();
    
    beginShape(POLYGON);
    curveVertex(pos.x + 10, floor.y, pos.z);
    curveVertex(pos.x + random(-5, 5), pos.y, pos.z + random(-5, 5));
    curveVertex(pos.x - 10, floor.y, pos.z);
    curveVertex(pos.x, floor.y, pos.z + 10);
    endShape();
    
    popStyle();
    popMatrix();
  }
}
