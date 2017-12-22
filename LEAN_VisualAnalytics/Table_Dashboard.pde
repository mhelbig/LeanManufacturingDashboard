class DashboardTable
{
  Table dashboardData;

  DashboardTable()
  {
    // create the dashboard data table
    dashboardData = new Table();
    dashboardData.addColumn("time");
    dashboardData.addColumn("status");
    dashboardData.addColumn("uptime");
    dashboardData.addColumn("netprofit");
    
    // initialize it with zeros
    for (int i = startMinute; i < endMinute; i++)
    {
      TableRow newRow = dashboardData.addRow();
      newRow.setInt("time",0);
      newRow.setInt("status",0);
      newRow.setInt("uptime",0);
      newRow.setFloat("netprofit",0.0);
    }
  }

  void addDashboardData(int time, int status, int uptime, float netProfit)
  {
    TableRow newRow = dashboardData.addRow();
    newRow.setInt("time",time);
    newRow.setInt("status",status);
    newRow.setInt("uptime",uptime);
    newRow.setFloat("netprofit",netProfit);
  }

  void loadWithRandomData()
  {
    for (int minuteOfDay = startMinute; minuteOfDay < endMinute; minuteOfDay ++)
    {
      TableRow row = dashboardData.getRow(minuteOfDay);
      row.setInt("time",minuteOfDay);
      row.setInt("status",int(random(0,4)));
      row.setInt("uptime",int(random(0, 100)));
      row.setFloat("netprofit",random(-100, 200));
    }
  }
}