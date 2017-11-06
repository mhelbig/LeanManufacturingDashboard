import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int videoWidth;
int videoHeight;
int analyseFrameRate;
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

void setup() 
{
  size(1024,768);
  loadPreferences();
  profitGraphYoffset = videoHeight + uiSpacing + videoProgressBarHeight + uiSpacing;
  profitGraphWidth = videoWidth;
  
  frameRate(analyseFrameRate);
  background(0,0,75);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyseFrameRate * sourceVideoSpeedMultiplier; //<>//
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyseFrameRate * sourceVideoSpeedMultiplier;

  playback = new Movie(this, "camera.mpg");
  playback.play();
  videoDuration = playback.duration();
  playback.stop();                      // we need to do this to get a valid duration
  
  videoExport = new VideoExport(this,"data/output.mp4");
  videoExport.setFrameRate(outputFrameRate);
  
  translate(uiSpacing,uiSpacing);
  displayKeyboardControls();
  displayCompanyLogo();
  drawVideoProgressBarFrame();
  drawProfitBarGraphFrame();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  { //<>//
    case 1:
      videoExport.startMovie();
      runMode++;
      break;
    case 2:                        // Analyse video for activity
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
  displayVideoProgressBar();
  displayFramerate();
  calculateNetProfit();
  displayProfitBarGraph();
  videoExport.saveFrame();
}