import java.util.*; 

// see https://docs.oracle.com/javase/6/docs/api/java/util/Calendar.html for details

Calendar cal = Calendar.getInstance(); 

void setup()
{
/*  cal.set(Calendar.MILLISECOND, 0); 
  cal.set(Calendar.SECOND, 2); 
  cal.set(Calendar.MINUTE, 0); 
  cal.set(Calendar.HOUR, 0); 
  cal.set(Calendar.DATE, 11);
  cal.set(Calendar.MONTH, 0);
  cal.set(Calendar.YEAR, 2017);
*/

//  cal.setTime(Date date);
  long unixTime = cal.getTimeInMillis();      // milliseconds to seconds
  println(unixTime);
  
  println(cal.getTime());
  
  int v = cal.get(Calendar.DAY_OF_YEAR);
  println(v);
}

void draw()
{
  cal = Calendar.getInstance();
  println(cal.getTime());
}