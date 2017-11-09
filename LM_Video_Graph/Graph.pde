class Graph
{
  int GraphXoffset = 0;  //defaults
  int GraphYoffset = 0;
  int graphWidth   = 500;
  int graphHeight  = 150;
  float graphRangeTop = 50;
  float graphRangeBot = -50;
  color barColor = color(255, 255, 255);
  
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
    rect(0-frameWidth, 0-frameWidth, graphWidth + (frameWidth *2), graphHeight + (frameWidth * 2) );
   
    popMatrix();
  }
  
  void drawHorizontalGridLine(float pos)
  {
    pushMatrix();
    translate(GraphXoffset, GraphYoffset);
    strokeWeight(1);
    stroke(127);
    
    line(0,
         map(pos, graphRangeTop, graphRangeBot, 0, graphHeight),
         graphWidth,
         map(pos, graphRangeTop, graphRangeBot, 0, graphHeight));
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
    popMatrix();
  }
}