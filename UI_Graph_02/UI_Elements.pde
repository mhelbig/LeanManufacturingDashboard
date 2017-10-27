int arrayindex = 0;
int graphXoffset = 0;
int graphYoffset = 600;
int graphWidth = videoWidth;
int graphHeight = 100;
float graphRangeInDollars = 1;
float [] barGraphArray = new float[videoWidth];

void displayBarGraph()
{
  strokeWeight(1);
  for(int i = 1; i < graphWidth; i++)      // shift all the values left 
  { 
    barGraphArray[i-1] = barGraphArray[i];
  } 
  barGraphArray[graphWidth-1] = netProfit; // Add the new values to the end
  if (barGraphArray[graphWidth-1] > graphRangeInDollars)    graphRangeInDollars++;
  if (barGraphArray[graphWidth-1] < (-graphRangeInDollars)) graphRangeInDollars++;
     
//  print(graphRangeInDollars, ",");
  
  translate(graphXoffset, graphYoffset);
  pushMatrix();
  
  fill(0,0,0);
  noStroke();
  rect(0, 0, graphWidth, graphHeight);

  for(int i=1; i<graphWidth; i++)  // Draw the scrolling bar graph 
  {
    if(barGraphArray[i] > 0) // We're profitable, show in green
    {
      stroke(0,255,0);
    }
    else
    {
      stroke(255,0,0); // We're losing money, show in red
    }
    line(i, map(barGraphArray[i],graphRangeInDollars,-graphRangeInDollars,0,graphHeight), i, graphHeight/2);
    
  }
  // Draw the center reference line
  stroke(255);
  line(0, graphHeight/2, graphWidth, graphHeight/2);
  
  popMatrix();
}

int machineStateIndicatorX = 30;
int machineStateIndicatorY = videoHeight-65;
int machiineStateIndicatorR = 30;
void displayActivityState()
{
  strokeWeight(progressBarStroke);
  if(machineActive) fill(0,255,0,100);
  else              fill(255,0,0,100);
  ellipse(machineStateIndicatorX,machineStateIndicatorY,machiineStateIndicatorR,machiineStateIndicatorR);
}

void displayFramerate()
{
    fill(255);
    rect(10,10,25,20,10);
    fill(0);
    text(round(frameRate),15,25);
}

void displayProfit()
{
    fill(255);
    rect(10,40,70,20);
    fill(0);
    text(netProfit,15,55);
}