class DayDashboard
{
  int   graphWidths           = 700;
  int   statusGraphHeight     = 40;
  int   uptimeGraphHeight     = 150;

  int   readoutWidths         = 100;

  float uptimeMinUptime       = 0;
  float uptimeMaxUptime       = 100;
  int   uptimeGrid            = 20;
  float uptimeRedLimit        = 30;
  float uptimeYellowLimit     = 50;
  float uptimeGreenLimit      = 75;
  
  int   netProfitGraphHeight  = 250;
  float netProfitMin          =  10;
  float netProfitMax          = -10;
  float netProfitGridLines    =  6;
  float netProfitRedLimit     = -1;
  float netProfitYellowLimit  = 75;
  float netProfitGreenLimit   = 150;
  
  Table dashboardData;
  float currentNetProfit      = 0;
  RollingAverage utilizationAverage = new RollingAverage();

  Graph statusGraph    = new Graph();
  Graph uptimeGraph    = new Graph();
  Graph netProfitGraph = new Graph();

  Readout statusReadout     = new Readout();
  Readout uptimeReadout     = new Readout();
  Readout netProfitReadout  = new Readout();
  
  DayDashboard()  //constructor
  {
    //build all the graphs & readouts
    statusGraph.initializeGraphFrame(0, 0,  graphWidths, statusGraphHeight, true, false,
                                       startMinute, endMinute, 0, 1);
    //statusReadout.initialize("Status",statusGraph.graphPositionRight(),0,readoutWidths,statusGraphHeight);
                                       
    
    uptimeGraph.initializeGraphFrame(0, statusGraph.graphPositionBottom(),  graphWidths, uptimeGraphHeight, true, false,
                                   startMinute, endMinute, uptimeMinUptime, uptimeMaxUptime);
    //uptimeReadout.initialize("Uptime",uptimeGraph.graphPositionRight(),statusGraph.graphPositionBottom(),readoutWidths,uptimeGraphHeight);
                                       

    netProfitGraph.initializeGraphFrame(0, uptimeGraph.graphPositionBottom(), graphWidths, netProfitGraphHeight, true, true,
                                   startMinute, endMinute, netProfitMin, netProfitMax);
    //netProfitReadout.initialize("Uptime",netProfitGraph.graphPositionRight(),uptimeGraph.graphPositionBottom(),readoutWidths,netProfitGraphHeight-60);
                                   
    // create the dashboard data table
    dashboardData = new Table();
    dashboardData.addColumn("time");
    dashboardData.addColumn("state");
    dashboardData.addColumn("uptime");
    dashboardData.addColumn("netprofit");
    fillTable();
  }
  
  void drawGraph()
  {
    //Readouts
//    statusReadout.drawReadout();
//    uptimeReadout.drawReadout();
//    netProfitReadout.drawReadout();

    //Graphs
    statusGraph.drawGraphPlotArea();    //status.drawDebugReferenceFrame();
    uptimeGraph.drawGraphPlotArea();    //uptime.drawDebugReferenceFrame();
    netProfitGraph.drawGraphPlotArea(); //netProfit.drawDebugReferenceFrame();
  
    // Vertical time gridlines - all graphs
    statusGraph.setGridLineColor(color(80));
    uptimeGraph.setGridLineColor(color(80));
    netProfitGraph.setGridLineColor(color(80));
    for (float minuteOfDay = startMinute; minuteOfDay <= endMinute; minuteOfDay += 60)
    {
      statusGraph.addGridlineVertical(minuteOfDay, "");
      uptimeGraph.addGridlineVertical(minuteOfDay, "");
      int t = int ((minuteOfDay/60) % 12);
      if (t == 0) t=12;
      netProfitGraph.addGridlineVertical(minuteOfDay, nf(t)+ ((minuteOfDay < 12) ? "a" : "p"));
    }
  
  // Status graph
    statusGraph.drawTitle(10, 6, LEFT, TOP, "Status");
  
  
  // Machine uptime
    uptimeGraph.drawTitle(10, 6, LEFT, TOP, "Uptime");
    uptimeGraph.setGridLineColor(color(80));
    for (int i = uptimeGrid; i <= (100 - uptimeGrid); i = i + uptimeGrid)
    {
      uptimeGraph.addGridlineHorizontal(i, nf(i) + "%");
    }
  
  // Net profit
    netProfitGraph.drawTitle(10, 6, LEFT, TOP, "Net Profit");
    netProfitGraph.drawHorizontalGridlines();  
  }
  
