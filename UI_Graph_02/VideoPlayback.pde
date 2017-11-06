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
  image(playback, uiSpacing, uiSpacing, videoWidth, videoHeight);
//  print(playbackTime,",",videoDuration,",");

}
  
void restartVideo()
{
  startFlag = false;
  playback.stop();
  videoExport.endMovie();
  videoExport.startMovie();
  netProfit = 0;
  events.clearRows();
}
  
void movieEvent(Movie video)
{
  video.read();
}