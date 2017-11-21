void setup() 
{
  size(1024,768);
  background(0);
  Graph test = new Graph();
  
  test.initialize(10,10,720,240,
                  0,100,-50,200,
                  color(50), color(255),
                  color(255), 6);
  test.setGridTextSize(18);                  
                  
  test.setGridLineColor(color(80));
  test.addGridlineVertical(0,   "");
  test.addGridlineVertical(25,  "");
  test.addGridlineVertical(50,  "");
  test.addGridlineVertical(75,  "");
  test.addGridlineVertical(100, "");

  test.setGridLineColor(color(80));
  test.addGridlineHorizontal(-50,   "-50");
  test.addGridlineHorizontal(0,   "0");
  test.addGridlineHorizontal(50,  "50");
  test.addGridlineHorizontal(100, "100");
  test.addGridlineHorizontal(150, "150");
  test.addGridlineHorizontal(200, "200");
  test.drawTitle(10,6,25, "Machine Uptime");
 
  Graph second = new Graph();
  
  second.initialize(10,265,720,140,
                  0,100,-200,200,
                  color(50), color(255),
                  color(255), 6);
  second.setGridTextSize(18);                  
                  
  second.setGridLineColor(color(80));
  second.addGridlineVertical(0,   "0");
  second.addGridlineVertical(25,  "25");
  second.addGridlineVertical(50,  "50");
  second.addGridlineVertical(75,  "75");
  second.addGridlineVertical(100, "100");

  second.setGridLineColor(color(80));
  second.addGridlineHorizontal(-200,   "$-200");
  second.addGridlineHorizontal(-100,  "$-100");
  second.addGridlineHorizontal(0, "$   0");
  second.addGridlineHorizontal(100, "$ 100");
  second.addGridlineHorizontal(200, "$ 200");
  second.drawTitle(10,6,25, "Net Profit");
}

void draw()
{
}