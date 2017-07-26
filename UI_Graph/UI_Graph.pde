/*
* Real-time graph of shop floor profit based on machine active time
*/
 
int[] yvals;
int Overhead = 50;
int Profit   = 175;

void setup() 
{
  size(640, 100);
  //noSmooth();
  yvals = new int[width];
}

int arrayindex = 0;

void draw()
{
  background(0);
  
  for(int i = 1; i < width; i++) 
  { 
    yvals[i-1] = yvals[i];
  } 
  
  // Add the new values to the end of the array 
  yvals[width-1] -= Overhead;  // the costs are always applied
  if(mousePressed)
  {
    yvals[width-1] += Profit;  // profit is applied when the machines are running
  }
     
  fill(0,0,0);
  noStroke();

  rect(0, height, width, height);

  for(int i=1; i<width; i++) 
  {
    if(yvals[i] > 0)
    {
      stroke(0,255,0);
      line(i, ((height*.5)-yvals[i]/1000), i, height/2);
    }
    else
    {
      stroke(255,0,0);
      line(i, ((height*.5)-yvals[i]/1000), i, height/2);
    }
  }
  stroke(255);
  line(0, height/2, width, height/2);
  
}