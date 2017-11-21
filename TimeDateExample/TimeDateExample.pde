import java.util.*; 

// see https://docs.oracle.com/javase/6/docs/api/java/util/Calendar.html for details

Calendar cal = Calendar.getInstance(); 

void setup()
{
  cal.set(Calendar.SECOND, 0); 
  cal.set(Calendar.MINUTE, 0); 
  cal.set(Calendar.HOUR, 0); 
  cal.set(Calendar.DATE, 1);
  cal.set(Calendar.MONTH, 6);
  cal.set(Calendar.YEAR, 2017);
  long unixTime = cal.getTimeInMillis();      // milliseconds to seconds
  println(unixTime);
  
  int week = cal.get(Calendar.WEEK_OF_YEAR);
  println(week);
}

void draw()
{
}