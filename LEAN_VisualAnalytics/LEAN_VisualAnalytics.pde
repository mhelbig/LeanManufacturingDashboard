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
  size(800, 480);
  //noCursor();
  rawEvents.initializeEventTable("Komatsu");
  
//  dashboard.loadWithRandomData();
}

void draw()
{
//  noLoop();
  background(0);
  rawEvents.loadWithRandomData();
  calculateDashboard(rawEvents, dashTable);
  dashboard.drawDashboardArea();
  dashboard.drawDashboardData();
  rawEvents.saveEventTable();
  
  delay(5000);
}