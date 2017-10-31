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

// image detection:
boolean setDetectRegion = false;
int detectRegionX = videoWidth/2;
int detectRegionY = videoHeight/2;

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
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  {
    case 1:
      setupRecordingParameters();  // Future
      break;
    case 2:
      recordActivity();
      break;
    case 3:
      addEvent(videoDuration,0);                //add one more record to the table
      saveEvents();
      openEventTable();
      videoExport.startMovie();
      runMode++;
    case 4:
      analyseActivity();
      videoExport.saveFrame();
      break;
    case 5:
      videoExport.endMovie();
      endProgram();
  }
//  println();

}

void setupRecordingParameters()
{
  runMode++;
}

void recordActivity()
{
  displayVideoFrame();
  displayActivityState();
}

void analyseActivity()
{
  displayVideoFrame();
  readMachineActiveStateTable();
  displayActivityState();
  calculateNetProfit();
  displayProfit();
  displayBarGraph();
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