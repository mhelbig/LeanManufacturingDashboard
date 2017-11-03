// image detection:
boolean setDetectRegion = false;
int detectRegionX = 265;           //These are hardcoded for now
int detectRegionY = 179;
int detectMarkerSizeX = 10;
int detectMarkerSizeY = 10;
float opticalBrightnessThreshold = 175;  // range = 0 - 255

void setActivityDetectRegion()
{
  detectRegionX = mouseX - detectMarkerSizeX;
  detectRegionY = mouseY - detectMarkerSizeY;
  println(detectRegionX, detectRegionY);
  if(mousePressed) setDetectRegion = false;
}

void opticallyDetectMachineState()
{
  color opticalRead;
  float opticalBrightness;
  boolean active = false;
  
//Draw the optical detection marker  
  stroke(0,255,0);
  strokeWeight(1);
  noFill();
  line(detectRegionX -1, detectRegionY,     detectRegionX - detectMarkerSizeX, detectRegionY);
  line(detectRegionX +1, detectRegionY,     detectRegionX + detectMarkerSizeX, detectRegionY);
  line(detectRegionX,    detectRegionY - 1, detectRegionX,                     detectRegionY - detectMarkerSizeY);
  line(detectRegionX,    detectRegionY + 1, detectRegionX,                     detectRegionY + detectMarkerSizeY);
  ellipse(detectRegionX, detectRegionY, detectMarkerSizeX * 2, detectMarkerSizeY * 2);

//Optically detect the machine state       
  opticalRead = get(detectRegionX,detectRegionY);
  opticalBrightness = brightness(opticalRead);
  
  active = (opticalBrightness > opticalBrightnessThreshold) ? true : false;
  if (machineActive != active)
  {
    machineActive = active;
    addEvent(playbackTime,(machineActive ? 1 : 0));
  }
}