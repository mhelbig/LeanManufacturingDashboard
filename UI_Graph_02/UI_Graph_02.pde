import processing.video.*;

// Business operating constants:
float overheadRatePerHour = 125;
float revenueRatePerHour  = 375;

// Video playback constants:
int videoWidth =  800;
int videoHeight = 600;
int playbackFrameRate = 15;

// runtime variables:
char  runMode = 'R';
float overheadRatePerFrame;
float revenueRatePerFrame;
float videoDuration;
float playbackTime = 0;
float netProfit = 0;
boolean  startFlag = false;

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
  switch(runMode)
  {
    case 'R':
      recordActivity();
      break;
    case 'A':
      analyseActivity();
      break;
    case 'E':
      endProgram();
  }
}


// Started moving things around to create a record and analyse mode.  It's broken. 


void recordActivity()
{

  playbackTime = playback.time();
  calculateNetProfit();

  image(playback, 0, 0, videoWidth, videoHeight);
  displayFramerate();
  displayProfit();
  displayActivityState();
  
  print(playbackTime,",",videoDuration,",");
  println();
  
  if(playbackTime >= videoDuration)
  {
    runMode = 'E';
    playback.stop();
    startFlag = false;
    saveEvents();
  }

}

void analyseActivity()
{
  if (startFlag == false)
  {
    playback.play();
    startFlag = true;
  }
  image(playback, 0, 0, videoWidth, videoHeight);
  displayFramerate();
  displayProfit();
  displayActivityState();

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

void movieEvent(Movie video)
{
  video.read();
}