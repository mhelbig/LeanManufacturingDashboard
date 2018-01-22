class Readout
{
  // Global readout specific appearance attributes:
  float readoutTitleTextSize          = 18;

  // Graph overall size
  int readoutX;
  int readoutY;
  int readoutWidth;
  int readoutHeight;
  
  int readoutPlotAreaX;
  int readoutPlotAreaY;
  int readoutPlotAreaWidth;
  int readoutPlotAreaHeight;
  
  String readoutTitle;
  
  Readout()
  {  //we can't put functions like stroke() in the constructor because the graphic environment isn't setup yet
  }  //that's why there's a separate initialize method instead of using the constructor
  
  void initialize(String title, int x, int y, int w, int h)
  {
    readoutTitle = title;  //print("title=" + title);
    readoutX      = x;     //print(" x=" + x);
    readoutY      = y;     //print(" y=" + y);
    readoutWidth  = w;     //print(" w=" + w);
    readoutHeight = h;     //println(" h=" + h);
    
    readoutPlotAreaX      = readoutX + leftMargin + frameLineWeight;
    readoutPlotAreaY      = readoutY + topMargin  + frameLineWeight;
    readoutPlotAreaWidth  = readoutWidth  - leftMargin - rightMargin  - (frameLineWeight * 2);
    readoutPlotAreaHeight = readoutHeight - topMargin  - bottomMargin - (frameLineWeight * 2);
    
  }

  void drawReadout(String t)
  {
    stroke(frameColor);
    fill(backgroundColor);
    strokeWeight(frameLineWeight);
    pushMatrix();
    {
      translate(readoutPlotAreaX, readoutPlotAreaY);
      rect(0 - (frameLineWeight/2), 0 - (frameLineWeight/2), readoutPlotAreaWidth  + frameLineWeight, readoutPlotAreaHeight + frameLineWeight);
      textSize(readoutTitleTextSize);
      textAlign(CENTER, CENTER);
      fill(textColor);
      text(t, readoutPlotAreaWidth/2, readoutPlotAreaHeight/2);
    }     
    popMatrix();
  }
}