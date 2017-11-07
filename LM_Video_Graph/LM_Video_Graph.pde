import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int sourceVideoWidth;
int SourceVideoHeight;
int analyzeFrameRate;
int outputFrameRate;

// Business operating constants:
float overheadRatePerHour;
float revenueRatePerHour;

// runtime variables:
int   runMode = 1;
float sourceVideoSpeedMultiplier;
float videoDuration;
float playbackTime = 0;
boolean machineActive = false;

Movie       playback;
VideoExport videoExport;

Preference programPreferences = new Preference();
int videoProgressBarHeight = 40;  // how many pixels tall the progress bar is
Graph machineUtilization      = new Graph();

Graph netProfitGraph          = new Graph();

void setup() 
{
  size(1024,768);
  loadPreferences();
  
  //Machine Utilization / Video playback position Graph setup
  machineUtilization.setPosition(0, (SourceVideoHeight + uiSpacing), sourceVideoWidth, videoProgressBarHeight);
  machineUtilization.setRange(1, 0);
  
  // Net Profit Graph setup
  netProfitGraph.setPosition(0, (SourceVideoHeight + uiSpacing + videoProgressBarHeight + uiSpacing ), sourceVideoWidth, 150);
  netProfitGraph.setRange(100, -100);
  
  
  frameRate(analyzeFrameRate);
  background(0,0,75);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyzeFrameRate * sourceVideoSpeedMultiplier; //<>//
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyzeFrameRate * sourceVideoSpeedMultiplier;

  playback = new Movie(this, "camera.mpg");
  playback.play();
  videoDuration = playback.duration();
  playback.stop();                      // we need to do this to get a valid duration
  
  videoExport = new VideoExport(this,"data/output.mp4");
  videoExport.setFrameRate(outputFrameRate);
  
  translate(uiSpacing,uiSpacing);
  displayKeyboardControls();
  displayCompanyLogo();
//  drawVideoProgressBarFrame();
  machineUtilization.drawFrame();
  netProfitGraph.drawFrame();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  { //<>//
    case 1:
      videoExport.startMovie();
      runMode++;
      break;
    case 2:                        // Analyze video for activity
      analyzeVideo();
      break;
    case 3:                        // Save analysis data
      addEvent(videoDuration,0);
      runMode=100;
      break;
    case 100:                      // gracefully end the program
      closeEventTable();
      saveSystemParameters();
      videoExport.endMovie();
      exit();
  }
}

void analyzeVideo()
{
  displayVideoFrame();
  opticallyDetectMachineState();
  displayActivityState();
  if(setDetectRegion) setActivityDetectRegion();

  translate(uiSpacing,uiSpacing);
//  displayVideoProgressBar();
  machineUtilization.drawBar(0,machineUtilizationPercentage);

  calculateMachineUtilizationPercentage();
  displayMachineUtilizationPercentage();
  calculateNetProfit();
  if(netProfit > 0 ) netProfitGraph.setBarColor(color(0,255,0,100));  //green
  else               netProfitGraph.setBarColor(color(255,0,0,100));  //red

  netProfitGraph.drawBar(0,netProfit);
  videoExport.saveFrame();
//  displayFramerate();
}