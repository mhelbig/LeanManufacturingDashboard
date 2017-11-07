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

class TextBox
{
  int Xoffset    = 0;
  int Yoffset    = 0;
  int barWidth   = 100;
  int barHeight  = 50;
  
  TextBox()
  {
  }
  
  void setPosition(int x, int y, int w, int h)
  {
    Xoffset = x;
    Yoffset = y;
    barWidth   = w;
    barHeight  = h;
  }
  
  void drawText(String text) 
  {  
    pushMatrix();
    translate(Xoffset, Yoffset);
    fill(0);
    stroke(255,255,255);
    rect(0,0,barWidth,barHeight);

    translate(barWidth / 2, barHeight / 2);
    fill(255,0,0);
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