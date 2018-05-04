import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
//import KinectPV2.*;
//import KinectPV2.KJoint;

Kinect2 kinect2;
//KinectPV2 kinect2;

PVector leftHand, rightHand, leftFoot, rightFoot, head;

int wndWidth;
int wndHeight;

void kinectSetup(){
  //kinect2 = new KinectPV2(this);
  //kinect2.enableDepthImg(true);
  //kinect2.enableColorImg(true); 
  //kinect2.enablePointCloud(true);
  //kinect2.init();
  
  kinect2 = new Kinect2(this);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();
  //kinect.enableSkeletonColorMap(true);
  //kinect.enableColorImg(true);
  
  wndWidth = kinect2.depthWidth;
  wndHeight = kinect2.depthHeight;
}

void enableSkeleton(){
  leftHand = new PVector(0,0,0);
  rightFoot = new PVector(0,0,0);
  leftHand = new PVector(0,0,0);
  rightHand = new PVector(0,0,0);
  head = new PVector(0,0,0);
  //ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  //for (int i = 0; i < skeletonArray.size(); i++){
  //  KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    
  //  if (skeleton.isTracked()){
  //    KJoint[] joints = skeleton.getJoints();
      
  //    leftHand.x = joints[KinectPV2.JointType_HandLeft].getX();
  //    leftHand.y = joints[KinectPV2.JointType_HandLeft].getY();
      
  //    rightHand.x = joints[KinectPV2.JointType_HandRight].getX();
  //    rightHand.y = joints[KinectPV2.JointType_HandRight].getY();
  
  //    leftFoot.x = joints[KinectPV2.JointType_FootLeft].getX();
  //    leftFoot.y = joints[KinectPV2.JointType_FootLeft].getY();
        
  //    rightFoot.x = joints[KinectPV2.JointType_FootRight].getX();
  //    rightFoot.y = joints[KinectPV2.JointType_FootRight].getY();
        
  //    head.x = joints[KinectPV2.JointType_Head].getX();
  //    head.y = joints[KinectPV2.JointType_Head].getY();
  //  }
  //}
}
