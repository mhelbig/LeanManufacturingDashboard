void setup() 
{
  //fullScreen();
  size(800, 480);
  background(screenBackgroundColor);
  noCursor();
}

void draw()
{
  noLoop();
  drawDayDashboard();

  for (float i=startHour; i<=endHour; i+= .2)
  {
    float c = random(15,95);
    if      (c > uptimeGreenLimit)  uptime.setBarColor(color(0,255,0));
    else if (c > uptimeYellowLimit) uptime.setBarColor(color(255,255,0));
    else                            uptime.setBarColor(color(255,0,0));
    uptime.drawBar(i, 0, c);
  }

  for (float i=startHour; i<=endHour; i+=0.2)
  {
    netProfit.drawBar(i, 0, random(-200, 200) );
  }
}