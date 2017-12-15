Table machineCycles;
String machineCyclesFilename;

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

void buildEventTableFilename(String machineName)
{
  machineCyclesFilename = "data/" + machineName + "-" + year() + "-" + nf(month(),2) + "-" + nf(day(),2) + ".csv";
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

Table graphData;

void createGraphDataTable()
{
  graphData = new Table();
  graphData.addColumn("time");
  graphData.addColumn("status");
  graphData.addColumn("uptime");
  graphData.addColumn("netprofit");
}

void addGraphData(int time, int status, int uptime, float netprofit)
{
  TableRow newRow = graphData.addRow();
  newRow.setInt("time",time);
  newRow.setInt("status",status);
  newRow.setInt("uptime",uptime);
  newRow.setFloat("netprofit",netprofit);
}

void loadGraphDataTableWithRandomTestData()
{
  for (int minuteOfDay = startMinute; minuteOfDay < endMinute; minuteOfDay ++)
  {
    addGraphData(minuteOfDay, int(random(0,4)), int(random(0, 100)), random(-100, 200));
  }
}