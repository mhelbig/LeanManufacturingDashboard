//Video progress bar
int videoProgressBarHeight = 15;  // how many pixels tall the progress bar is
int frameWidth             = 2;   // how many pixels wide the frames around the UI elements are
int uiSpacing              = 5;   // how many pixels between UI elements

void drawVideoProgressBarFrame()
{
  pushMatrix();
  translate(0, videoHeight + uiSpacing);
  fill(0);
  stroke(255,255,255);
  strokeWeight(frameWidth);
  rect(0, 0, videoWidth, videoProgressBarHeight);
  popMatrix();
}
  
void displayVideoProgressBar()
{
  pushMatrix();
  translate(0, videoHeight + uiSpacing);
      
  if(machineActive) stroke(0,255,0,100);  //green bar
  else              stroke(255,0,0,100);  //red bar

  strokeWeight(1);
  line(map(playbackTime, 0, videoDuration, frameWidth, videoWidth - frameWidth), 
       frameWidth,
       map(playbackTime, 0, videoDuration, frameWidth, videoWidth - frameWidth),
       videoProgressBarHeight - frameWidth);
       
  popMatrix();     
}

// Profit bargraph
int profitGraphXoffset = 0;
int profitGraphYoffset;
int profitGraphWidth;
int profitGraphHeight = 150;
float profitGraphRangeInDollars = 100;

void drawProfitBarGraphFrame()
{
  pushMatrix();
  translate(profitGraphXoffset, profitGraphYoffset);

  fill(0);
  stroke(255,255,255);
  strokeWeight(frameWidth);
  rect(0, 0, profitGraphWidth, profitGraphHeight);
 
  popMatrix();
}

void displayProfitBarGraph()
{
  pushMatrix();
  translate(profitGraphXoffset, profitGraphYoffset);
       
  if(netProfit > 0 ) stroke(0,255,0,100);  //green bar
  else               stroke(255,0,0,100);  //red bar
  
  strokeWeight(1);
  line(map(playbackTime, 0, videoDuration,0, videoWidth), 
       constrain(map(netProfit,profitGraphRangeInDollars,-profitGraphRangeInDollars,0,profitGraphHeight), 0, profitGraphHeight),
       map(playbackTime, 0, videoDuration,0, videoWidth),
       profitGraphHeight/2);

  // Draw the center reference line
  stroke(255);
  line(0, profitGraphHeight/2, profitGraphWidth, profitGraphHeight/2);
  
  translate(profitGraphWidth + uiSpacing, profitGraphHeight/2);  // move over to the right edge of the graph across from the center line
  fill(255);
  rectMode(CENTER);
  rect(0,0,70,20);
  rectMode(CORNER);
  fill(0);
  textAlign(CENTER, CENTER);
  text("$", 0, 0);
  text( round(netProfit*100) / 100.0, 5, 0);

  popMatrix();
}

// Profit Indicator
void displayProfit()
{
    fill(255);
    rect(10,40,70,20,10);
    fill(0);
    textAlign(RIGHT);
    text("$", 25, 55);
    text( round(netProfit*100) / 100.0, 75, 55);
}

// Machine State Indicator
int machineStateIndicatorX;
int machineStateIndicatorY;
int machineStateIndicatorR = 30;
void displayActivityState()
{
  stroke(0);
  if(machineActive) fill(0,255,0,100);
  else              fill(255,0,0,100);
  ellipse(machineStateIndicatorX,
          machineStateIndicatorY,
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
 int textXposition = videoWidth + 20;
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
  image(logo, videoWidth + 20, 20);
}