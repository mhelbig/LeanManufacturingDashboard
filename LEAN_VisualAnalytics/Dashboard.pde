int startMinute             = 0;
int endMinute               = 24 * 60;

color screenBackgroundColor = 0;
int   graphWidths           = 720;

int   statusGraphHeight     = 40;

int   uptimeGraphHeight     = 150;
float uptimeMinUptime       = 0;
float uptimeMaxUptime       = 100;
int   uptimeGrid            = 20;
float uptimeRedLimit        = 30;
float uptimeYellowLimit     = 50;
float uptimeGreenLimit      = 75;

int   netProfitGraphHeight  = 250;
float netProfitMin          = -100;
float netProfitMax          =  200;
float netProfitGridLines    =  6;
float netProfitRedLimit     = -1;
float netProfitYellowLimit  = 75;
float netProfitGreenLimit   = 150;

Graph status    = new Graph();
Graph uptime    = new Graph();
Graph netProfit = new Graph();

void drawDayDashboard()
{
  background(screenBackgroundColor);

  status.initializeGraphFrame(0, 0,  graphWidths, statusGraphHeight, true, false,
                                     startMinute, endMinute, 0, 1);
  uptime.initializeGraphFrame(0, status.graphPositionBottom(),  graphWidths, uptimeGraphHeight, true, false,
                                 startMinute, endMinute, uptimeMinUptime, uptimeMaxUptime);
  netProfit.initializeGraphFrame(0, uptime.graphPositionBottom(), graphWidths, netProfitGraphHeight, true, true,
                                 startMinute, endMinute, netProfitMin, netProfitMax);
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
  for (float minuteOfDay = startMinute; minuteOfDay <= endMinute; minuteOfDay += 60)
  {
    status.addGridlineVertical(minuteOfDay, "");
    uptime.addGridlineVertical(minuteOfDay, "");
    int t = int ((minuteOfDay/60) % 12);
    if (t == 0) t=12;
    netProfit.addGridlineVertical(minuteOfDay, nf(t)+ ((minuteOfDay < 12) ? "a" : "p"));
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

void drawGraphFromTable(Table data)
{
  for (int i=startMinute; i<endMinute; i++)
  {
    TableRow tableRow = data.getRow(i);
    
    int graphStatus = tableRow.getInt("status");
    switch(graphStatus)
    {
      case 0:
        status.setBarColor(color(127,127,127));
        break;
      case 1:
        status.setBarColor(color(0,255,0));
        break;
      case 2:
        status.setBarColor(color(255,127,0));
        break;
      case 3:
        status.setBarColor(color(255,0,0));
        break;
    }
    status.drawBar(i, 0, statusGraphHeight);
    
    float uptimePercentage = tableRow.getFloat("uptime");
    if      (uptimePercentage > uptimeGreenLimit)  uptime.setBarColor(color(0,255,0));
    else if (uptimePercentage > uptimeYellowLimit) uptime.setBarColor(color(255,255,0));
    else                            uptime.setBarColor(color(255,0,0));
    uptime.drawBar(i, 0, uptimePercentage);

    float netProfitDollars = tableRow.getFloat("netprofit");
    netProfit.drawBar(i, 0, netProfitDollars );
    netProfit.adjustGraphVerticalRange();
  }
}