class Graph
{
// Graph size and postion:
  int graphPositionLeft;
  int graphPositionTop;
  int graphPositionRight;
  int graphPositionBottom;
  
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
  
  void initialize(int x, int y, int w, int h,                                      //size and position
                  float xMin, float xMax, float yMin, float yMax,                  //ranges
                  color background, color tColor,  float tTextSize, String title,  //graph area attributes
                  color fColor, int fLineWeight)                                   //frame attributes
  {
    graphPositionLeft       = x;  //Note: size refers to the graphing portion, the frame, title, and axis text is drawn outside this area
    graphPositionTop        = y;
    graphPositionRight      = graphPositionLeft + w;
    graphPositionBottom     = graphPositionTop + h;
    graphRangeLeft          = xMin;
    graphRangeRight         = xMax;
    graphRangeTop           = yMax;
    graphRangeBottom        = yMin;
    textColor               = tColor;
    frameLineWeight         = fLineWeight;
    
    pushMatrix();
    {
      translate(graphPositionLeft, graphPositionTop);
    
      fill(0);
      stroke(fColor);
      fill(background);
      strokeWeight(fLineWeight);
      rectMode(CORNERS);
      rect(graphPositionLeft - (fLineWeight/2), graphPositionTop - (fLineWeight/2), graphPositionRight  + (fLineWeight/2), graphPositionBottom + (fLineWeight/2));
      rectMode(CORNER);

      textSize(tTextSize);
      textAlign(CENTER, BOTTOM);
      fill(textColor);
      translate( (graphPositionLeft + graphPositionRight) /2 , graphPositionTop - frameLineWeight - 4);
      text(title, 0, 0);
      
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
  
  void addGridlineX(float xPos, String text)
  {
    int x = mapAxisX(xPos);
    pushMatrix();
    {
      translate(graphPositionLeft, graphPositionTop);
    
      if( x > graphPositionLeft && x < graphPositionRight)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(x, graphPositionTop, x, graphPositionBottom);
      }
      textSize(gridlineTextSize);
      fill(textColor);
      translate(x, graphPositionBottom  + frameLineWeight + 4);
      rotate(-PI/2);
      textAlign(RIGHT, CENTER);
      text(text, 0, 0);
    }
    popMatrix();
  }
  
  void addGridlineY(float yPos, String text)
  {
    int y = mapAxisY(yPos);
    pushMatrix();
    {
      translate(graphPositionLeft, graphPositionTop);
    
      if( y > graphPositionTop && y < graphPositionBottom)  // draw the gridline only if it's not on the frame
      {
        stroke(gridlineColor);
        strokeWeight(gridLineWeight);
        
        line(graphPositionLeft, mapAxisY(yPos), graphPositionRight, mapAxisY(yPos));
      }
      textSize(gridlineTextSize);
      textAlign(LEFT, CENTER);
      fill(textColor);
      translate(graphPositionRight + frameLineWeight + 2, y);
      text(text, 0, 0);
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
    translate(graphPositionLeft, graphPositionTop);
    stroke(barColor);
    strokeWeight(1);
    line(map(xPos, graphRangeTop, graphRangeBottom,0, graphPositionRight), 
         constrain(map(yEnd, graphRangeRight, graphRangeLeft, 0, graphPositionBottom), 0, graphPositionBottom),
         map(xPos, graphRangeTop, graphRangeBottom,0, graphPositionRight),
         constrain(map(yStart, graphRangeRight, graphRangeLeft,0, graphPositionBottom), 0, graphPositionBottom));
    popMatrix();
  }
  
////////////////////////////////////////////////////////////////////
// X and Y axis mapping conversions
////////////////////////////////////////////////////////////////////
  int mapAxisX(float value)
  {
    return int(constrain(map(value, graphRangeLeft, graphRangeRight, graphPositionLeft, graphPositionRight),graphPositionLeft, graphPositionRight));
  }

  int mapAxisY(float value)
  {
    return int(constrain(map(value, graphRangeTop, graphRangeBottom, graphPositionTop, graphPositionBottom),graphPositionTop, graphPositionBottom));
  }
}