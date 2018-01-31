import java.util.*;        //calendar time functions 
import processing.io.*;    //hardware IO

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
SummaryDataTable summaryData   = new SummaryDataTable();
DayDashboard dashboard         = new DayDashboard();

void settings()
{
  loadPreferences();
  if(runningOnPi == 1)
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
  if(runningOnPi ==1)
  {
    noCursor();
  }

  SetupHardwareIO();
  background(0);
}

void draw()
{
  if(timeOfDayJustGotSet())
  {
    initializeTimer();
    rawEvents.initialize();
    summaryData.initialize();
    
    for(int i = 0; i < minuteOfDay(); i++)
    {
      dashboard.calculate(i, rawEvents);
    }
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
      rawEvents.addData(minuteOfDay(), readCycleCounter(), readActivityState(), readActivityState()+1); // simulating a state by adding one to activity
      resetActivityInputs();
      dashboard.calculate(minuteOfDay(), rawEvents);
      dashboard.drawGraphedData();
      if(minuteOfDay() % 5 ==0)  // save the data at the interval
      {
        rawEvents.save();
      }
    }
    

    if(newDay())
    {
      summaryData.addData(cal.get(Calendar.DAY_OF_YEAR)-1,dashboard.numberOfEvents,int(dashboard.uptimeMinutes));
      summaryData.save();

      rawEvents.save();
      rawEvents.initialize();
      dashboard.reset();
      saveFrame("../MachineData/" + 
                nf(cal.get(Calendar.DAY_OF_YEAR)-1,3)  + "," + 
                nf(cal.get(Calendar.MONTH)+1,2)        + "-" +
                nf(cal.get(Calendar.DATE)-1,2)         + "-" +
                nf(cal.get(Calendar.YEAR),2)           + ".png");
    }
  }
}