class Grass {
  PVector pos, growthRate, floor;
  float tipHeight;
  float adjR, adjG, adjB;
  Grass(float x, float y, float z) {
    pos = new PVector(x, y, z);
    floor = new PVector(x, y, z);
    growthRate = new PVector(0, random(-1, -.2), 0);
    tipHeight = 95;
    
    int diff = 20;
    adjR = random(-diff, diff);
    adjG = random(-diff, diff);
    adjB = random(-diff, diff);
  }

  void grow() {

    PVector dist = PVector.sub(pos, floor); 
    float grassSq = dist.magSq();
    if (grassSq < tipHeight * tipHeight)
      pos.add(growthRate);
  }

  void display() {
    pushStyle();
    //blendMode(ALPHA);
    //blendMode(ADD);

    noStroke();
    if (frameRate % 5 == 0)
      fill(33 + adjR, 150 + adjG, 80 + adjB);
    else
      fill(90 + adjR, 206 + adjG, 102 + adjB);
    
    float wave = noise((frameCount+pos.z) * 0.15) * 50 - 30;
    
    beginShape(POLYGON);
    curveVertex(pos.x + 10, floor.y, pos.z); // control point
    curveVertex(pos.x + 5, floor.y, pos.z);
    curveVertex(wave*0.4 + pos.x + 3, floor.y - (floor.y - pos.y) * 0.4, pos.z + 1);
    curveVertex(wave + pos.x + random(-1, 1), pos.y, pos.z + random(-1, 2));
    curveVertex(wave*0.4 + pos.x + 1, floor.y - (floor.y - pos.y) * 0.6, pos.z + 3);
    curveVertex(pos.x, floor.y, pos.z + 5);
    curveVertex(pos.x, floor.y, pos.z + 10); // control point
    endShape();

    popStyle();
  }
}
