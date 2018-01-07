import java.util.*;        //used for calendar time functions 
import processing.io.*;    //Hardware IO

// Target device compile flags:
boolean runningOnPi         = false;
boolean inEmulatorMode      = true;
boolean useRandomData       = false;
  
//System-wide global variables:
int machineCycleInputBCM    = 24;  // Pin 18 = BCM 24
int machineActiveInputBCM   = 25;  // Pin 22 = BCM 25
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
int startMinute             = 0;
int endMinute               = 24 * 60;
int intervalTime            = 0;

EventDataTable rawEvents    = new EventDataTable();
DashboardTable dashTable    = new DashboardTable();
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
  rawEvents.initializeEventTable("Komatsu");
  SetupHardwareIO();
  getNextIntervalTime();
  dashboard.drawDashboardArea();
}

void draw()
{
  checkActivityInput();
  
  if(intervalTimeExpired())
  {
    rawEvents.setEventData(minuteOfDay(), readCycleCounter(), readActivityStatus(), 2);
    clearActivityFlag();
    clearCycleCounter();
    updateDashboard();
  }
  if(newDay())
  {
   rawEvents.initializeEventTable("Komatsu");
  }
}

void mouseClicked()
{
  if(useRandomData)
  {
    rawEvents.loadWithRandomData();
    updateDashboard();
  }
}

void updateDashboard()
{
  background(0);
  calculateDashboard(rawEvents, dashTable);
  dashboard.drawDashboardArea();
  dashboard.drawDashboardData();
  rawEvents.saveEventTable();
}