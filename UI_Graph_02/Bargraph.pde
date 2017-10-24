int[] yvals;
int Overhead = 125;
int Profit   = 250;

int arrayindex = 0;
int graphWidth;
int graphHeight = 100;
int graphXoffset = 0;
int graphYoffset = 600;

void displayBarGraph()
{
  for(int i = 1; i < graphWidth; i++) 
  { 
    yvals[i-1] = yvals[i];
  } 
  
  // Add the new values to the end of the array 
  yvals[graphWidth-1] -= Overhead;  // the costs are always applied
  if(machineActive)
  {
    yvals[graphWidth-1] += Profit;  // profit is applied when the machines are running
  }
     
  fill(0,0,0);
  noStroke();

  rect(graphXoffset, graphYoffset, graphWidth, graphHeight);

  // Draw the scrolling bar graph
  for(int i=1; i<graphWidth; i++) 
  {
    if(yvals[i] > 0)
    {
      stroke(0,255,0);
      line(graphXoffset+i,
           graphYoffset+((graphHeight*.5)-yvals[i]/1000),
           graphXoffset+i,
           graphYoffset+(graphHeight/2));
    }
    else
    {
      stroke(255,0,0);
      line(graphXoffset+i,
           graphYoffset+((graphHeight*.5)-yvals[i]/1000),
           graphXoffset+i,
           graphYoffset+(graphHeight/2));
    }
  }
  // Draw the center reference line
  stroke(255);
  line(graphXoffset, 
       graphYoffset+(graphHeight/2),
       graphXoffset+graphWidth,
       graphYoffset+(graphHeight/2));
}