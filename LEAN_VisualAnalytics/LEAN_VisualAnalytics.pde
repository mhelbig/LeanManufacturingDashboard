import processing.io.*;    //Hardware IO

// Target device compile flags:
boolean runningOnPi         = true;
boolean inEmulatorMode      = false;
  
//System-wide global variables:
int machineCycleInputBCM    = 24;  // Pin 18 = BCM 24
int machineActiveInputBCM   = 25;  // Pin 22 = BCM 25
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
int startMinute             = 0;
int endMinute               = 24 * 60;
int timer                   = millis() + 1000;

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

  rawEvents.initializeEventTable("Komatsu");
  SetupHardwareIO();
  mouseClicked();  // generate the first screen, then let the mouse clicks update it
}

void draw()
{
  checkActivityInput();
  if(millis() > timer)
  {
    if(readActivityStatus() == 1)
    {
      print("Activity  ");
    }
    else
    {
      print("none      ");
    }
    println("counts: " + readCycleCounter());
    timer = millis() + 1000;
    clearActivityFlag();
    clearCycleCounter();
  }
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