import processing.video.*;

Movie video;
float videoDuration;
float videoTime = 0;

void setup() 
{
  size(1024,768);
  //frameRate(videoFrameRate);
  background(0);
  
  yvals = new int[width];

  video = new Movie(this, "camera.mp4");
  video.play();
  videoDuration = video.duration();
  
  graphWidth=width;
  
  initEventTable();
}
void draw() 
{
  videoTime = video.time();
  if(videoTime < videoDuration)
  {
    image(video, 0, 0, 800, 600);
    
    displayBarGraph();
//    println(frameRate,",",videoTime,",",videoDuration);
  }
  else  // The video is done
  {
    video.stop();
    rect(0,0,800,600);
    saveEvents();
    exit();
  }
}

void movieEvent(Movie video)
{
  video.read();
}