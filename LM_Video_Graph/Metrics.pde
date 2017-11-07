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
float totalShopFloorFrames;
float totalMachineUtilizationFrames;
float machineUtilizationPercentage;

void calculateMachineUtilizationPercentage()
{
  totalShopFloorFrames ++;
  if(machineActive)
  {
    totalMachineUtilizationFrames ++;
  }
  machineUtilizationPercentage = totalMachineUtilizationFrames / totalShopFloorFrames;      
}