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