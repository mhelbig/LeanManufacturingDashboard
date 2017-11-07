class Graph
{
  int GraphXoffset = 0;  //defaults
  int GraphYoffset = 0;
  int graphWidth   = 500;
  int graphHeight  = 150;
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
    graphWidth   = w;
    graphHeight  = h;
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
    rect(0, 0, graphWidth, graphHeight);
   
    popMatrix();
  }
  
  void drawBar(float start, float end)
  {
    pushMatrix();
    translate(GraphXoffset, GraphYoffset);
    stroke(barColor);
    strokeWeight(1);
    line(map(playbackTime, 0, videoDuration,0, graphWidth), 
         constrain(map(end, graphRangeTop, graphRangeBot, 0, graphHeight), 0, graphHeight),
         map(playbackTime, 0, videoDuration,0, graphWidth),
         constrain(map(start, graphRangeTop, graphRangeBot,0, graphHeight), 0, graphHeight));
  
    // Draw the center reference line
    stroke(255);
    line(0, graphHeight/2, graphWidth, graphHeight/2);
    
    translate(graphWidth + uiSpacing + 50, graphHeight/2);  // move over to the right edge of the graph across from the center line
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