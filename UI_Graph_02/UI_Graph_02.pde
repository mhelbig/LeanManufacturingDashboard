import processing.video.*;

// Business operating parameters:
float overheadRatePerHour = 125;
float revenueRatePerHour  = 375;
float graphRangeInDollars = 1;

Movie camera;
float videoDuration;
float videoTime = 0;
int videoWidth =  800;
int videoHeight = 600;
int playbackFrameRate = 15;

// calculated constants:
float overheadRatePerFrame;
float revenueRatePerFrame;

void setup() 
{
  size(1024,768);
  frameRate(playbackFrameRate);
  background(0);
  
  camera = new Movie(this, "camera.mp4");
  camera.play();
  videoDuration = camera.duration();
  
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / playbackFrameRate;
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / playbackFrameRate;
}
void draw() 
{
  videoTime = camera.time();
  if(videoTime < videoDuration)
  {
    image(camera, 0, 0, videoWidth, videoHeight);
    displayFramerate();
    displayProfit();
    displayMachineState();
    displayBarGraph();
    
    if(machineActive)
    {
      netProfit += revenueRatePerFrame;
    }
    netProfit -= overheadRatePerFrame;
    
    print(videoTime,",",videoDuration,",");
    println();
  }
  else  // The video is done
  {
    camera.stop();
    saveEvents();
    exit();
  }
}

void movieEvent(Movie video)
{
  video.read();
}