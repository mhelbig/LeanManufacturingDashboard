class Graph
{
  int GraphXoffset = 0;  //defaults
  int GraphYoffset = 0;
  int GraphWidth   = 500;
  int GraphHeight  = 150;
  float graphRangeTop = 50;
  float graphRangeBot = -50;
  color barColor = color(255, 255, 255);
  
  int profitReadoutWidth = 70;
  
  Graph()
  {
  }
  
  void setPosition(int x, int y, int w, int h)
  {
    GraphXoffset = x;
    GraphYoffset = y;
    GraphWidth   = w;
    GraphHeight  = h;
  }
  
  void setRange(float t, float b)
  {
    graphRangeTop = t;
    graphRangeBot = b;
  }
  
  void setBarColor(color c)
  {
    barColor = c;
  }
  
  void drawFrame()
  {
    pushMatrix();
    translate(GraphXoffset, GraphYoffset);
  
    fill(0);
    stroke(255,255,255);
    strokeWeight(frameWidth);
    rect(0, 0, GraphWidth, GraphHeight);
   
    popMatrix();
  }
  
  void drawBar()
  {
    pushMatrix();
    translate(GraphXoffset, GraphYoffset);
    stroke(barColor);
    strokeWeight(1);
    line(map(playbackTime, 0, videoDuration,0, GraphWidth), 
         constrain(map(netProfit,graphRangeTop,graphRangeBot,0,GraphHeight), 0, GraphHeight),
         map(playbackTime, 0, videoDuration,0, GraphWidth),
         GraphHeight/2);
  
    // Draw the center reference line
    stroke(255);
    line(0, GraphHeight/2, GraphWidth, GraphHeight/2);
    
    translate(GraphWidth + uiSpacing + 50, GraphHeight/2);  // move over to the right edge of the graph across from the center line
    fill(0);
    stroke(255,255,255);
    rectMode(CENTER);
    rect(0,0,profitReadoutWidth,20);
    rectMode(CORNER);
    
    if(netProfit > 0 ) fill(0,255,0);  // green bar
    else               fill(255,0,0);  // red bar
    textAlign(CENTER, CENTER);
    text( "$" + nf(netProfit, 4, 2), 0, 0);
  
    popMatrix();
  }
}