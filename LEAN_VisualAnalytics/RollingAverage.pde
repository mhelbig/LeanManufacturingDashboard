class RollingAverage
{
  int bufferSize = 60;
  int bufferPointer = 0;
  float totalActivity = 0;
  float[] buffer = new float[bufferSize];
  
  RollingAverage(int size)
  {
    bufferSize = size;
  }
  
  void reset()
  {
    int i;

    for(i=0;i<bufferSize;i++)
    {
      buffer[i] = 0;
    }
    totalActivity = 0;      
  }
  
  void add(float input)
  {
    buffer[bufferPointer] = input;
    bufferPointer++;
    if(bufferPointer >= bufferSize) bufferPointer = 0;
  }    
  
  void calculate()
  {
    int i;
    totalActivity = 0;

    for(i=0;i<bufferSize;i++)
    {
      totalActivity+= buffer[i];
    }
  }
  
  float currentValue()
  {
    return (totalActivity / float(bufferSize));
  }
}