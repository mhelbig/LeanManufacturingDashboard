Table events;

void initEventTable()
{
  events = new Table();
  events.addColumn("id");
  events.addColumn("time");
  events.addColumn("state");
}

void addEvent(float time, int state)
{
  TableRow newRow = events.addRow();
  newRow.setInt("id", events.lastRowIndex());
  newRow.setFloat("time",time);
  newRow.setInt("state",state);
}

void saveEvents()
{
 saveTable(events, "data/events.csv");
}