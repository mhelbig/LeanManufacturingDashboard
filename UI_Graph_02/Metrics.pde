float netProfit = 0;

void calculateNetProfit()
{
  if(machineActive)
  {
    netProfit += revenueRatePerFrame;
  }
  netProfit -= overheadRatePerFrame;
}