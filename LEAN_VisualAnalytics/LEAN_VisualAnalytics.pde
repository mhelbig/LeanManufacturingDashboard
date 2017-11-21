void setup() 
{
  size(1024,768);
  background(0);
  Graph test = new Graph();
  
  test.initialize(10,40,720,240,
                  0,100,0,200,
                  color(50), color(255), 25, "First",
                  color(255), 6);
  test.setGridTextSize(18);                  
                  
  test.setGridLineColor(color(255,0,0));
  test.addGridlineVertical(0,   "0");
  test.addGridlineVertical(25,  "25");
  test.addGridlineVertical(50,  "50");
  test.addGridlineVertical(75,  "75");
  test.addGridlineVertical(100, "100");

  test.setGridLineColor(color(0,255,0));
  test.addGridlineHorizontal(0,   "0");
  test.addGridlineHorizontal(50,  "50");
  test.addGridlineHorizontal(100, "100");
  test.addGridlineHorizontal(150, "150");
  test.addGridlineHorizontal(200, "200");
 
  Graph second = new Graph();
  
  second.initialize(10,350,720,140,
                  0,100,0,200,
                  color(50), color(255), 25, "Second",
                  color(255), 6);
  second.setGridTextSize(18);                  
                  
  second.setGridLineColor(color(255,0,0));
  second.addGridlineVertical(0,   "0");
  second.addGridlineVertical(25,  "25");
  second.addGridlineVertical(50,  "50");
  second.addGridlineVertical(75,  "75");
  second.addGridlineVertical(100, "100");

  second.setGridLineColor(color(0,255,0));
  second.addGridlineHorizontal(0,   "0");
  second.addGridlineHorizontal(50,  "50");
  second.addGridlineHorizontal(100, "100");
  second.addGridlineHorizontal(150, "150");
  second.addGridlineHorizontal(200, "200");
}

void draw()
{
}