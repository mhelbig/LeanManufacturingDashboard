import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int sourceVideoWidth;
int SourceVideoHeight;
int analyzeFrameRate;
int outputFrameRate;

// Business operating constants:
float overheadRatePerHour;
float revenueRatePerHour;
float minimalMachineUtilization = 0.4;
float targetMachineUtilization = 0.6;

// runtime variables:
int   runMode = 0;
float sourceVideoSpeedMultiplier;
float videoDuration;
float playbackTime = 0;
boolean machineActive = false;
String sourceVideoPathNameWithExtension = "unselected";
String[] sourceVideoPathNameSplit;

Movie       playback;
VideoExport videoExport;

Preference programPreferences   = new Preference();
VideoProgressBar camera         = new VideoProgressBar();
Graph machineUtilizationGraph   = new Graph();
TextBox machineUtilizationText  = new TextBox();
Graph netProfitGraph            = new Graph();
TextBox netProfitText           = new TextBox();

// Global UI parameters: 
int frameWidth                    = 2;   // how many pixels wide the frames around the UI elements are
int uiSpacing                     = 5;   // how many pixels between UI elements
int videoProgressBarHeight        = 20;  // how many pixels tall the progress bar is
int machineUtilizationGraphHeight = 50;

void setup() 
{
  
  size(1024,768);
  loadPreferences();

  frameRate(analyzeFrameRate);
  background(0,0,75);
    
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / analyzeFrameRate * sourceVideoSpeedMultiplier; //<>//
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / analyzeFrameRate * sourceVideoSpeedMultiplier;
  
  drawBaseUIElements();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  { //<>//
    case 0:                        // waiting for "Load video"
      break;
    case 1:
      loadVideoFileToProcess();
      break;
    case 2:
      createVideoFileForOutput();
      videoExport.startMovie();
      break;
    case 3:                        // Analyze video, generate graphs & .csv data file
      analyzeVideo();
      break;
    case 4:                        // Save analysis data
      addEvent(videoDuration,0);
      videoExport.endMovie();
      runMode=0;
      break;
    case 100:                      // gracefully end the program
      closeEventTable();
      saveSystemParameters();
      exit();
  }
}

void loadVideoFileToProcess()
{
  selectInput("Select a source video file:", "sourceFileSelected");

  while ( sourceVideoPathNameWithExtension == "unselected")
  {
    print("");  //It seems as though we need to have something in the while for it to do or it hangs here forever. This does the trick for whatever reason.
  }
  
  if(sourceVideoPathNameWithExtension == null)
  {
    println("No file Selected");
    runMode = 100;
  }
  else
  {
    playback = new Movie(this, sourceVideoPathNameWithExtension);
    playback.play();
    videoDuration = playback.duration();
    playback.stop();                      // we need to do this to get a valid duration
    runMode++;
  }
}

void createVideoFileForOutput()
{
  sourceVideoPathNameSplit = split(sourceVideoPathNameWithExtension, ".");
  println(sourceVideoPathNameSplit[0]);
  videoExport = new VideoExport(this,sourceVideoPathNameSplit[0] + "-Processed.mp4");
  videoExport.setFrameRate(outputFrameRate);
  runMode++;
}

void analyzeVideo()
{
  displayVideoFrame();
  opticallyDetectMachineState();
  displayActivityState();
  if(setDetectRegion) setActivityDetectRegion();

  translate(uiSpacing,uiSpacing);
  camera.displayVideoProgressBar();
  processMachineUtilization();
  processNetProfit();
  videoExport.saveFrame();
//  displayFramerate();
}

void processNetProfit()
{
  calculateNetProfit();
  if(netProfit > 0 )
  {
    netProfitGraph.setBarColor(color(0,255,0));  //green
    netProfitText.setTextColor(color(0,255,0));
  }
  else
  {
    netProfitGraph.setBarColor(color(255,0,0));  //red
    netProfitText.setTextColor(color(255,0,0));
  }
  netProfitGraph.drawBar(0,netProfit);
  netProfitText.drawText("$" + nf(round(netProfit), 4));

}

void processMachineUtilization()
{
  calculateRollingMachineUtilization();
  
  if(rollingMachineUtilizationPercentage > targetMachineUtilization )
  {
    machineUtilizationGraph.setBarColor(color(0,255,0));    //green
    machineUtilizationText.setTextColor(color(0,255,0));

  }
  else if(rollingMachineUtilizationPercentage > minimalMachineUtilization )
  {
     machineUtilizationGraph.setBarColor(color(255,255,0));  //yellow
     machineUtilizationText.setTextColor(color(255,255,0));
  } 
  else
  {
    machineUtilizationGraph.setBarColor(color(255,0,0));    //red
    machineUtilizationText.setTextColor(color(255,0,0));
  }
  
  machineUtilizationGraph.drawBar(0,rollingMachineUtilizationPercentage);
  machineUtilizationText.drawText(nf((rollingMachineUtilizationPercentage * 100), 2, 1) + "%");
}

void sourceFileSelected(File selection)
{
  println("File Selected Callback Function called");
  if(selection == null)
  {
    sourceVideoPathNameWithExtension = null;
  }
  else
  {
    sourceVideoPathNameWithExtension = selection.getAbsolutePath();
  }
}