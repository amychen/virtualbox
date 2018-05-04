void ballDisplay(){
  ball.travel();
  ball.checkTouched(new PVector(cubeWidth/2, cubeWidth/2, cubeWidth/2));
  ball.display();
}

void pointDisplay(){
  for (Point pt : points) {
    pt.display();
  }
}

void deletePointDisplay(){
  while (points.size() > 1000){
      points.remove(0);
    }
  while (particles.size() > 750){
    particles.remove(0);
  }
  while (grasses.size() > 1000) {
    grasses.remove(0);
  }
  
  PVector leftRightHand = PVector.sub(leftHand, rightHand); 
  float leftRightHandSq = leftRightHand.magSq();
  
  if (leftRightHandSq < 100 && leftRightHand.x == head.x && leftRightHand.y > head.y){
    particles = new ArrayList<Particle>();
  }
}

void grassDisplay(){
  
  for (Grass grass : grasses){
    grass.grow();
    grass.display();
  }
}
