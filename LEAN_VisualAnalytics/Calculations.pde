RollingAverage utilizationAverage = new RollingAverage();
float netProfit = 0;

void calculateDashboard(int time, EventDataTable rawEvents, DashboardTable dashTable)
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
  
  netProfit -= (overheadRatePerHour / 60);
  if(state >= 2)
  {
    netProfit += (profitRatePerHour / 60);
  }
  
  dashTable.setDashboardData(time, state, int(utilizationAverage.currentValue()*100), netProfit);
  
  //autorange the graph to fit the min and max netprofit:
  if(netProfit > netProfitMax) netProfitMax = netProfit;
  if(netProfit < netProfitMin) netProfitMin = netProfit;
  dashboard.netProfit.adjustGraphVerticalRange(netProfitMax,netProfitMin);
}

void resetCalculations()
{
  netProfit = 0;
  utilizationAverage.reset();
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