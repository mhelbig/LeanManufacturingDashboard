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
  rawEvents.addEventData(timeOfDay,2,3);
  rawEvents.saveEventTable();
  
  dashboard.loadWithRandomTestData();
  dashboard.drawDashboardArea();
}

void draw()
{
  noLoop();
  dashboard.drawDashboardData();
}