import processing.video.*;

int[] yvals;
int Overhead = 25;
int Profit   = 50;

int arrayindex = 0;
int graphWidth;
int graphHeight = 100;
int graphXoffset = 0;
int graphYoffset = 600;
  
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
    while(!video.available());  // Wait until the video frame is available
    video.read();
    image(video, 0, 0, 800, 600);
    
    videoPosition += videoStep;
    video.jump(videoPosition);
   
    displayBarGraph();
  }
  else  // The movie is done
  {
    video.stop();
    rect(0,0,800,600);
  }
}

void displayBarGraph()
{
  for(int i = 1; i < graphWidth; i++) 
  { 
    yvals[i-1] = yvals[i];
  } 
  
  // Add the new values to the end of the array 
  yvals[graphWidth-1] -= Overhead;  // the costs are always applied
  if(mousePressed)
  {
    yvals[graphWidth-1] += Profit;  // profit is applied when the machines are running
  }
     
  fill(0,0,0);
  noStroke();

  rect(graphXoffset, graphYoffset, graphWidth, graphHeight);

  // Draw the scrolling bar graph
  for(int i=1; i<graphWidth; i++) 
  {
    if(yvals[i] > 0)
    {
      stroke(0,255,0);
      line(graphXoffset+i,
           graphYoffset+((graphHeight*.5)-yvals[i]/1000),
           graphXoffset+i,
           graphYoffset+(graphHeight/2));
    }
    else
    {
      stroke(255,0,0);
      line(graphXoffset+i,
           graphYoffset+((graphHeight*.5)-yvals[i]/1000),
           graphXoffset+i,
           graphYoffset+(graphHeight/2));
    }
  }
  // Draw the center reference line
  stroke(255);
  line(graphXoffset, 
       graphYoffset+(graphHeight/2),
       graphXoffset+graphWidth,
       graphYoffset+(graphHeight/2));
}