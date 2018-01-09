class Graph
{
  // Global graph specific appearance attributes:
  color graphGridlineColor          = color(128,128,128);
  int   graphBarTransparency        = 100;
  int   graphGridLineWeight         = 1;
  int   graphVerticalGridlines      = 5;
  float graphTitleTextSize          = 18;
  float graphGridlineTextSize       = 18;
  int   graphRightAxisLabelsMargin  = 65;
  int   graphBottomAxisLabelsMargin = 60;

// Graph overall size
  int graphX;
  int graphY;
  int graphWidth;
  int graphHeight;
  
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
  
  int   lastPositionX = 0;                 // this remembers the last bar's x position
  color barColor = color(255,0,0,127);     // Default.  Note: use transparency to keep the bars from overwriting the gridlines

  Graph()
  {
  }
  
  void initializeGraphFrame(int x, int y, int w, int h, boolean rightAxisLabels, boolean bottomAxisLabels, //size and position
                            float left, float right, float bottom, float top)                                //ranges
  {
    graphX      = x;
    graphY      = y;
    graphWidth  = w;
    graphHeight = h;
    
    graphPlotAreaX      = graphX + leftMargin + frameLineWeight;
    graphPlotAreaY      = graphY + topMargin  + frameLineWeight;
    graphPlotAreaWidth  = graphWidth  - leftMargin - rightMargin  - (frameLineWeight * 2);
    graphPlotAreaHeight = graphHeight - topMargin  - bottomMargin - (frameLineWeight * 2);
    
//adjust plot area if there are Axis Labels:    
    if(rightAxisLabels)
    {
      graphPlotAreaWidth -= graphRightAxisLabelsMargin;
    }
    
    if(bottomAxisLabels)
    {
      graphPlotAreaHeight -= graphBottomAxisLabelsMargin;
    }
    
    graphRangeLeft      = left;
    graphRangeRight     = right;
    graphRangeTop       = top;
    graphRangeBottom    = bottom;
  }
  
  void drawGraphPlotArea()
  {
    lastPositionX = 0;
    
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

  void drawDebugReferenceFrame() // draws a rectangle representing the defined size of the graph area
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
    graphGridlineColor = c;
  }
  
  void adjustGraphVerticalRange(float topMax, float bottomMax)
  {
    float[] graphIncrements = {10, 20, 50, 75, 100, 200, 500, 750, 1000, 2000, 5000};
    float verticalGraphRange = (topMax - bottomMax) * 1.0;
    
    for(float increment : graphIncrements)
    {
      if((increment * graphVerticalGridlines) > verticalGraphRange)
      {
        for(float bottom = 0; bottom > -graphVerticalGridlines; bottom--)
        {
          if(bottom * increment < bottomMax)
          {
            graphRangeBottom = bottom * increment;
            graphRangeTop = graphRangeBottom + (increment * graphVerticalGridlines); 
            break;
          }
        }
        break;
      }
    }
  }
  
  void drawHorizontalGridlines()
  {
    for (float i = graphRangeBottom; i <=graphRangeTop; i = i + ((graphRangeTop - graphRangeBottom) / graphVerticalGridlines))
    {
      if(i >= dashboard.netProfitGreenLimit)  dashboard.netProfitGraph.setGridLineColor(color(0,255,0));
      if(i <= dashboard.netProfitYellowLimit) dashboard.netProfitGraph.setGridLineColor(color(255,255,0));
      if(i <  dashboard.netProfitRedLimit)    dashboard.netProfitGraph.setGridLineColor(color(255,0,0));
      if(i ==  0)                           dashboard.netProfitGraph.setGridLineColor(color(80));
      addGridlineHorizontal(i, "$" + nf(i) );
    }
  }
  
  void addGridlineVertical(float xPos, String text)
  {
    int x = mapAxisX(xPos);
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
    
      if( x > 0 && x < graphPlotAreaWidth)  // draw the gridline only if it's not on the frame
      {
        stroke(graphGridlineColor);
        strokeWeight(graphGridLineWeight);
        
        line(x, 0, x, graphPlotAreaHeight);
      }
      textSize(graphGridlineTextSize);
      fill(graphGridlineColor);
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
        stroke(graphGridlineColor);
        strokeWeight(graphGridLineWeight);
        
        line(0, mapAxisY(yPos), graphPlotAreaWidth, mapAxisY(yPos));
      }
      textSize(graphGridlineTextSize);
      textAlign(LEFT, CENTER);
      fill(graphGridlineColor);
      translate(graphPlotAreaWidth + frameLineWeight + 8, y);
      text(text, 0, 0);
    }
    popMatrix();
  }
  
////////////////////////////////////////////////////////////////////
// title
////////////////////////////////////////////////////////////////////
  void drawTitle(int xPos, int yPos, int alignH, int alignV, String title)
  {
    pushMatrix();
    {
      translate(graphPlotAreaX, graphPlotAreaY);
      textSize(graphTitleTextSize);
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
    barColor = color(c,graphBarTransparency);
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