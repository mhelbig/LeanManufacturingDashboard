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
  image(playback, uiSpacing, uiSpacing, sourceVideoWidth, SourceVideoHeight);
//  print(playbackTime,",",videoDuration,",");

}
  
void stopVideo()
{
  startFlag = false;
  playback.stop();
}
  
void movieEvent(Movie video)
{
  video.read();
}