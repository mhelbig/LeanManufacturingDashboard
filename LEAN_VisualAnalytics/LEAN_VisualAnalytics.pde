void setup() 
{
  size(1024,768);
  background(0);
  Graph test = new Graph();
  
  test.initialize(10,30,720,240,
                  0,100,0,200,
                  color(50), color(255), 25, "First",
                  color(255), 6);
  test.setGridTextSize(18);                  
                  
  test.setGridLineColor(color(255,0,0));
  test.addGridlineX(0,   "0");
  test.addGridlineX(25,  "25");
  test.addGridlineX(50,  "50");
  test.addGridlineX(75,  "75");
  test.addGridlineX(100, "100");

  test.setGridLineColor(color(0,255,0));
  test.addGridlineY(0,   "0");
  test.addGridlineY(50,  "50");
  test.addGridlineY(100, "100");
  test.addGridlineY(150, "150");
  test.addGridlineY(200, "200");
  
  Graph second = new Graph();
  
  second.initialize(10,30,720,140,
                  0,100,0,200,
                  color(50), color(255), 25, "Second",
                  color(255), 6);
  second.setGridTextSize(18);                  
                  
  second.setGridLineColor(color(255,0,0));
  second.addGridlineX(0,   "0");
  second.addGridlineX(25,  "25");
  second.addGridlineX(50,  "50");
  second.addGridlineX(75,  "75");
  second.addGridlineX(100, "100");

  second.setGridLineColor(color(0,255,0));
  second.addGridlineY(0,   "0");
  second.addGridlineY(50,  "50");
  second.addGridlineY(100, "100");
  second.addGridlineY(150, "150");
  second.addGridlineY(200, "200");

}

void draw()
{
}