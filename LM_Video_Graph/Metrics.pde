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
int averagingBufferSize = 1000;
int bufferPointer = 0;
int[] machineUtilizationBuffer = new int[averagingBufferSize];
float rollingMachineUtilizationPercentage;

void calculateRollingMachineUtilization()
{
  int i;
  int totalActivity = 0;
  
  machineUtilizationBuffer[bufferPointer] = machineActive ? 1 : 0;
  bufferPointer++;
  if(bufferPointer >= averagingBufferSize) bufferPointer = 0;

  for(i=0;i<averagingBufferSize;i++)
  {
    totalActivity+=machineUtilizationBuffer[i];
  }
  rollingMachineUtilizationPercentage = float(totalActivity) / float(averagingBufferSize);      
}