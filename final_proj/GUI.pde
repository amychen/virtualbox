import controlP5.*;

ControlP5 cp5;
Slider pointSpace;
Slider rainAmount;
Range thresholdRange;

int tMin, tMax, pointSpaces, rainAmt;
void initGUI(){
  cp5 = new ControlP5(this);
  thresholdRange = cp5.addRange("threshold")
                      .setPosition(10, 50)
                      .setSize(300, 50)
                      .setHandleSize(5)
                      .setRange(1, 4499)
                      .setRangeValues(2000,2500);
  rainAmount = cp5.addSlider("rainAmt")
              .setPosition(10, 100)
              .setSize(300, 50)
              .setRange(80, 500)
              .setValue(100);
  pointSpace = cp5.addSlider("pointSpaces")
                  .setSize(300, 50)
                  .setPosition(10, 150)
                  .setValue(5)
                  .setRange(2,10);
}
