void keyPressed()
{
  if( (key == 'l' || key == 'L') && runMode == 0)
  {
    runMode++;
  }
  
  if(key == 's' || key == 'S')  // Stop video
  {
    runMode = 4;
  }

  if(key == 'm' || key == 'M')  // Toggle mode for setting image detection region position with mouse
  {
    setDetectRegion = true;
  }
 

  if (key == 'e' || key == 'E') // Exit program
  {
  runMode = 100;
  }
}

/*
  if(key == 'm' || key == 'M')  // Manually set machine active/inactive state
  {
    machineActive = !machineActive;
    addEvent(playbackTime,(machineActive ? 1 : 0));
    println("Recording is " + (machineActive ? "ON" : "OFF"));
  }
*/