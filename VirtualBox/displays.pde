void grassDisplay(){
  for (Grass g : grasses){
    g.grow();
    g.display();
  }
}

void butterflyDisplay(){
  fill(255, 100);
  noStroke();
  pushStyle();
  blendMode(EXCLUSION);
  for (Butterfly b : butterflies){
    b.checkEdge();
    b.fly();
    b.wingAng();
    b.flapLeft();
    b.flapRight();
  }
  popStyle();
}
