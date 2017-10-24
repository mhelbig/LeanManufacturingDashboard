int[] netProfit;
int Overhead = 500;
int Profit   = 1000;

int arrayindex = 0;
int graphWidth = 800;
int graphHeight = 100;
int graphXoffset = 0;
int graphYoffset = 600;
  
// Refactor these UI elements to use pushmatrix, translate, popmatrix for positioning

void displayBarGraph()
{

  for(int i = 1; i < graphWidth; i++) 
  { 
    netProfit[i-1] = netProfit[i];
  } 
  
  // Add the new values to the end of the array 
  netProfit[graphWidth-1] -= Overhead;  // the costs are always applied
  if(machineActive)
  {
    netProfit[graphWidth-1] += Profit;  // profit is applied when the machines are running
  }
     
  fill(0,0,0);
  noStroke();

  rect(graphXoffset, graphYoffset, graphWidth, graphHeight);

  // Draw the scrolling bar graph
  for(int i=1; i<graphWidth; i++) 
  {
    if(netProfit[i] > 0)  // We're profitable, show in green
    {
      stroke(0,255,0);
      line(graphXoffset+i,
           graphYoffset+max(((graphHeight*.5)-netProfit[i]/1000),graphHeight/2),
           graphXoffset+i,
           graphYoffset+(graphHeight/2));
    }
    else
    {
      stroke(255,0,0); // We're losing money, show in red
      line(graphXoffset+i,
           graphYoffset+min(((graphHeight*.5)-netProfit[i]/1000),(graphHeight/2)*-1),
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

int machineStateIndicatorX = 20;
int machineStateIndicatorY = 100;
void displayMachineState()
{
  if(machineActive)
  {
    fill(0,255,0);
    ellipse(machineStateIndicatorX,machineStateIndicatorY,20,20);
  }
  else
  {
    fill(255,0,0);
    ellipse(machineStateIndicatorX,machineStateIndicatorY,20,20);
  }
}

void displayFramerate()
{
    fill(255);
    rect(10,10,25,20);
    fill(0);
    text(round(frameRate),15,25);
}

void displayProfit()
{
    fill(255);
    rect(10,40,70,20);
    fill(0);
    text(netProfit[graphWidth-1],15,55);
}