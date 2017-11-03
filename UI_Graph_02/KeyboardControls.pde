void keyPressed()
{
  if(key == 'm' || key == 'M')  // Manually set machine active/inactive state
  {
    machineActive = !machineActive;
    addEvent(playbackTime,(machineActive ? 1 : 0));
    println("Recording is " + (machineActive ? "ON" : "OFF"));
  }
  
  if(key == 's' || key == 'S')  // Toggle mode for setting image detection region position with mouse
  {
    setDetectRegion = true;
  }
 
  if(key == 'r' || key == 'R')  // Restart the video playback from the beginning
  {
    restartVideo();
  }
  
  if (key == 'q' || key == 'Q') // Quit
  {
  runMode = 100;
  }
}