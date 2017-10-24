import processing.video.*;

Movie camera;
float videoDuration;
float videoTime = 0;
int videoWidth =  800;
int videoHeight = 600;

void setup() 
{
  size(1024,768);
  frameRate(15);
  background(0);
  
  yvals = new int[width];

  camera = new Movie(this, "camera.mp4");
  camera.play();
  videoDuration = camera.duration();
  
  initEventTable();
}
void draw() 
{
  videoTime = camera.time();
  if(videoTime < videoDuration)
  {
    image(camera, 0, 0, videoWidth, videoHeight);
    displayFramerate();
    displayMachineState();
    displayBarGraph();
    
    println(videoTime,",",videoDuration);
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