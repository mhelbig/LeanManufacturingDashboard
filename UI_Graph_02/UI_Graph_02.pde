import processing.video.*;

// Video playback constants:
int videoWidth =  800;
int videoHeight = 600;
int playbackFrameRate = 5;

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

Movie playback;

void setup() 
{
  size(1024,768);
  frameRate(playbackFrameRate);
  background(0);
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / playbackFrameRate;
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / playbackFrameRate;

  playback = new Movie(this, "camera.mp4");
  playback.play();
  videoDuration = playback.duration();
  playback.stop();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  {
    case 1:
      recordActivity();
      saveEvents();
      break;
    case 2:
      openEventTable();
      runMode++;
    case 3:
      analyseActivity();
      break;
    case 4:
      endProgram();
  }
//  println();

}

void recordActivity()
{
  displayVideoFrame();
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