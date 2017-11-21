class Graph
{
// Graph size and postion:
  int graphPositionX;
  int graphPositionY;
  int graphWidth;
  int graphHeight;
  
// Graph range:  
  float graphRangeLeft;
  float graphRangeRight;
  float graphRangeTop;
  float graphRangeBottom;
  
// Graph attributes:
  color textColor        = color(255,255,255);   // all text on the graph is the same color
  color gridlineColor    = color(128,128,128);
  int   frameLineWeight  = 4;
  int   gridLineWeight   = 1;
  float gridlineTextSize;                    // as a percentage of the graph height

//Bar attributes:
  color barColor       = color(255,0,0,127);     // use transparency to keep the bars from overwriting the gridlines

  Graph()
  {
  }
  
  void initialize(int x, int y, int w, int h,                       //size and position
                  float xMin, float xMax, float yMin, float yMax,   //ranges
                  color background, color tColor,                   //graph area attributes
                  color fColor, int fLineWeight)                    //frame attributes
  {
    graphPositionX          = x;  //Note: size refers to the graphing portion, the frame, title, and axis text is drawn outside this area
    graphPositionY          = y;
    graphWidth              = w;
    graphHeight             = h;
    graphRangeLeft          = xMin;
    graphRangeRight         = xMax;
    graphRangeTop           = yMax;
    graphRangeBottom        = yMin;
    textColor               = tColor;
    frameLineWeight         = fLineWeight;
    
    println(graphPositionY,graphHeight);
    
    pushMatrix();
    {
      translate(graphPositionX, graphPositionY);
    
      // Chart frame:
      fill(0);
      stroke(fColor);
      fill(background);
      strokeWeight(fLineWeight);
      rect(0 - (fLineWeight/2), 0 - (fLineWeight/2), graphWidth  + fLineWeight, graphHeight + fLineWeight);
    }     
    popMatrix();
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
      translate(graphPositionX, graphPositionY);
    
      if( x > 0 && x < graphWidth)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(x, 0, x, graphHeight);
      }
      textSize(gridlineTextSize);
      fill(gridlineColor);
      translate(x, graphHeight  + frameLineWeight + 4);
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
      translate(graphPositionX, graphPositionY);
    
      if( y > 0 && y < graphHeight)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(0, mapAxisY(yPos), graphWidth, mapAxisY(yPos));
      }
      textSize(gridlineTextSize);
      textAlign(LEFT, CENTER);
      fill(gridlineColor);
      translate(graphWidth + frameLineWeight + 2, y);
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
      translate(graphPositionX, graphPositionY);
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
    pushMatrix();
    {
      translate(graphPositionX, graphPositionY);
      stroke(barColor);
      strokeWeight(1);
      line(mapAxisX(xPos), mapAxisY(yEnd), mapAxisX(xPos), mapAxisY(yStart)); 
    }
    popMatrix();
  }
  
////////////////////////////////////////////////////////////////////
// X and Y axis mapping conversions
////////////////////////////////////////////////////////////////////
  int mapAxisX(float value)
  {
    return int(constrain(map(value, graphRangeLeft, graphRangeRight, 0, graphWidth),0, graphWidth));
  }

  int mapAxisY(float value)
  {
    return int(constrain(map(value, graphRangeTop, graphRangeBottom, 0, graphHeight),0, graphHeight));
  }
}