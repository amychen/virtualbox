void initBox(){
  //float rotY = map(mouseX, 0, width, -PI, PI);
  float rotY = frameCount * 0.01;
  rotateY(rotY);
  
  pushStyle();
  stroke(214, 230, 255);
  fill(214, 230, 255, 50);
  box(cubeWidth);
  hint(DISABLE_DEPTH_TEST);
  box(cubeWidth);
  
  beginShape(QUADS);
  fill(86, 58, 58, 100);
  vertex(-cubeWidth/2, cubeWidth/2, cubeWidth/2);
  vertex( cubeWidth/2, cubeWidth/2, cubeWidth/2);
  vertex( cubeWidth/2, cubeWidth/2, -cubeWidth/2);
  vertex(-cubeWidth/2, cubeWidth/2, -cubeWidth/2);
  endShape();
  
  beginShape(QUADS);
  fill(139, 166, 233, 100);
  vertex(-cubeWidth/2, -cubeWidth/2, -cubeWidth/2);
  vertex( cubeWidth/2, -cubeWidth/2, -cubeWidth/2);
  vertex( cubeWidth/2, -cubeWidth/2,  cubeWidth/2);
  vertex(-cubeWidth/2, -cubeWidth/2,  cubeWidth/2);
  endShape();
  
  popStyle();
}
