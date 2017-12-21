DayDashboard machine = new DayDashboard();

void setup() 
{
  //fullScreen();
  background(0);
  size(800, 480);
  noCursor();
  String timeOfDay = nf(hour(),2) + ":" + nf(minute(),2);
  buildEventTableFilename("Komatsu");
  openEventTable();
  addEventData(timeOfDay,2,3);
  saveEventTable();
  
  machine.loadWithRandomTestData();
  machine.drawDashboardArea();
}

void draw()
{
  noLoop();
  machine.drawDashboardData();
}