
Graph machineUptime = new Graph();
Graph netProfit = new Graph();

void setup() 
{
  size(1024, 768);
  background(0);

  machineUptime.initialize(10, 10, 720, 240, 0, 100, -50, 200, color(50), color(255), color(255), 4);
  machineUptime.setGridTextSize(18);                  

  machineUptime.setGridLineColor(color(80));
  machineUptime.addGridlineVertical(0, "");
  machineUptime.addGridlineVertical(25, "");
  machineUptime.addGridlineVertical(50, "");
  machineUptime.addGridlineVertical(75, "");
  machineUptime.addGridlineVertical(100, "");

  machineUptime.setGridLineColor(color(80));
  machineUptime.addGridlineHorizontal(-50, "-50");
  machineUptime.addGridlineHorizontal(0, "0");
  machineUptime.addGridlineHorizontal(50, "50");
  machineUptime.addGridlineHorizontal(100, "100");
  machineUptime.addGridlineHorizontal(150, "150");
  machineUptime.addGridlineHorizontal(200, "200");
  machineUptime.drawTitle(10, 6, LEFT, TOP, 25, "Machine Uptime");

  netProfit.initialize(10, 267, 720, 140,   0, 100, -200, 200,   color(50), color(255), color(255), 4);
  netProfit.setGridTextSize(18);                  

  netProfit.setGridLineColor(color(80));
  netProfit.addGridlineVertical(0, "0");
  netProfit.addGridlineVertical(25, "25");
  netProfit.addGridlineVertical(50, "50");
  netProfit.addGridlineVertical(75, "75");
  netProfit.addGridlineVertical(100, "100");

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
  for(float i=0; i<100; i+= 0.13888888888889)
  {
    machineUptime.drawBar(i, 200, i);
  }

  for(float i=0; i<100; i+=0.13888888888889)
  {
    netProfit.drawBar(i, 0, random(-200, 200) );
  }
}