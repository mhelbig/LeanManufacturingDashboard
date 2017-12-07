Table machineCycles;

// Initialize
void initEventTable()
{
  machineCycles = new Table();
  machineCycles.addColumn("time");
  machineCycles.addColumn("cycles");
  machineCycles.addColumn("state");
}

void addEvent(int time, int cycles, int state)
{
  TableRow newRow = machineCycles.addRow();
  newRow.setInt("time",time);
  newRow.setInt("cycles",cycles);
  newRow.setInt("state",state);
}

void openEventTable()
{
  machineCycles = loadTable("data/events.csv", "header");
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

void closeEventTable()
{
  saveTable(machineCycles, "data/events.csv");
}