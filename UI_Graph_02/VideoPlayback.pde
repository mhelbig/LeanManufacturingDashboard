boolean startFlag = false;

void displayVideoFrame()
{
  if (startFlag == false)
  {
    playback.play();
    startFlag = true;
  }
  if(playbackTime >= videoDuration)
  {
    runMode++;
    playback.stop();
    startFlag = false;
  }

  playbackTime = playback.time();
  image(playback, 0, 0, videoWidth, videoHeight);
  displayProgressBar();
  displayFramerate();
//  print(playbackTime,",",videoDuration,",");

}
  
int progressBarHeight = 30;  // how many pixels tall the progress bar is
  
void displayProgressBar()
{
  noFill();
  stroke(255,255,255,150);
  rect(0, 
       videoHeight,
       videoWidth,
       progressBarHeight);
       
  if(machineActive) fill(0,255,0,100);
  else              fill(255,0,0,100);
  
  line(map(playbackTime, 0, videoDuration,0, videoWidth), 
       videoHeight,
       map(playbackTime, 0, videoDuration,0, videoWidth),
       videoHeight + progressBarHeight);
}

void restartVideo()
{
  startFlag = false;
  playback.stop();
  videoExport.endMovie();
  videoExport.startMovie();
  netProfit = 0;
  for(int i = 1; i < graphWidth; i++) 
  { 
    barGraphArray[i-1] = 0;
  } 
  events.clearRows();
}
  
void movieEvent(Movie video)
{
  video.read();
}