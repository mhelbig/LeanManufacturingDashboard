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
  
int progressBarOffset = 10;  // how many pixels the progress bar is from the edges
int progressBarHeight = 30;  // how many pixels tall the progress bar is
int progressBarStroke = 4;   // how thick the progress bar border is in pixels
  
void displayProgressBar()
{
  noFill();
  stroke(255,255,255,150);
  strokeWeight(progressBarStroke);
  rect(progressBarOffset, 
       videoHeight - progressBarOffset - progressBarHeight,
       videoWidth-(2*progressBarOffset),
       progressBarHeight,
       progressBarHeight/2);
  fill(0,0,255,100);
//  noStroke();
  rect(progressBarOffset + progressBarStroke/2, 
       videoHeight - progressBarOffset - progressBarHeight + progressBarStroke/2,
       map(playbackTime, 0, videoDuration,0, (float)(videoWidth-(2*progressBarOffset)-progressBarStroke)),
       progressBarHeight-progressBarStroke,
       progressBarHeight/2);
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