import java.util.*;        //calendar time functions 
import processing.io.*;    //hardware IO

// Target device compile flags:
boolean runningOnPi         = true;
boolean ludicrousSpeed      = false;
boolean useMouseInputMode   = false;
  
//System-wide global variables:
String machineName          = "Komatsu";
int machineCycleInputBCM    = 24;  // Pin 18 = BCM 24 = input "2" on SimpleIO PCB
int machineActiveInputBCM   = 25;  // Pin 22 = BCM 25 = input "1" on SimpleIO PCB
float overheadRatePerHour   =  15.00;
float profitRatePerHour     =  75.00; // $60/hour netprofit per hour when active
int startMinute             = 0;
int endMinute               = 24 * 60;

// Global dashboard appearance attributes:
color backgroundColor        = 40;
color frameColor             = 255;
int   frameLineWeight        = 2;
color textColor              = color(255,255,255);
int   leftMargin             = 4;
int   topMargin              = 4;
int   rightMargin            = 4;
int   bottomMargin           = 0;

EventDataTable rawEvents    = new EventDataTable();
DayDashboard dashboard      = new DayDashboard();

void settings()
{
  if(runningOnPi)
  {
    fullScreen();
  }
  else
  {
  size(800, 480);
  }
}  

void setup() 
{
  if(runningOnPi)
  {
    noCursor();
  }

  background(0);
  initializeTimer();
  rawEvents.initializeEventTable();
  SetupHardwareIO();
  getNextIntervalTime();
  dashboard.drawGraphedData();
}

void draw()
{
  checkActivityInput();
  dashboard.drawRealtimeData();
  
  if(intervalTimeExpired())
  {
    rawEvents.addEventData(minuteOfDay(), readCycleCounter(), readActivityState(), readActivityState()*2);
    resetActivityInputs();
    
    dashboard.calculate(minuteOfDay(), rawEvents);
    background(0);
    dashboard.drawGraphedData();
    rawEvents.saveEventTable();
  }
  if(newDay())
  {
   rawEvents.initializeEventTable();
   dashboard.reset();
  }
}