// Global UI parameters: 
int frameWidth             = 2;   // how many pixels wide the frames around the UI elements are
int uiSpacing              = 5;   // how many pixels between UI elements

void processNetProfit()
{
  calculateNetProfit();
  if(netProfit > 0 ) netProfitGraph.setBarColor(color(0,255,0,100));  //green
  else               netProfitGraph.setBarColor(color(255,0,0,100));  //red
  netProfitGraph.drawBar(0,netProfit);
}

void processMachineUtilization()
{
  calculateRollingMachineUtilization();
  
  if(rollingMachineUtilizationPercentage > targetMachineUtilization )
  {
    machineUtilization.setBarColor(color(0,255,0,100));    //green
  }
  else if(rollingMachineUtilizationPercentage > minimalMachineUtilization )
  {
     machineUtilization.setBarColor(color(255,255,0,100));  //yellow
  } 
  else
  {
    machineUtilization.setBarColor(color(255,0,0,100));    //red
  }
  
  machineUtilization.drawBar(0,rollingMachineUtilizationPercentage);
  displayMachineUtilizationPercentage();
}

class VideoProgressBar
{
  int Xoffset = 0;  //defaults
  int Yoffset = 0;
  int barWidth   = 500;
  int barHeight  = 150;

  VideoProgressBar()
  {
  }
  
  void drawVideoProgressBarFrame(int x, int y, int w, int h)
  {
    Xoffset = x;
    Yoffset = y;
    barWidth   = w;
    barHeight  = h;
    
    pushMatrix();
    translate(Xoffset, Yoffset);
    fill(0);
    stroke(255,255,255);
    strokeWeight(frameWidth);
    rect(0, 0, barWidth, barHeight);
    popMatrix();
  }
    
  void displayVideoProgressBar()
  {
    pushMatrix();
    translate(Xoffset, Yoffset);
        
    if(machineActive) stroke(0,255,0,100);  //green bar
    else              stroke(255,0,0,100);  //red bar
  
    strokeWeight(1);
    line(map(playbackTime, 0, videoDuration, frameWidth, barWidth - frameWidth), 
         frameWidth,
         map(playbackTime, 0, videoDuration, frameWidth, barWidth - frameWidth),
         barHeight - frameWidth);
    popMatrix();     
  }
}


// Machine Utilization Percentage
int MachineUtilizationReadoutWidth = 70;
void displayMachineUtilizationPercentage()
{
  pushMatrix();
  translate(800, 500);  // move over ?????
  fill(0);
  stroke(255,255,255);
  rectMode(CENTER);
  rect(0,0,MachineUtilizationReadoutWidth,20);
  rectMode(CORNER);
  
  fill(255,0,0);  // red bar
  textAlign(CENTER, CENTER);
  text(nf((rollingMachineUtilizationPercentage * 100), 2, 1) + "%", 0, 0);

  popMatrix();
}

// Machine State Indicator
int machineStateIndicatorXoffset = 0;
int machineStateIndicatorYoffset = 0;
int machineStateIndicatorR       = 30;
void displayActivityState()
{
  stroke(0);
  if(machineActive) fill(0,255,0,100);
  else              fill(255,0,0,100);
  ellipse(detectRegionX + machineStateIndicatorXoffset,
          detectRegionY + machineStateIndicatorYoffset,
          machineStateIndicatorR,
          machineStateIndicatorR);
}

// Video framerate indicator
void displayFramerate()
{
    fill(255);
    rect(10,10,25,20,10);
    fill(0);
    textAlign(CENTER);
    text(round(frameRate),23,25);
}

// Keyboard control reference
void displayKeyboardControls()
{
 int textXposition = sourceVideoWidth + 20;
 int textYposition = 140;
 int textSpacing   = 15;
 
 text("Keyboard controls:",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("R = Restart Video from beginning",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("M = Manually set Machine Active/Inactive",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("S = Set machine active sensor position",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("Q = Quit",textXposition, textYposition);
 textYposition += textSpacing;
}

// Company logo
PImage logo;
void displayCompanyLogo()
{
  logo = loadImage("leanlogo.png");
  image(logo, sourceVideoWidth + uiSpacing, 0);
}