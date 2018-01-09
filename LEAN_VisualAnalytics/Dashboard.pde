class DayDashboard
{
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
  float netProfitMax          =  300;
  float netProfitGridLines    =  6;
  float netProfitRedLimit     = -1;
  float netProfitYellowLimit  = 75;
  float netProfitGreenLimit   = 150;
  
  Table dashboardData;
  float currentNetProfit      = 0;
  RollingAverage utilizationAverage = new RollingAverage();

  Graph status    = new Graph();
  Graph uptime    = new Graph();
  Graph netProfit = new Graph();
  
  DayDashboard()  //constructor
  {
    //build all the graphs
    status.initializeGraphFrame(0, 0,  graphWidths, statusGraphHeight, true, false,
                                       startMinute, endMinute, 0, 1);
    uptime.initializeGraphFrame(0, status.graphPositionBottom(),  graphWidths, uptimeGraphHeight, true, false,
                                   startMinute, endMinute, uptimeMinUptime, uptimeMaxUptime);
    netProfit.initializeGraphFrame(0, uptime.graphPositionBottom(), graphWidths, netProfitGraphHeight, true, true,
                                   startMinute, endMinute, netProfitMin, netProfitMax);
    // create the dashboard data table
    dashboardData = new Table();
    dashboardData.addColumn("time");
    dashboardData.addColumn("state");
    dashboardData.addColumn("uptime");
    dashboardData.addColumn("netprofit");
  }
  
  void calculate(int time, EventDataTable rawEvents)
  {
    int state = 0;
    int active = 0;
    int cycles = 0;
    
    float netProfitMax = 0;
    float netProfitMin = 0;
  //  netProfit = 0;
  //  utilizationAverage.reset();
    
    TableRow rawDataRow   = rawEvents.machineCycles.getRow(time);
    
    cycles = rawDataRow.getInt("cycles");
    active = rawDataRow.getInt("active");
    state = rawDataRow.getInt("state");
    
    utilizationAverage.add( float(active == 1 ? 1 : 0));
    utilizationAverage.calculate();
    
    currentNetProfit -= (overheadRatePerHour / 60);
    if(state >= 2)
    {
      currentNetProfit += (profitRatePerHour / 60);
    }
    
    TableRow row = dashboardData.getRow(time);
    row.setInt("time",time);
    row.setInt("state",state);
    row.setInt("uptime",int(utilizationAverage.currentValue()*100));
    row.setFloat("netprofit",currentNetProfit);
    
    //autorange the graph to fit the min and max netprofit:
    if(currentNetProfit > netProfitMax) netProfitMax = currentNetProfit;
    if(currentNetProfit < netProfitMin) netProfitMin = currentNetProfit;
    dashboard.netProfit.adjustGraphVerticalRange(netProfitMax,netProfitMin);
  }
  
  void reset()
  {
    currentNetProfit = 0;
    utilizationAverage.reset();
    dashboardData.clearRows();
  }
  void drawGraph()
  {
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
  
  void drawData(int time)
  {
    for(int i = startMinute; i < time; i++)
    {
      TableRow tableRow = dashboardData.getRow(i);
      
      int graphStatus = tableRow.getInt("state");
      switch(graphStatus)
      {
        case 0:
          status.setBarColor(color(127,127,127));
          break;
        case 1:
          status.setBarColor(color(255,0,0));
          break;
        case 2:
          status.setBarColor(color(255,127,0));
          break;
        case 3:
          status.setBarColor(color(0,255,0));
          break;
      }
      status.drawBar(i, 0, statusGraphHeight);
      
      float uptimePercentage = tableRow.getFloat("uptime");
      
      if      (uptimePercentage > uptimeGreenLimit)  uptime.setBarColor(color(0,255,0));
      else if (uptimePercentage > uptimeYellowLimit) uptime.setBarColor(color(255,255,0));
      else                                           uptime.setBarColor(color(255,0,0));
      uptime.drawBar(i, 0, uptimePercentage);
  
      float netProfitDollars = tableRow.getFloat("netprofit");
      if      (netProfitDollars > netProfitGreenLimit)  netProfit.setBarColor(color(0,255,0));
      else if (netProfitDollars > netProfitYellowLimit) netProfit.setBarColor(color(255,255,0));
      else                                              netProfit.setBarColor(color(255,0,0));
      netProfit.drawBar(i, 0, netProfitDollars );
    }
  }
}  