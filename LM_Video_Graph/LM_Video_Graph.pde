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
float minimalMachineUtilization = 0.4;
float targetMachineUtilization = 0.6;

// runtime variables:
int   runMode = 1;
float sourceVideoSpeedMultiplier;
float videoDuration;
float playbackTime = 0;
boolean machineActive = false;

Movie       playback;
VideoExport videoExport;

Preference programPreferences = new Preference();
VideoProgressBar camera       = new VideoProgressBar();
Graph machineUtilization      = new Graph();
Graph netProfitGraph          = new Graph();

int videoProgressBarHeight        = 20;  // how many pixels tall the progress bar is
int machineUtilizationGraphHeight = 50;

void setup() 
{
  size(1024,768);
  loadPreferences();

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

  int verticalPosition = SourceVideoHeight + uiSpacing;
  camera.drawVideoProgressBarFrame(0, verticalPosition, sourceVideoWidth, videoProgressBarHeight);

  //Machine Utilization / Video playback position Graph setup
  verticalPosition += (uiSpacing + videoProgressBarHeight);
  machineUtilization.setPosition(0, verticalPosition, sourceVideoWidth, machineUtilizationGraphHeight);
  machineUtilization.setRange(1, 0);
  machineUtilization.drawFrame();
  machineUtilization.drawHorizontalGridLine(targetMachineUtilization);
  machineUtilization.drawHorizontalGridLine(minimalMachineUtilization);
  
  // Net Profit Graph setup
  verticalPosition += (uiSpacing + machineUtilizationGraphHeight);
  netProfitGraph.setPosition(0, verticalPosition, sourceVideoWidth, 150);
  netProfitGraph.setRange(100, -100);
  netProfitGraph.drawFrame();
  netProfitGraph.drawHorizontalGridLine(0);
  
  displayKeyboardControls();
  displayCompanyLogo();
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
  camera.displayVideoProgressBar();
  processMachineUtilization();
  processNetProfit();
  videoExport.saveFrame();
//  displayFramerate();
}