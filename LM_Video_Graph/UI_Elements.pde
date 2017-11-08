void drawBaseUIElements()
{
  int verticalPositionTracking = uiSpacing + SourceVideoHeight + (frameWidth * 2);

  background(0,0,75);
  translate(uiSpacing,uiSpacing);
  fill(0,0,0);
  stroke(255,255,255);
  strokeWeight(frameWidth);

  rect(0-frameWidth, 0-frameWidth, sourceVideoWidth + (frameWidth * 2), SourceVideoHeight + (frameWidth * 2));
  
// Progress Bar Setup  
  camera.drawVideoProgressBarFrame(0, verticalPositionTracking, sourceVideoWidth, videoProgressBarHeight);

//Machine Utilization Graph setup
  verticalPositionTracking += (uiSpacing + videoProgressBarHeight + (frameWidth * 2));
  machineUtilizationGraph.setPosition(0, verticalPositionTracking, sourceVideoWidth, machineUtilizationGraphHeight);
  machineUtilizationGraph.setRange(1, 0);
  machineUtilizationGraph.drawFrame();
  machineUtilizationGraph.drawHorizontalGridLine(targetMachineUtilization);
  machineUtilizationGraph.drawHorizontalGridLine(minimalMachineUtilization);
  machineUtilizationText.setPosition(sourceVideoWidth + uiSpacing + (frameWidth * 2), verticalPositionTracking, 100, machineUtilizationGraphHeight);
  machineUtilizationText.setTextSize(20);
  
// Net Profit Graph setup
  verticalPositionTracking += (uiSpacing + machineUtilizationGraphHeight + (frameWidth * 2));
  netProfitGraph.setPosition(0, verticalPositionTracking, sourceVideoWidth, 150);
  netProfitGraph.setRange(100, -100);
  netProfitGraph.drawFrame();
  netProfitGraph.drawHorizontalGridLine(0);
  netProfitText.setPosition(sourceVideoWidth + uiSpacing + (frameWidth * 2), verticalPositionTracking, 100, 150);
  netProfitText.setTextSize(20);

  displayKeyboardControls();
  displayCompanyLogo();
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
    rect(0-frameWidth, 0-frameWidth, barWidth + (frameWidth *2), barHeight + (frameWidth * 2) );
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

class TextBox
{
  int Xoffset    = 0;
  int Yoffset    = 0;
  int boxWidth   = 100;
  int boxHeight  = 50;
  color textColor = color(255,255,255);
  float textHeight = 20;
  
  TextBox()
  {
  }
  
  void setPosition(int x, int y, int w, int h)
  {
    Xoffset = x;
    Yoffset = y;
    boxWidth   = w;
    boxHeight  = h;
  }
  
  void setTextColor(color c)
  {
    textColor = c;
  }
    
  void setTextSize(float s)
  {
    textHeight = s;
  }
    
  void drawText(String text) 
  {  
    pushMatrix();
    translate(Xoffset, Yoffset);
    fill(0);
    stroke(255,255,255);
    rect(0-frameWidth, 0-frameWidth, boxWidth + (frameWidth *2), boxHeight + (frameWidth * 2));

    translate(boxWidth / 2, boxHeight / 2);
    fill(textColor);
    textSize(textHeight);
    textAlign(CENTER, CENTER);
    text(text, 0, 0);
    popMatrix();
  }
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
 
 fill(255,255,255);
 
 text("Keyboard controls:",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("L = Load Video file to process",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("S = Stop processing video",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("M = Set machine active sensor position",textXposition, textYposition);
 textYposition += textSpacing;
 
 text("E = Exit program",textXposition, textYposition);
 textYposition += textSpacing;
}

// Company logo
PImage logo;
void displayCompanyLogo()
{
  logo = loadImage("logo.png");
  image(logo, sourceVideoWidth + uiSpacing + frameWidth, 0);
}