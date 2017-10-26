boolean startFlag = false;

void displayVideoFrame()
{
  if (startFlag == false)
  {
    playback.play();
    startFlag = true;
  }
  playbackTime = playback.time();
  image(playback, 0, 0, videoWidth, videoHeight);
  displayFramerate();
  print(playbackTime,",",videoDuration,",");

  if(playbackTime >= videoDuration)
  {
    runMode++;
    playback.stop();
    startFlag = false;
  }
}
  
void movieEvent(Movie video)
{
  video.read();
}