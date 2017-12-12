void setup() 
{
  //fullScreen();
  size(800, 480);
  background(screenBackgroundColor);
  noCursor();

  String timeOfDay = nf(hour(),2) + ":" + nf(minute(),2);
  buildEventTableFilename("Komatsu");
  openEventTable();
  addEvent(timeOfDay,2,3);
  saveEventTable();
}

void draw()
{
  noLoop();
  drawDayDashboard();

  for (float i=startHour; i<=endHour + .0001; i+= .2)
  {
    float c = random(15,95);
    if      (c > uptimeGreenLimit)  uptime.setBarColor(color(0,255,0));
    else if (c > uptimeYellowLimit) uptime.setBarColor(color(255,255,0));
    else                            uptime.setBarColor(color(255,0,0));
    uptime.drawBar(i, 0, c);
  }

  for (float i=startHour; i<=endHour + .0001; i+=0.2)
  {
    netProfit.drawBar(i, 0, random(-100, 200) );
    netProfit.adjustGraphVerticalRange();
//    netProfit.drawGraph();
  }
}