// image detection:
boolean setDetectRegion = false;
int detectRegionX = 265;
int detectRegionY = 179;
int detectRegionSizeX = 10;
int detectRegionSizeY = 10;

void setActivityDetectRegion()
{
  detectRegionX = mouseX - detectRegionSizeX;
  detectRegionY = mouseY - detectRegionSizeY;
  println(detectRegionX, detectRegionY);
  if(mousePressed) setDetectRegion = false;
}

void opticallyDetectMachineState()
{
  color opticalRead;
  float opticalBrightness;
  boolean active = false;
  
  stroke(0,255,0);
  strokeWeight(1);
  noFill();
  rect(detectRegionX - (detectRegionSizeX / 2),
       detectRegionY - (detectRegionSizeY / 2),
       detectRegionSizeX,
       detectRegionSizeY);
       
  opticalRead = get(detectRegionX,detectRegionY);
  opticalBrightness = brightness(opticalRead);
  
  active = (opticalBrightness > 175) ? true : false;
  if (machineActive != active)
  {
    machineActive = active;
    addEvent(playbackTime,(machineActive ? 1 : 0));
  }
}