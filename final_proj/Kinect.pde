//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
import KinectPV2.*;
import KinectPV2.KJoint;

//Kinect2 kinect2;
KinectPV2 kinect2;

PVector leftHand, rightHand, leftFoot, rightFoot, head;

int wndWidth;
int wndHeight;

void kinectSetup(){
  kinect2 = new KinectPV2(this);
  kinect2.enableDepthImg(true);
  kinect2.enableColorImg(true); 
  kinect2.enablePointCloud(true);
  
  kinect2.enableSkeletonColorMap(true);
  kinect2.enableColorImg(true);

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
  pushMatrix();
  float rotY = frameCount * 0.01;
  rotateY(rotY);
  ArrayList<KSkeleton> skeletonArray =  kinect2.getSkeletonColorMap();

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      float[] lh = drawBodyParts(joints[KinectPV2.JointType_HandLeft]);
      float[] rh = drawBodyParts(joints[KinectPV2.JointType_HandRight]);
      
      float[] lf = drawBodyParts(joints[KinectPV2.JointType_FootLeft]);
      float[] rf = drawBodyParts(joints[KinectPV2.JointType_FootRight]);
      
      float[] h = drawBodyParts(joints[KinectPV2.JointType_Head]);
      
      leftHand.x = lh[0];
      leftHand.y = lh[1];
      leftHand.z = lh[2];
      
      rightHand.x = rh[0];
      rightHand.y = rh[1];
      rightHand.z = rh[2];
      
      leftFoot.x = lf[0];
      leftFoot.y = lf[1];
      leftFoot.z = lf[2];
      
      rightFoot.x = lh[0];
      rightFoot.y = lh[1];
      rightFoot.z = lh[2];
      
      head.x = h[0];
      head.y = h[1];
      head.z = h[2];
    }
  }
  popMatrix();
}

float[] drawBodyParts(KJoint joint) {
  float[] coord = new float[3];
  noStroke();
  
  float jointX = map(joint.getX(), 0, width, width/2-cubeWidth/2, width/2+cubeWidth/2);
  float jointY = map(joint.getY(), 0, height, height/2-cubeWidth/2, height/2+cubeWidth/2);
  //float jointZ = map();
  
  coord[0] = jointX;
  coord[1] = jointY;
  
  ellipse(jointX, jointY, 70, 70);
  return coord;
}

void handOverHead(){
  
}

void updateRegisteredImage() {
  float [] mapDtoC = kinect2.getMapDepthToColor();

  kinect2.getColorImage();
  int[] rawColor = kinect2.getRawColor();
  int cw = KinectPV2.WIDTHColor;
  int ch = KinectPV2.HEIGHTColor;

  colorImg.loadPixels();
  for (int y = 0; y < wndHeight; y++) {
    for (int x = 0; x < wndWidth; x++) {
      int i = x + y*wndWidth;
      int cx = (int) mapDtoC[i*2 + 0];
      int cy = (int) mapDtoC[i*2 + 1];

      if (cx > 0 && cx < cw
        && cy > 0 && cy < ch) {

        int cIndex = cx + cy*cw;
        colorImg.pixels[i] = rawColor[cIndex];
      }
    }
  }
  colorImg.updatePixels();
}
