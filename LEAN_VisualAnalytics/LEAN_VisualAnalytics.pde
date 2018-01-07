import processing.io.*;    //Hardware IO

// Target device compile flags:
boolean runningOnPi         = false;
boolean inEmulatorMode      = false;
boolean useRandomData       = false;
  
//System-wide global variables:
int machineCycleInputBCM    = 24;  // Pin 18 = BCM 24
int machineActiveInputBCM   = 25;  // Pin 22 = BCM 25
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
int startMinute             = 0;
int endMinute               = 24 * 60;
int timer                   = millis() + 1000;
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

  rawEvents.initializeEventTable("Komatsu");
  SetupHardwareIO();
  initIntervalTime();

  mouseClicked();  // generate the first screen, then let the mouse clicks update it
}

void draw()
{
  checkActivityInput();
  
  if(intervalTimeExpired())
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
    updateDashboard();
  }
}

void initIntervalTime()
{
  if(inEmulatorMode)
  {
    intervalTime = round( (( float(second()+5) / 5)) ) * 5 % 60;
    println("init interval second = " + intervalTime);
  }
  else
  {
    intervalTime = ( minute() + 1 ) % 60;
    println("init interval minute = " + intervalTime);
  }
}

boolean intervalTimeExpired()
{
  if(inEmulatorMode)
  {
    if(intervalTime == second())
    {
      intervalTime= ( second() + 5) % 60;
      println("seconds = " + intervalTime);
      return(true);
    }
    else
    {
      return(false);
    }
  }
  else if(intervalTime == minute())
  {
    intervalTime = ( minute() + 1 ) % 60;
    println("minute = " + intervalTime);
    return(true);
  }
  else
  {
    return(false);
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