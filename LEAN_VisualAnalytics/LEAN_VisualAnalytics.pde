
Graph machineUptime = new Graph();
Graph netProfit = new Graph();

float startTime = 6;
float endTime   = 6 + 12;

void setup() 
{
  fullScreen();
  //size(800, 480);
  background(0);
  noCursor();

  machineUptime.initialize(10, 10,  700, 190,   startTime, endTime,   0, 100, color(40), color(255), color(196), 4);
  netProfit.initialize(    10, 215, 700, 180,  startTime, endTime, -200, 200, color(40), color(255), color(196), 4);

  machineUptime.setGridTextSize(18);                  
  netProfit.setGridTextSize(18);                  

  netProfit.setGridLineColor(color(80));
  for(float timeOfDay = startTime; timeOfDay <= endTime; timeOfDay ++)
  {
    machineUptime.addGridlineVertical(timeOfDay, "");
    netProfit.addGridlineVertical(timeOfDay, nf(timeOfDay)+":00");
  }

  machineUptime.setGridLineColor(color(80));
  for(int i = 20; i <=80; i=i+20)
  {
      machineUptime.addGridlineHorizontal(i, nf(i) + "%");
  }
  machineUptime.drawTitle(10, 6, LEFT, TOP, 25, "Machine Uptime");

  netProfit.setGridLineColor(color(255, 0, 0));
  netProfit.addGridlineHorizontal(-200, "$-200");
  netProfit.addGridlineHorizontal(-100, "$-100");
  netProfit.setGridLineColor(color(255, 255, 0));
  netProfit.addGridlineHorizontal(0, "$   0");
  netProfit.addGridlineHorizontal(100, "$ 100");
  netProfit.setGridLineColor(color(0, 255, 0));
  netProfit.addGridlineHorizontal(200, "$ 200");
  netProfit.drawTitle(10, 6, LEFT, TOP, 25, "Net Profit");
}

void draw()
{
  noLoop();
  machineUptime.setBarColor(color(0, 0, 255, 60));
  for(float i=startTime; i<=endTime; i+= .2)
  {
    machineUptime.drawBar(i, 0, random(15, 95));
  }

  for(float i=startTime; i<=endTime; i+=0.2)
  {
    netProfit.drawBar(i, 0, random(-200, 200) );
  }
}