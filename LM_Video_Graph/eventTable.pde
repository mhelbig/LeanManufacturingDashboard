Table events;

// Initialize
void initEventTable()
{
  events = new Table();
  events.addColumn("id");
  events.addColumn("time");
  events.addColumn("state");
  addEvent(0,0);              // make sure the first event starts at zero
}

void addEvent(float time, int state)
{
  TableRow newRow = events.addRow();
  newRow.setInt("id", events.lastRowIndex());
  newRow.setFloat("time",time);
  newRow.setInt("state",state);
}

TableRow tableRow;
int id=0;
float actionTime;
void openEventTable()
{
  events = loadTable("data/events.csv", "header");
}

void readMachineActiveStateTable()
{
  int state;
  
  if(playbackTime > actionTime)
  {
    tableRow   = events.getRow(id);         //get the current row
    state      = tableRow.getInt("state");  //get the current state
    tableRow   = events.getRow(id + 1);     //advance to the next row
    id         = tableRow.getInt("id");     //get the new id
    actionTime = tableRow.getFloat("time"); //get the next active time to wait for
    
    if(state == 0) machineActive = false;
    else machineActive = true;
    
//    println(id+"'"+state+","+playbackTime+"'"+actionTime);
  }
}

void closeEventTable()
{
  saveTable(events, "data/events.csv");
}