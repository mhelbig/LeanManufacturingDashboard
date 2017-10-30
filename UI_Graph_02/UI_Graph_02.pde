import gab.opencv.*;
import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int videoWidth =  800;
int videoHeight = 600;
int analyseFrameRate = 30;
int outputFrameRate  = 30;

// Image recognition
int roiWidth = 50;
int roiHeight = 50;

// Business operating constants:
float overheadRatePerHour = 125;
float revenueRatePerHour  = 375;

// runtime variables:
int   runMode = 1;
float overheadRatePerFrame;
float revenueRatePerFrame;
float videoDuration;
float playbackTime = 0;
float netProfit = 0;
boolean machineActive = false;

Movie       playback;
VideoExport videoExport;
PImage      imageRecognition;
OpenCV      opencv;

void setup() 
{
  size(1024,768);
  frameRate(analyseFrameRate);
  background(0);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyseFrameRate;
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyseFrameRate;

  playback = new Movie(this, "camera.mp4");
  imageRecognition = playback;
  playback.play();
  videoDuration = playback.duration();
  playback.stop();
  
  opencv = new OpenCV(this, playback);
  
  videoExport = new VideoExport(this,"data/output.mp4");
  videoExport.setFrameRate(outputFrameRate);
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  {
    case 1:
      recordActivity();
      break;
    case 2:
      addEvent(videoDuration,0);                //add one more record
      saveEvents();
      openEventTable();
      videoExport.startMovie();
      runMode++;
    case 3:
      analyseActivity();
      videoExport.saveFrame();
      break;
    case 4:
      videoExport.endMovie();
      endProgram();
  }
//  println();

}

void recordActivity()
{
  displayVideoFrame();
  detectMachineActiveState();
  displayActivityState();
}

void analyseActivity()
{
  displayVideoFrame();
  getMachineActiveState();
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