class EventDataTable
{
  Table machineCycles;
  String machineCyclesFilename;
  
  EventDataTable()
  {
  }
  
  void initializeEventTable(String machineName)
  {
    machineCyclesFilename ="data/"
    + machineName + "-" 
    + cal.get(Calendar.YEAR) + "-"
    + nf(cal.get(Calendar.MONTH) + 1,2)
    + "-" + nf(cal.get(Calendar.DATE),2)
    + ".csv";
    
    machineCycles = loadTable(machineCyclesFilename, "header");
    
    if (machineCycles == null)
    {
      machineCycles = new Table();
      machineCycles.addColumn("time");
      machineCycles.addColumn("cycles");
      machineCycles.addColumn("active");
      machineCycles.addColumn("state");
      
/*     for (int i=startMinute; i<endMinute; i++)
     {
        TableRow newRow = machineCycles.addRow();
        newRow.setInt("time",i);
        newRow.setInt("cycles",0);
        newRow.setInt("active",0);
        newRow.setInt("state",0);
     } */
      saveEventTable();
    }
  }
  
  int getRowCount()
  {
    return(machineCycles.getRowCount());
  }
  
  void addEventData(int time, int cycles, int active, int state)
  {
    TableRow row = machineCycles.getRow(time);
    row.setInt("cycles",cycles);
    row.setInt("active",active);
    row.setInt("state",state);
  }
  
  void loadWithRandomData()
  {
    int j = 0;
    int s = 0;
    
    machineCycles.clearRows();
    for (int i=startMinute; i<endMinute; i++)
      {
        
        if (j < i)
        {
          j = int(random(i + 10,i + 60));
          s = int(random(0,4));
        }
        addEventData(i,int(random(0,200)),0,s);
      }
      
  }
  
  void saveEventTable()
  {
    saveTable(machineCycles, machineCyclesFilename);
  }
}