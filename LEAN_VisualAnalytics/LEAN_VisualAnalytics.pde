//System-wide global variables:
float overheadRatePerHour   =  75.00;
float profitRatePerHour     = 150.00;
  
int startMinute             = 0;
int endMinute               = 24 * 60;

EventDataTable rawEvents    = new EventDataTable();
DashboardTable dashTable    = new DashboardTable();
DayDashboard dashboard      = new DayDashboard();

void setup() 
{
  // un-comment for running on the pi  
  // fullScreen(); noCursor();
  
  // un-comment for running on the PC  
  size(800, 480);

  rawEvents.initializeEventTable("Komatsu");
  mouseClicked();  // start off with a screen, then let the mouse clicks update it
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