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
int   runMode = 1;
float sourceVideoSpeedMultiplier;
float videoDuration;
float playbackTime = 0;
boolean machineActive = false;
String sourceVideo = "unselected";

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
  
  translate(uiSpacing,uiSpacing);
  int verticalPositionTracking = SourceVideoHeight + uiSpacing;

// Progress Bar Setup  
  camera.drawVideoProgressBarFrame(0, verticalPositionTracking, sourceVideoWidth, videoProgressBarHeight);

//Machine Utilization Graph setup
  verticalPositionTracking += (uiSpacing + videoProgressBarHeight + frameWidth);
  machineUtilizationGraph.setPosition(0, verticalPositionTracking, sourceVideoWidth, machineUtilizationGraphHeight);
  machineUtilizationGraph.setRange(1, 0);
  machineUtilizationGraph.drawFrame();
  machineUtilizationGraph.drawHorizontalGridLine(targetMachineUtilization);
  machineUtilizationGraph.drawHorizontalGridLine(minimalMachineUtilization);
  machineUtilizationText.setPosition(sourceVideoWidth + uiSpacing, verticalPositionTracking, 100, machineUtilizationGraphHeight);
  
// Net Profit Graph setup
  verticalPositionTracking += (uiSpacing + machineUtilizationGraphHeight + frameWidth);
  netProfitGraph.setPosition(0, verticalPositionTracking, sourceVideoWidth, 150);
  netProfitGraph.setRange(100, -100);
  netProfitGraph.drawFrame();
  netProfitGraph.drawHorizontalGridLine(0);
  netProfitText.setPosition(sourceVideoWidth + uiSpacing, verticalPositionTracking, 100, 150);
  
  displayKeyboardControls();
  displayCompanyLogo();
}

void draw()
{
  switch(runMode) //Note: the video playback function increments runMode when the video ends
  { //<>//
    case 1:
      loadVideoFileToProcess();
    case 2:
      createVideoFileForOutput();
      videoExport.startMovie();
      break;
    case 3:                        // Analyze video, generate graphs & .csv data file
      analyzeVideo();
      break;
    case 4:                        // Save analysis data
      runMode=100;
      addEvent(videoDuration,0);
      break;
    case 100:                      // gracefully end the program
      closeEventTable();
      saveSystemParameters();
      videoExport.endMovie();
      exit();
  }
}

void loadVideoFileToProcess()
{
  selectInput("Select a source camera file:", "sourceFileSelected");

  while ( sourceVideo == "unselected")
  {
    print("");  //It seems as though we need to have something in the while for it to do or it hangs here forever. This does the trick for whatever reason.
  }
  
  if(sourceVideo == null)
  {
    println("No file Selected");
    runMode = 100;
  }
  else
  {
    playback = new Movie(this, sourceVideo);
    playback.play();
    videoDuration = playback.duration();
    playback.stop();                      // we need to do this to get a valid duration
    runMode++;
  }
}

void createVideoFileForOutput()
{
  videoExport = new VideoExport(this,sourceVideo + ".mp4");
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
  if(netProfit > 0 ) netProfitGraph.setBarColor(color(0,255,0,100));  //green
  else               netProfitGraph.setBarColor(color(255,0,0,100));  //red
  netProfitGraph.drawBar(0,netProfit);
  netProfitText.drawText("$" + nf(netProfit, 4, 2));

}

void processMachineUtilization()
{
  calculateRollingMachineUtilization();
  
  if(rollingMachineUtilizationPercentage > targetMachineUtilization )
  {
    machineUtilizationGraph.setBarColor(color(0,255,0,100));    //green
  }
  else if(rollingMachineUtilizationPercentage > minimalMachineUtilization )
  {
     machineUtilizationGraph.setBarColor(color(255,255,0,100));  //yellow
  } 
  else
  {
    machineUtilizationGraph.setBarColor(color(255,0,0,100));    //red
  }
  
  machineUtilizationGraph.drawBar(0,rollingMachineUtilizationPercentage);
  machineUtilizationText.drawText(nf((rollingMachineUtilizationPercentage * 100), 2, 1) + "%");
}

void sourceFileSelected(File selection)
{
  println("File Selected Callback Function called");
  if(selection == null)
  {
    sourceVideo = null;
  }
  else
  {
    sourceVideo = selection.getAbsolutePath();
  }
}