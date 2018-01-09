import java.util.*;        //used for calendar time functions 
import processing.io.*;    //Hardware IO

// Target device compile flags:
boolean runningOnPi         = false;
boolean runFullSpeed        = true;
boolean useMouseInputMode   = false;
  
//System-wide global variables:
String machineName          = "Komatsu";
int machineCycleInputBCM    = 24;  // Pin 18 = BCM 24 = input "2" on SimpleIO PCB
int machineActiveInputBCM   = 25;  // Pin 22 = BCM 25 = input "1" on SimpleIO PCB
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
int startMinute             = 0;
int endMinute               = 24 * 60;
int intervalTime            = 0;

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

  initializeTimer();
  rawEvents.initializeEventTable();
  SetupHardwareIO();
  getNextIntervalTime();
  dashboard.drawGraph();
}

void draw()
{
  checkActivityInput();
  
  if(intervalTimeExpired())
  {
    rawEvents.addEventData(minuteOfDay(), readCycleCounter(), readActivityState(), readActivityState()*2);
    resetInputFlags();
    
    background(0);
    dashboard.calculate(minuteOfDay(), rawEvents);
    dashboard.drawGraph();
    dashboard.drawData(minuteOfDay());
    rawEvents.saveEventTable();
  }
  if(newDay())
  {
   rawEvents.initializeEventTable();
   dashboard.reset();
  }
}