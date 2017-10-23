import processing.video.*;

Movie video;
float videoFrameRate = 30;
float videoDuration;
float videoSpeed = 10;  //playback speed multiplier
float videoStep;
float videoPosition = 0;

void setup() 
{
  size(1024, 768);
  //frameRate(videoFrameRate);
  background(0);
  
  yvals = new int[width];

  video = new Movie(this, "camera.mp4");
  video.play();
  videoDuration = video.duration();
  videoStep = videoSpeed/videoFrameRate;
  
  graphWidth=width;
  
  initEventTable();
}
void draw() 
{
  
  // This just runs really slow.  Need to figure out how to speed it up, or maybe
  // we'll just have to speed the video up in a video editor and process it here in
  // real time.
  
  if(videoPosition <= videoDuration)
  {
    image(video, 0, 0, 800, 600);
    
    videoPosition += videoStep;
    video.jump(videoPosition);
   
    displayBarGraph();
    println(frameRate);
  }
  else  // The movie is done
  {
    video.stop();
    rect(0,0,800,600);
//    exit();
  }
}

void movieEvent(Movie video)
{
  video.read();
}