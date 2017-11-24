float startTime = 6;
float endTime   = 6 + 12;

int leftMargin   = 5;
int topMargin    = 5;
int rightMargin  = 75;
int bottomMargin = 0;
int bottomMarginAxisLabels   = 65;
int graphFrameLineWeight     = 3;
color graphBackgroundColor   = 40;
color screenBackgroundColor  = 0;
color graphBorderColor       = 255;
color graphTextColor         = 196;
int graphBarTransparency     = 80;
int graphWidths              = 720;

int machineUptimeGraphHeight = 250;
float machineUptimeMinUptime = 0;
float machineUptimeMaxUptime = 100;

int netProfitGraphHeight     = 290;
float netProfitMin           = -250;
float netProfitMax           =  250;


Graph machineUptime = new Graph(0, 0,  graphWidths, machineUptimeGraphHeight, 
                                leftMargin, rightMargin, topMargin, bottomMargin,
                                startTime, endTime, machineUptimeMinUptime, machineUptimeMaxUptime,
                                color(graphBackgroundColor), color(graphBorderColor), color(graphTextColor), graphFrameLineWeight);
Graph netProfit     = new Graph(0, machineUptime.graphPositionBottom()+ topMargin, graphWidths, netProfitGraphHeight,
                                leftMargin, rightMargin, 0, bottomMarginAxisLabels,
                                startTime, endTime, netProfitMin, netProfitMax,
                                color(graphBackgroundColor), color(graphBorderColor), color(graphTextColor), graphFrameLineWeight);

void setup() 
{
  //fullScreen();
  size(900, 580);
  background(screenBackgroundColor);
  noCursor();

  machineUptime.initializeGraphFrame();
  netProfit.initializeGraphFrame();
  
//  machineUptime.drawReferenceFrame();
//  netProfit.drawReferenceFrame();

  machineUptime.setGridTextSize(18);                  
  netProfit.setGridTextSize(18);                  

  netProfit.setGridLineColor(color(80));
  for (float timeOfDay = startTime; timeOfDay <= endTime; timeOfDay ++)
  {
    machineUptime.addGridlineVertical(timeOfDay, "");
    netProfit.addGridlineVertical(timeOfDay, nf(timeOfDay)+":00");
  }

  machineUptime.setGridLineColor(color(80));
  for (int i = 20; i <=80; i=i+20)
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