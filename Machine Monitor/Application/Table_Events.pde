class EventDataTable
{
  Table machineCycles;
  String filename;
  
  EventDataTable()
  {
  }
  
  void initialize()
  {
    filename ="../MachineData/"
    + cal.get(Calendar.YEAR) + "-"
    + nf(cal.get(Calendar.MONTH) + 1,2)
    + "-" + nf(cal.get(Calendar.DATE),2)
    + ".csv";
    
    machineCycles = loadTable(filename, "header");
    
    if (machineCycles == null)
    {
      machineCycles = new Table();
      machineCycles.addColumn("time");
      machineCycles.addColumn("cycles");
      machineCycles.addColumn("active");
      machineCycles.addColumn("state");
      
      for(int i = startMinute; i < endMinute; i++)
      {
        TableRow row = machineCycles.getRow(i);
        row.setInt("time",i);
      }
      save();
    }
  }
  
  int getRowCount()
  {
    return(machineCycles.getRowCount());
  }
  
  void addData(int time, int cycles, int active, int state)
  {
    TableRow row = machineCycles.getRow(time);
    row.setInt("time",   time);
    row.setInt("cycles", cycles);
    row.setInt("active", active);
    row.setInt("state",  state);
  }
  
  void save()
  {
    saveTable(machineCycles, filename);
  }
}