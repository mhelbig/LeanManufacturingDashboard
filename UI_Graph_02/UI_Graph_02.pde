import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int videoWidth =  720;
int videoHeight = 480;
int analyseFrameRate = 30;
int outputFrameRate  = 30;

// Business operating constants:
float overheadRatePerHour;
float revenueRatePerHour;

// runtime variables:
int   runMode = 1;
float overheadRatePerFrame;
float revenueRatePerFrame;
float videoDuration;
float playbackTime = 0;
boolean machineActive = false;

Movie       playback;
VideoExport videoExport;

Preference programPreferences = new Preference();

void setup() 
{
  programPreferences.loadPref();

  size(1024,768);
  frameRate(analyseFrameRate);
  background(0);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyseFrameRate;
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyseFrameRate;

  playback = new Movie(this, "camera.mpg");
  playback.play();
  videoDuration = playback.duration();
  playback.stop();                      // we need to do this to get a valid duration
  
  videoExport = new VideoExport(this,"data/output.mp4");
  videoExport.setFrameRate(outputFrameRate);
  
  displayKeyboardControls();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  { //<>//
    case 1:
      loadSystemParameters();      // Read settings from file (future)
      videoExport.startMovie();
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
  calculateNetProfit();
  if(setDetectRegion) setActivityDetectRegion();
  displayBarGraph();
  displayProfit();
  videoExport.saveFrame();
}