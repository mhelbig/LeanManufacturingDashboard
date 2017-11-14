import processing.video.*;
import com.hamoid.*;

// Video playback constants:
int sourceVideoWidth;
int SourceVideoHeight;
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
String sourceVideoFileNameOnly;
String sourceVideoPathNameWithExtension = "unselected";
String[] sourceVideoPathNameSplit;

Movie       playback;
VideoExport videoExport;

Preference programPreferences        = new Preference();
VideoProgressBar camera              = new VideoProgressBar();

TextBox progressBarTitle             = new TextBox();
TextBox progressBarTextBox           = new TextBox();

Graph utilizationGraph               = new Graph();
TextBox utilizationBoxTitle          = new TextBox();
TextBox utilizationPercentageTextBox = new TextBox();

Graph netProfitGraph                 = new Graph();
TextBox netProfitBoxTitle            = new TextBox();
TextBox netProfitTextBox             = new TextBox();
RollingAverage machineUtilization    = new RollingAverage();

void setup() 
{
  
  size(1024,768);
  loadPreferences();

  frameRate(outputFrameRate);
    
  initEventTable();
  overheadRatePerFrame = overheadRatePerHour / 3600 / outputFrameRate * sourceVideoSpeedMultiplier; //<>//
  revenueRatePerFrame  = revenueRatePerHour  / 3600 / outputFrameRate * sourceVideoSpeedMultiplier;
  
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
    case 2:                        // Create output file, reset data
      drawBaseUIElements();
      createVideoFileForOutput();
      videoExport.startMovie();
      netProfit = 0;
      events.clearRows();
      machineUtilization.reset();
      displayProgramConstants();
      runMode++;
      break;
    case 3:                        // Analyze video, generate graphs & .csv data file
      analyzeVideo();
      break;
    case 4:                        // User chose Stop video
      stopVideo();
      sourceVideoPathNameWithExtension = "unselected";
    case 5:                        // Save analysis data
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
    videoDuration = 599; //playback.duration();
    playback.stop();                      // we need to do this to get a valid duration
    runMode++;
  }
}

// Callback function:
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
    sourceVideoFileNameOnly          = selection.getName();
  }
}

void createVideoFileForOutput()
{
  sourceVideoPathNameSplit = split(sourceVideoPathNameWithExtension, ".");
  println(sourceVideoPathNameSplit[0]);
  videoExport = new VideoExport(this,sourceVideoPathNameSplit[0] + "-Processed.mp4");
  videoExport.setFrameRate(outputFrameRate);
}

void analyzeVideo()
{
  displayVideoFrame();
  opticallyDetectMachineState();
  displayActivityState();
  if(setDetectRegion) setActivityDetectRegion();

  translate(uiSpacing,uiSpacing);
  camera.displayVideoProgressBar();
  progressBarTextBox.drawText(nf((playbackTime/videoDuration*100),1,1) + "%");
  processMachineUtilization();
  processNetProfit();
  videoExport.saveFrame();
  println(playback.time());
//  displayFramerate();
}

void processNetProfit()
{
  calculateNetProfit();
  if(netProfit > 0 )
  {
    netProfitGraph.setBarColor(color(0,255,0));  //green
    netProfitTextBox.setTextColor(color(0,255,0));
  }
  else
  {
    netProfitGraph.setBarColor(color(255,0,0));  //red
    netProfitTextBox.setTextColor(color(255,0,0));
  }
  netProfitGraph.drawBar(0,netProfit);
  netProfitTextBox.drawText("$" + nf(round(netProfit), 3));

}

void processMachineUtilization()
{
  machineUtilization.add( float(machineActive ? 1 : 0));
  machineUtilization.calculate();
  
  if(machineUtilization.currentValue() > targetMachineUtilization )
  {
    utilizationGraph.setBarColor(color(0,255,0));    //green
    utilizationPercentageTextBox.setTextColor(color(0,255,0));

  }
  else if(machineUtilization.currentValue() > minimalMachineUtilization )
  {
     utilizationGraph.setBarColor(color(255,255,0));  //yellow
     utilizationPercentageTextBox.setTextColor(color(255,255,0));
  } 
  else
  {
    utilizationGraph.setBarColor(color(255,0,0));    //red
    utilizationPercentageTextBox.setTextColor(color(255,0,0));
  }
  
  utilizationGraph.drawBar(0,machineUtilization.currentValue());
  utilizationPercentageTextBox.drawText(nf((machineUtilization.currentValue() * 100), 2, 1) + "%");
}