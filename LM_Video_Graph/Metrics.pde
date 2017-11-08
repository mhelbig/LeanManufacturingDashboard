// Net Profit
float netProfit = 0;
float overheadRatePerFrame;
float revenueRatePerFrame;

void calculateNetProfit()
{
  if(machineActive)
  {
    netProfit += revenueRatePerFrame;
  }
  netProfit -= overheadRatePerFrame;
}

// Machine Utilization
class RollingAverage
{
  int bufferSize = 1000;
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