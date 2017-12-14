void setup() 
{
  //fullScreen();
  size(800, 480);
  noCursor();

  String timeOfDay = nf(hour(),2) + ":" + nf(minute(),2);
  buildEventTableFilename("Komatsu");
  openEventTable();
  addEventData(timeOfDay,2,3);
  saveEventTable();
  
  createGraphDataTable();
  loadGraphDataTableWithRandomTestData();
}

void draw()
{
  noLoop();
  drawDayDashboard();
  drawGraphFromTable();
}