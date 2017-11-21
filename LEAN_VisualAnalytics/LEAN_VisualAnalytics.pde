
Graph machineUptime = new Graph();
Graph netProfit = new Graph();

float startTime = 6;
float endTime   = 6 + 12;

void setup() 
{
  size(1024, 768);
  background(0);

  machineUptime.initialize(10, 10, 720, 240,   startTime, endTime, -50, 200,  color(50), color(255), color(255), 4);
  netProfit.initialize(    10, 267, 720, 140,  startTime, endTime, -200, 200, color(50), color(255), color(255), 4);

  machineUptime.setGridTextSize(18);                  
  netProfit.setGridTextSize(18);                  

  netProfit.setGridLineColor(color(80));
  for(float timeOfDay = startTime; timeOfDay <= endTime; timeOfDay ++)
  {
    machineUptime.addGridlineVertical(timeOfDay, "");
    netProfit.addGridlineVertical(timeOfDay, nf(timeOfDay)+":00");
  }

  machineUptime.setGridLineColor(color(80));
  machineUptime.addGridlineHorizontal(-50, "-50");
  machineUptime.addGridlineHorizontal(0, "0");
  machineUptime.addGridlineHorizontal(50, "50");
  machineUptime.addGridlineHorizontal(100, "100");
  machineUptime.addGridlineHorizontal(150, "150");
  machineUptime.addGridlineHorizontal(200, "200");
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
  for(float i=startTime; i<=endTime; i+= 1)
  {
    machineUptime.drawBar(i, 200, i*10);
  }

  for(float i=startTime; i<=endTime; i+=0.2)
  {
    netProfit.drawBar(i, 0, random(-200, 200) );
  }
}