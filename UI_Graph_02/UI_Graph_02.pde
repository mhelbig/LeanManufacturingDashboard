import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int videoWidth =  720;
int videoHeight = 480;
int analyseFrameRate = 30;
int outputFrameRate  = 30;

// Business operating constants:
float overheadRatePerHour = 125;
float revenueRatePerHour  = 375;

// runtime variables:
int   runMode = 2;
float overheadRatePerFrame;
float revenueRatePerFrame;
float videoDuration;
float playbackTime = 0;
float netProfit = 0;
boolean machineActive = false;

Movie       playback;
VideoExport videoExport;

void setup() 
{
  size(1024,768);
  frameRate(analyseFrameRate);
  background(0);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyseFrameRate;
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyseFrameRate;

  playback = new Movie(this, "camera.mpg");
  playback.play();
  videoDuration = playback.duration();
  playback.stop();
  
  videoExport = new VideoExport(this,"data/output.mp4");
  videoExport.setFrameRate(outputFrameRate);
  
  displayKeyboardControls();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  {
    case 1:
      setupRecordingParameters();  // Future
      videoExport.startMovie();
      break;
    case 2:                        // first pass: analyse video for activity
      analyzeVideo();
      if(setDetectRegion) setActivityDetectRegion();
      break;
    case 3:                        // Save analysis data & prepare to generate output video
      addEvent(videoDuration,0);
      closeEventTable();
      openEventTable();
      runMode=5;
    case 5:                        // gracefully end the program
      videoExport.endMovie();
      endProgram();
  }
}

void setupRecordingParameters()
{
  runMode++;
}

void analyzeVideo()
{
  displayVideoFrame();
  opticallyDetectMachineState();
  displayActivityState();
  calculateNetProfit();
  displayProfit();
  displayBarGraph();
  videoExport.saveFrame();
}

void generateOutputVideo()
{
  displayVideoFrame();
  readMachineActiveStateTable();
  displayActivityState();
}

void endProgram()
{
  exit();
}

void calculateNetProfit()
{
  if(machineActive)
  {
    netProfit += revenueRatePerFrame;
  }
  netProfit -= overheadRatePerFrame;
}