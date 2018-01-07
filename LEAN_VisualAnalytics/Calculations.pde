void calculateDashboard(EventDataTable rawEvents, DashboardTable dashTable)
{
  RollingAverage utilizationAverage = new RollingAverage();
  int status = 0;
  float netProfit = 0;
  float netProfitMax = 0;
  float netProfitMin = 0;

  for (int minuteOfDay = startMinute; minuteOfDay < endMinute; minuteOfDay ++)
  {
    TableRow dashboardRow = dashTable.dashboardData.getRow(minuteOfDay);
    TableRow rawDataRow   = rawEvents.machineCycles.getRow(minuteOfDay);
    
    status = rawDataRow.getInt("state");
    dashboardRow.setInt("state",status); 
    
    utilizationAverage.add( float(status >= 2 ? 1 : 0));
    utilizationAverage.calculate();
    dashboardRow.setInt("uptime",int(utilizationAverage.currentValue()*100));
    
    netProfit -= (overheadRatePerHour / 60);
    if(status >= 2)
    {
      netProfit += (profitRatePerHour / 60);
    }
    dashboardRow.setFloat("netprofit",netProfit); 
    
    //autorange the graph to fit the min and max netprofit:
    if(netProfit > netProfitMax) netProfitMax = netProfit;
    if(netProfit < netProfitMin) netProfitMin = netProfit;
    dashboard.netProfit.adjustGraphVerticalRange(netProfitMax,netProfitMin);
  }
}


class RollingAverage
{
  int bufferSize = 50;
  int bufferPointer = 0;
  float totalActivity = 0;
  float[] buffer = new float[bufferSize];
  
  RollingAverage()
  {
  }
  
  void reset()
  {
    int i;

    for(i=0;i<bufferSize;i++)
    {
      buffer[i] = 0;
    }
    totalActivity = 0;      
  }
  
  void add(float input)
  {
    buffer[bufferPointer] = input;
    bufferPointer++;
    if(bufferPointer >= bufferSize) bufferPointer = 0;
  }    
  
  void calculate()
  {
    int i;
    totalActivity = 0;

    for(i=0;i<bufferSize;i++)
    {
      totalActivity+= buffer[i];
    }
  }
  
  float currentValue()
  {
    return (totalActivity / float(bufferSize));
  }
}