void initBox(){
  //float rotY = map(leftHand.x, 0, width/2-cubeWidth/2, -PI, PI);
  float rotY = frameCount * 0.01;
  rotateY(rotY);
  
  noStroke();
  //stroke(214, 230, 255);
  //fill(214, 230, 255, 50);
  //box(cubeWidth);
  //hint(DISABLE_DEPTH_TEST);
  //box(cubeWidth);
  
  beginShape(QUADS);
  fill(86, 58, 58, 20);
  vertex(-cubeWidth/2, cubeWidth/2, cubeWidth/2);
  vertex( cubeWidth/2, cubeWidth/2, cubeWidth/2);
  vertex( cubeWidth/2, cubeWidth/2, -cubeWidth/2);
  vertex(-cubeWidth/2, cubeWidth/2, -cubeWidth/2);
  endShape();
  
}
