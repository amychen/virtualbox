void initBox(){
  //float rotY = map(head.x, -cubeWidth/2, cubeWidth, -PI/2, PI/2);
 
  //float rotY = map(mouseX, 0, width, -PI, PI);
  float rotY = frameCount * 0.01;
  rotateY(rotY);
  
  noStroke();
  noFill();
  box(cubeWidth);
  //hint(DISABLE_DEPTH_TEST);
  //box(cubeWidth);
}
