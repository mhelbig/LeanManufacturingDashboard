class SummaryDataTable
{
  Table summaryData;
  String filename;
  
  SummaryDataTable()
  {
  }
  
  void initialize()
  {
    filename ="../MachineData/" + cal.get(Calendar.YEAR) + "-summary.csv";
    
    summaryData = loadTable(filename, "header");
    
    if (summaryData == null)
    {
      summaryData = new Table();
      summaryData.addColumn("day");
      summaryData.addColumn("date");
      summaryData.addColumn("total");
      summaryData.addColumn("active");
      
      save();
    }
  }
  
  int getRowCount()
  {
    return(summaryData.getRowCount());
  }
  
  void addData(int day, int total, int active)
  {
    TableRow row = summaryData.addRow();
    row.setInt("day",   day);
    row.setString("date", year_Month_Day());
    row.setInt("total", total);
    row.setInt("active", active);
  }
  
  void save()
  {
    saveTable(summaryData, filename);
  }
}