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
  //fullScreen();
  background(0);
  size(800, 480);
  noCursor();
  rawEvents.initializeEventTable("Komatsu");
  rawEvents.loadWithRandomData();
  rawEvents.saveEventTable();
  
//  dashboard.loadWithRandomData();
  dashboard.drawDashboardArea();
}

void draw()
{
  noLoop();
  calculateDashboard(rawEvents, dashTable);
  dashboard.drawDashboardData();
}