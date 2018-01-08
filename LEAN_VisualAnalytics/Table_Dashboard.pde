class DashboardTable
{
  Table dashboardData;
  int lastGraphedDataPoint = 0;

  DashboardTable()
  {
    // create the dashboard data table
    dashboardData = new Table();
    dashboardData.addColumn("time");
    dashboardData.addColumn("state");
    dashboardData.addColumn("uptime");
    dashboardData.addColumn("netprofit");
  }

  void setDashboardData(int time, int state, int uptime, float netProfit)
  {
    lastGraphedDataPoint = time;
    
    TableRow row = dashboardData.getRow(time);
    row.setInt("time",time);
    row.setInt("state",state);
    row.setInt("uptime",uptime);
    row.setFloat("netprofit",netProfit);
  }

  void resetData()
  {
    dashboardData.clearRows();
    lastGraphedDataPoint = 0;
  }
  
  int getRowCount()
  {
    return(dashboardData.getRowCount());
  }
  
  int getLastGraphedDataPoint()
  {
    return(lastGraphedDataPoint);
  }
}