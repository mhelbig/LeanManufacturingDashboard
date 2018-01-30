class SummaryDataTable
{
  Table summaryData;
  String filename;
  
  SummaryDataTable()
  {
  }
  
  void initialize()
  {
    filename ="../MachineData/Summary,"
    + cal.get(Calendar.YEAR) + ".csv";
    
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
    row.setString("date", nf(cal.get(Calendar.MONTH)+1,2) + "-" +
                          nf(cal.get(Calendar.DATE),2) + "-" +
                          nf(cal.get(Calendar.YEAR),4));
    row.setInt("total", total);
    row.setInt("active", active);
  }
  
  void save()
  {
    saveTable(summaryData, filename);
  }
}