float startTime = 6;
float endTime   = 6 + 12;

color screenBackgroundColor  = 0;
int graphBarTransparency     = 80;
int graphWidths              = 720;

int machineUptimeGraphHeight = 200;
float machineUptimeMinUptime = 0;
float machineUptimeMaxUptime = 100;

int netProfitGraphHeight     = 250;
float netProfitMin           = -250;
float netProfitMax           =  250;


Graph machineUptime = new Graph();
Graph netProfit     = new Graph();

void setup() 
{
  //fullScreen();
  size(900, 580);
  background(screenBackgroundColor);
  noCursor();

  machineUptime.initializeGraphFrame(0, 0,  graphWidths, machineUptimeGraphHeight, true, false,
                                     startTime, endTime, machineUptimeMinUptime, machineUptimeMaxUptime);
  netProfit.initializeGraphFrame(0, machineUptime.graphPositionBottom(), graphWidths, netProfitGraphHeight, true, true,
                                 startTime, endTime, netProfitMin, netProfitMax);
  
//  machineUptime.drawDebugReferenceFrame();
//  netProfit.drawDebugReferenceFrame();

  netProfit.setGridLineColor(color(80));
  for (float timeOfDay = startTime; timeOfDay <= endTime; timeOfDay ++)
  {
    machineUptime.addGridlineVertical(timeOfDay, "");
    netProfit.addGridlineVertical(timeOfDay, nf(timeOfDay)+":00");
  }

  machineUptime.setGridLineColor(color(80));
  for (int i = 10; i <=90; i=i+10)
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
  machineUptime.setBarColor(color(0, 0, 255, graphBarTransparency));
  for (float i=startTime; i<=endTime; i+= .2)
  {
    machineUptime.drawBar(i, 0, random(15, 95));
  }

  netProfit.setBarColor(color(255, 255, 0, graphBarTransparency));
  for (float i=startTime; i<=endTime; i+=0.2)
  {
    netProfit.drawBar(i, 0, random(-200, 200) );
  }
}