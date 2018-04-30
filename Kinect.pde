import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
//import KinectPV2.*;

Kinect2 kinect2;
//KinectPV2 kinect2;

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
  
  wndWidth = kinect2.depthWidth;
  wndHeight = kinect2.depthHeight;
}
