class EventData
{
  Table machineCycles;
  String machineCyclesFilename;
  
  int startMinute             = 0;
  int endMinute               = 24 * 60;

  EventData(String machineName)
  {
    machineCyclesFilename = "data/" + machineName + "-" + year() + "-" + nf(month(),2) + "-" + nf(day(),2) + ".csv";
  }
  
  void addEventData(int time, int cycles, int state)
  {
    TableRow newRow = machineCycles.addRow();
    newRow.setInt("time",time);
    newRow.setInt("cycles",cycles);
    newRow.setInt("state",state);
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
          j = int(random(i + 4,i + 40));
          s = int(random(0,4));
        }
        addEventData(i,int(random(0,200)),s);
      }
      
  }
  
  int cycles(int id)
  {
    TableRow tableRow = machineCycles.getRow(id);
    return(tableRow.getInt("cycles"));
  }
  
  int state(int id)
  {
    TableRow tableRow = machineCycles.getRow(id);
    return(tableRow.getInt("state"));
  }
  
  void openEventTable()
  {
    machineCycles = loadTable(machineCyclesFilename, "header");
    if (machineCycles == null)
    {
      createEventTableFile();
    }
  }
  
  void createEventTableFile()
  {
    machineCycles = new Table();
    machineCycles.addColumn("time");
    machineCycles.addColumn("cycles");
    machineCycles.addColumn("state");
    saveEventTable();
  }
  
  void saveEventTable()
  {
    saveTable(machineCycles, machineCyclesFilename);
  }
}