  void drawData(int time)
  {
    for(int i = startMinute; i < endMinute; i++)
    {
      TableRow tableRow = dashboardData.getRow(i);
      
      int graphStatus = tableRow.getInt("state");
      switch(graphStatus)
      {
        case 0:
          statusGraph.setBarColor(color(127,127,127));
          break;
        case 1:
          statusGraph.setBarColor(color(255,0,0));
          break;
        case 2:
          statusGraph.setBarColor(color(255,127,0));
          break;
        case 3:
          statusGraph.setBarColor(color(0,255,0));
          break;
      }
//      println("statusGraph");
      statusGraph.drawBar(i, 0, statusGraphHeight);
      
      float uptimePercentage = tableRow.getFloat("uptime");
      
      if      (uptimePercentage > uptimeGreenLimit)  uptimeGraph.setBarColor(color(0,255,0));
      else if (uptimePercentage > uptimeYellowLimit) uptimeGraph.setBarColor(color(255,255,0));
      else                                           uptimeGraph.setBarColor(color(255,0,0));
//      println("uptimeGraph");
      uptimeGraph.drawBar(i, 0, uptimePercentage);
  
      float netProfitDollars = tableRow.getFloat("netprofit");
      if      (netProfitDollars > netProfitGreenLimit)  netProfitGraph.setBarColor(color(0,255,0));
      else if (netProfitDollars > netProfitYellowLimit) netProfitGraph.setBarColor(color(255,255,0));
      else                                              netProfitGraph.setBarColor(color(255,0,0));
      netProfitGraph.drawBar(i, 0, netProfitDollars );
    }
  }

  void calculate(int time, EventDataTable rawEvents)
  {
    int state;
    int active;
    int cycles;
    
    TableRow rawDataRow   = rawEvents.machineCycles.getRow(time);
    
    cycles = rawDataRow.getInt("cycles");
    active = rawDataRow.getInt("active");
    state = rawDataRow.getInt("state");
    
    utilizationAverage.add( float(active == 1 ? 1 : 0));
    utilizationAverage.calculate();
    
    currentNetProfit -= (overheadRatePerHour / 60);
    if(state >= 2 || cycles > 0)
    {
      currentNetProfit += (profitRatePerHour / 60);
    }
    
    TableRow row = dashboardData.getRow(time);
    row.setInt("time",time);
    row.setInt("state",state);
    row.setInt("uptime",int(utilizationAverage.currentValue()*100));
    row.setFloat("netprofit",currentNetProfit);
    println(time + " " + row.getFloat("netprofit"));
    
    //autorange the graph to fit the min and max netprofit:
    if(currentNetProfit > netProfitMax) netProfitMax = currentNetProfit;
    if(currentNetProfit < netProfitMin) netProfitMin = currentNetProfit;
    dashboard.netProfitGraph.adjustGraphVerticalRange(netProfitMax,netProfitMin);
  }
  
  void reset()
  {
    currentNetProfit      = 0;
    netProfitMin          =  10;
    netProfitMax          = -10;
    utilizationAverage.reset();
    dashboardData.clearRows();
    fillTable();
  }
  
  void fillTable()
  {
    for(int i = startMinute; i < endMinute; i++)
    {
      TableRow row = dashboardData.getRow(i);
      row.setInt("time",i);
      row.setInt("state",0);
      row.setInt("uptime",0);
      row.setFloat("netprofit",0.0);
    }
  }
}  