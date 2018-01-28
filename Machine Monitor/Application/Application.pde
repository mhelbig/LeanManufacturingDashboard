import java.util.*;        //calendar time functions 
import processing.io.*;    //hardware IO

// Target device compile flags:
boolean runningOnPi         = false;
boolean ludicrousSpeed      = true;
boolean useMouseInputMode   = true;
  
//Global constants:
int startMinute             = 0;
int endMinute               = (24 * 60) -1;

// Global dashboard appearance attributes:
color backgroundColor        = 40;
color frameColor             = 255;
int   frameLineWeight        = 2;
color textColor              = color(255,255,255);
int   leftMargin             = 4;
int   topMargin              = 4;
int   rightMargin            = 4;
int   bottomMargin           = 0;

Preference programPreferences  = new Preference();
EventDataTable rawEvents       = new EventDataTable();
DayDashboard dashboard         = new DayDashboard();

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

  loadPreferences();
  SetupHardwareIO();
  background(0);
}

void draw()
{
  if(timeOfDayJustGotSet())
  {
    initializeTimer();
    rawEvents.initializeEventTable();
    getNextIntervalTime();
    dashboard.drawGraphedData();
  }

  if(timeOfDayIsSet())
  {  
    checkActivityInput();
    dashboard.drawRealtimeData();
    
    if(intervalTimeExpired())
    {
      background(0);
      dashboard.drawRealtimeData();
      rawEvents.addEventData(minuteOfDay(), readCycleCounter(), readActivityState(), readActivityState()*2);
      resetActivityInputs();
      dashboard.calculate(minuteOfDay(), rawEvents);
      dashboard.drawGraphedData();
      rawEvents.saveEventTable();
    }
    

    if(newDay())
    {
     rawEvents.initializeEventTable();
     dashboard.reset();
     println("New Day: " + nf(cal.get(Calendar.DATE),2));
    }
  }
}