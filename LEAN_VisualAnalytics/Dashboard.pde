float startHour = 0;
float endHour   = 24;

color screenBackgroundColor  = 0;
int graphWidths              = 720;

int statusGraphHeight = 40;

int uptimeGraphHeight   = 150;
float uptimeMinUptime   = 0;
float uptimeMaxUptime   = 100;
int   uptimeGrid        = 20;
float uptimeRedLimit    = 30;
float uptimeYellowLimit = 50;
float uptimeGreenLimit  = 75;

int netProfitGraphHeight     = 250;
float netProfitMin           = -100;
float netProfitMax           =  200;
float netProfitGridLines     =  6;
float netProfitRedLimit      = -1;
float netProfitYellowLimit   = 75;
float netProfitGreenLimit    = 150;

Graph status    = new Graph();
Graph uptime    = new Graph();
Graph netProfit = new Graph();

void drawDayDashboard()
{
  status.initializeGraphFrame(0, 0,  graphWidths, statusGraphHeight, true, false,
                                     startHour, endHour, 0, 1);
  uptime.initializeGraphFrame(0, status.graphPositionBottom(),  graphWidths, uptimeGraphHeight, true, false,
                                     startHour, endHour, uptimeMinUptime, uptimeMaxUptime);
  netProfit.initializeGraphFrame(0, uptime.graphPositionBottom(), graphWidths, netProfitGraphHeight, true, true,
                                 startHour, endHour, netProfitMin, netProfitMax);
  netProfit.adjustGraphVerticalRange();                                 
  
  status.drawGraphPlotArea();
  uptime.drawGraphPlotArea();
  netProfit.drawGraphPlotArea();
  
//  status.drawDebugReferenceFrame();
//  uptime.drawDebugReferenceFrame();
//  netProfit.drawDebugReferenceFrame();

// Vertical time gridlines - all graphs
  status.setGridLineColor(color(80));
  uptime.setGridLineColor(color(80));
  netProfit.setGridLineColor(color(80));
  for (float timeOfDay = startHour; timeOfDay <= endHour; timeOfDay ++)
  {
    status.addGridlineVertical(timeOfDay, "");
    uptime.addGridlineVertical(timeOfDay, "");
    int t = int (timeOfDay % 12);
    if (t == 0) t=12;
    netProfit.addGridlineVertical(timeOfDay, nf(t)+ ((timeOfDay < 12) ? "a" : "p"));
  }

// Status graph
  status.drawTitle(10, 6, LEFT, TOP, "Status");


// Machine uptime
  uptime.drawTitle(10, 6, LEFT, TOP, "Uptime");
  uptime.setGridLineColor(color(80));
  for (int i = uptimeGrid; i <= (100 - uptimeGrid); i = i + uptimeGrid)
  {
    uptime.addGridlineHorizontal(i, nf(i) + "%");
  }

// Net profit
  netProfit.drawTitle(10, 6, LEFT, TOP, "Net Profit");
  netProfit.drawHorizontalGridlines();  
}