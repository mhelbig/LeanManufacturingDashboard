class Graph
{
// Graph overall size
  int graphX;
  int graphY;
  int graphWidth;
  int graphHeight;
  
  int graphLeftMargin;
  int graphRightMargin;
  int graphTopMargin;
  int graphBottomMargin;
  
// Graph data range in units:  
  float graphRangeLeft;
  float graphRangeRight;
  float graphRangeTop;
  float graphRangeBottom;
  
// Calculated graph size and position in pixels:
  int graphPlotAreaX;
  int graphPlotAreaY;
  int graphPlotAreaWidth;
  int graphPlotAreaHeight;
  
// Graph appearance attributes:
  color textColor        = color(255,255,255);   // all text on the graph is the same color
  color gridlineColor    = color(128,128,128);
  int   frameLineWeight  = 4;
  int   gridLineWeight   = 1;
  float gridlineTextSize;
  int   lastPositionX = 0;                   // this remembers the last bar's x position
  color frameColor;
  color backgroundColor;
  color barColor = color(255,0,0,127);     // Default.  Note: use transparency to keep the bars from overwriting the gridlines

  Graph(int x, int y, int w, int h,                       //size and position
        int marL,int marR, int marT, int marB,            //margins
        float xMin, float xMax, float yMin, float yMax,   //ranges
        color background, color tColor,                   //graph area attributes
        color fColor, int fLineWeight)                    //frame attributes
  {
    graphX      = x + fLineWeight/2;
    graphY      = y + fLineWeight/2;
    graphWidth  = w - fLineWeight/2;
    graphHeight = h - fLineWeight/2;
    
    graphLeftMargin     = marL;
    graphRightMargin    = marR;
    graphTopMargin      = marT;
    graphBottomMargin   = marB;
    
    graphPlotAreaX      = graphX + marL + fLineWeight;
    graphPlotAreaY      = graphY + marT + fLineWeight;
    graphPlotAreaWidth  = graphWidth - marL - marR - fLineWeight * 2;
    graphPlotAreaHeight = graphHeight - marT - marB - fLineWeight * 2;
    
    graphRangeLeft      = xMin;
    graphRangeRight     = xMax;
    graphRangeTop       = yMax;
    graphRangeBottom    = yMin;
    
    textColor           = tColor;
    frameLineWeight     = fLineWeight;
    frameColor          = fColor;
    backgroundColor     = background;
    frameLineWeight     = fLineWeight;
  }
  
  void initializeGraphFrame()
  {
    stroke(frameColor);
    fill(backgroundColor);
    strokeWeight(frameLineWeight);
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
      rect(0 - (frameLineWeight/2), 0 - (frameLineWeight/2), graphPlotAreaWidth  + frameLineWeight, graphPlotAreaHeight + frameLineWeight);
    }     
    popMatrix();
  }

  void drawReferenceFrame() // draws a rectangle representing the defined size of the graph area
  {
    stroke(frameColor);
    noFill();
    strokeWeight(1);
    rect(graphX, graphY, graphWidth, graphHeight);  //reference frame
  }

////////////////////////////////////////////////////////////////////
// Gridlines:  
////////////////////////////////////////////////////////////////////
void setGridLineColor(color c)
  {
    gridlineColor = c;
  }
  
  void setGridLineWeight(int w)
  {
    gridLineWeight = w;
  }
  
  void setGridTextSize(float s)
  {
    gridlineTextSize = s;
  }
  
  void addGridlineVertical(float xPos, String text)
  {
    int x = mapAxisX(xPos);
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
    
      if( x > 0 && x < graphPlotAreaWidth)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(x, 0, x, graphPlotAreaHeight);
      }
      textSize(gridlineTextSize);
      fill(gridlineColor);
      translate(x, graphPlotAreaHeight  + frameLineWeight + 8);
      rotate(-PI/2);
      textAlign(RIGHT, CENTER);
      text(text, 0, 0);
    }
    popMatrix();
  }
  
  void addGridlineHorizontal(float yPos, String text)
  {
    int y = mapAxisY(yPos);
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
    
      if( y > 0 && y < graphPlotAreaHeight)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(0, mapAxisY(yPos), graphPlotAreaWidth, mapAxisY(yPos));
      }
      textSize(gridlineTextSize);
      textAlign(LEFT, CENTER);
      fill(gridlineColor);
      translate(graphPlotAreaWidth + frameLineWeight + 8, y);
      text(text, 0, 0);
    }
    popMatrix();
  }
  
////////////////////////////////////////////////////////////////////
// title
////////////////////////////////////////////////////////////////////
  void drawTitle(int xPos, int yPos, int alignH, int alignV, float size, String title)
  {
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
      textSize(size);
      textAlign(alignH, alignV);
      fill(textColor);
      text(title, xPos, yPos);
    }
    popMatrix();
  }
  
////////////////////////////////////////////////////////////////////
// Bars
////////////////////////////////////////////////////////////////////
  void setBarColor(color c)
  {
    barColor = c;
  }
  
  void drawBar(float xPos, float yStart, float yEnd)
  {
    int currentPositionX = mapAxisX(xPos);  
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
      stroke(barColor);
      strokeWeight(1);
      
      while(lastPositionX < currentPositionX)
      {
        lastPositionX++;
        line(lastPositionX, mapAxisY(yEnd), lastPositionX, mapAxisY(yStart)); 
      }
    }
    popMatrix();
  }
////////////////////////////////////////////////////////////////////
// Graph position reporting
////////////////////////////////////////////////////////////////////
int graphPositionLeft()
{
  return(graphX);
}

int graphPositionRight()
{
  return(graphX + graphWidth);
}  
  
int graphPositionTop()
{
  return(graphY);
}

int graphPositionBottom()
{
  return(graphY + graphHeight);
}

////////////////////////////////////////////////////////////////////
// X and Y axis mapping conversions
////////////////////////////////////////////////////////////////////
  int mapAxisX(float value)
  {
    return int(constrain(map(value, graphRangeLeft, graphRangeRight, 0, graphPlotAreaWidth),0, graphPlotAreaWidth));
  }

  int mapAxisY(float value)
  {
    return int(constrain(map(value, graphRangeTop, graphRangeBottom, 0, graphPlotAreaHeight),0, graphPlotAreaHeight));
  }
}