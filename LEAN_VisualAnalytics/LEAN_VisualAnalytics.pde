import processing.io.*;

//System-wide global variables:
int machineCycleInputBCM    = 26; 
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
boolean runningOnPi         = false;
  
int startMinute             = 0;
int endMinute               = 24 * 60;

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
    SetupCycleCounter(machineCycleInputBCM);
    SetupTimeCounter(5);
  }
  rawEvents.initializeEventTable("Komatsu");
  mouseClicked();  // generate the first screen, then let the mouse clicks update it
//  dashboard.loadWithRandomData();
}

void draw()
{
//  noLoop();
}

void mouseClicked()
{
  background(0);
  rawEvents.loadWithRandomData();
  calculateDashboard(rawEvents, dashTable);
  dashboard.drawDashboardArea();
  dashboard.drawDashboardData();
  rawEvents.saveEventTable();
}