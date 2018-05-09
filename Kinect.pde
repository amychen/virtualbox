import KinectPV2.*;
import KinectPV2.KJoint;

KinectPV2 kinect2;

PVector leftHand, rightHand, leftFoot, rightFoot, head;

int wndWidth = 0;
int wndHeight = 0;

void kinectSetup() {
  kinect2 = new KinectPV2(this);
  kinect2.enableColorImg(true);
  kinect2.enableDepthImg(true); 
  kinect2.enablePointCloud(true);
  kinect2.enableSkeletonDepthMap(true);
  kinect2.init();

  wndWidth = kinect2.WIDTHDepth;
  wndHeight = kinect2.HEIGHTDepth;

  leftHand = new PVector();
  rightHand = new PVector();
  leftFoot = new PVector();
  rightFoot = new PVector();
  head = new PVector();
}

void enableSkeleton() {
  ArrayList<KSkeleton> skeletonArray = kinect2.getSkeletonDepthMap();
  for (int i = 0; i < skeletonArray.size(); i++) {  
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      float[] lH = position(joints[KinectPV2.JointType_HandLeft]);
      float[] rH = position(joints[KinectPV2.JointType_HandRight]);

      float[] lF = position(joints[KinectPV2.JointType_FootLeft]);
      float[] rF = position(joints[KinectPV2.JointType_FootRight]);

      float[] h = position(joints[KinectPV2.JointType_Head]);

      leftHand.x = lH[0];
      leftHand.y = lH[1];
      leftHand.z = lH[2];

      rightHand.x = rH[0];
      rightHand.y = rH[1];
      rightHand.z = rH[2];

      leftFoot.x = lF[0];
      leftFoot.y = lF[1];
      leftFoot.z = lF[2];

      rightFoot.x = rF[0];
      rightFoot.y = rF[1];
      rightFoot.z = rF[2];

      head.x = h[0];
      head.y = h[1];
      head.z = h[2];
    }
  }
}

void displaySkeleton() {
  pushMatrix();
  pushStyle();
  strokeWeight(20);
  stroke(255);
  //point(leftHand.x, leftHand.y, leftHand.z);
  //point(rightHand.x, rightHand.y, rightHand.z);
  //point(leftFoot.x, leftFoot.y, leftFoot.z);
  //point(rightFoot.x, rightFoot.y, rightFoot.z);
  //point(head.x, head.y, head.z);
  popStyle();
  popMatrix();
}


boolean skeletonExist() {
  ArrayList<KSkeleton> skeletonArray =  kinect2.getSkeletonDepthMap();
  for (KSkeleton skeleton : skeletonArray) {
    if (skeleton.isTracked()) {
      return true;
    }
  }
  return false;
}


float[] position(KJoint joint) {
  float[] coord = new float[3];
  float jointX, jointY, jointZ;
  int index = int(joint.getX()) + int(joint.getY()) * wndWidth;
  if (index >= 0 && index < rawDepth.length) {
    jointX = map(joint.getX(), 0, wndWidth, width/2 - cubeWidth/2, width/2 + cubeWidth/2);
    jointY = map(joint.getY(), 0, wndHeight, height/2 - cubeWidth/2, height/2 + cubeWidth/2);
    jointZ = map(rawDepth[index], 1, 4499, -500, 500);
  } else {
    jointX = -100000;
    jointY = -100000;
    jointZ = -100000;
  }

  //println("x " + jointX);
  //println("y " + jointY);

  coord[0] = jointX;
  coord[1] = jointY;
  coord[2] = jointZ ;

  return coord;
}

boolean handOverHead() {
  PVector leftRightHand = PVector.sub(leftHand, rightHand); 
  float leftRightHandSq = leftRightHand.magSq();

  if (leftRightHandSq < 10000 && skeletonExist() && leftHand.y < head.y) {
    return true;
  }
  return false;
}

void updateRegisteredImage() {
  float [] mapDtoC = kinect2.getMapDepthToColor();

  kinect2.getColorImage();
  int[] rawColor = kinect2.getRawColor();
  int cw = KinectPV2.WIDTHColor;
  int ch = KinectPV2.HEIGHTColor;

  colorImg.loadPixels();
  for (int y = 0; y < wndHeight; y += 2) {
    for (int x = 0; x < wndWidth; x += 2) {
      int i = x + y*wndWidth;
      int cx = (int) mapDtoC[i*2 + 0];
      int cy = (int) mapDtoC[i*2 + 1];
      if (cx > 0 && cx < cw && cy > 0 && cy < ch) {
        int cIndex = cx + cy*cw;
        colorImg.pixels[i] = rawColor[cIndex];
      }
    }
  }
  colorImg.updatePixels();
}
