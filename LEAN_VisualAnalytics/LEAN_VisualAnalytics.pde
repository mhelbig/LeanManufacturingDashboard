DayDashboard dashboard = new DayDashboard();
EventData rawEvents  = new EventData("Komatsu"); 

void setup() 
{
  //fullScreen();
  background(0);
  size(800, 480);
  noCursor();
  String timeOfDay = nf(hour(),2) + ":" + nf(minute(),2);
  rawEvents.openEventTable();
  rawEvents.loadWithRandomData();
  rawEvents.saveEventTable();
  
//  dashboard.loadWithRandomData();
  dashboard.drawDashboardArea();
}

void draw()
{
  noLoop();
  dashboard.calculateDashboard(rawEvents);
  dashboard.drawDashboardData();
}