class EventData
{
  Table machineCycles;
  String machineCyclesFilename;
  
  EventData(String machineName)
  {
    machineCyclesFilename = "data/" + machineName + "-" + year() + "-" + nf(month(),2) + "-" + nf(day(),2) + ".csv";
  }
  
  void addEventData(String time, int cycles, int state)
  {
    TableRow newRow = machineCycles.addRow();
    newRow.setString("time",time);
    newRow.setInt("cycles",cycles);
    newRow.setInt("state",state);
  }
  
  void readMachineActiveStateTable(int id)
  {
    TableRow tableRow;
    int cycles;
    
      tableRow   = machineCycles.getRow(id);       //get the current row
      cycles     = tableRow.getInt("state");       //get number of cycles for given time period
      
  //    if(cycles > 60 ) machineActive = false;
  //    else machineActive = true;
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