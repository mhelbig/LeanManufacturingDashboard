Calendar cal = Calendar.getInstance(); 
int newDayFlag;

void initializeTimer()
{
    if(inEmulatorMode)              // set the time and date to a point in the past
    {
      cal.set(Calendar.MILLISECOND, 0); 
      cal.set(Calendar.SECOND, 0); 
      cal.set(Calendar.MINUTE, 0); 
      cal.set(Calendar.HOUR_OF_DAY, 0); 
      cal.set(Calendar.DATE, 1);
      cal.set(Calendar.MONTH, 1);
      cal.set(Calendar.YEAR, 2000);
    }
    else
    {
      cal = Calendar.getInstance();  // synchronize this clock with the current date
    }
    newDayFlag = cal.get(Calendar.DATE); // save the date so we know when it rolls over to a new one
}

boolean intervalTimeExpired()
{
  if(!inEmulatorMode)  // when in emulator mode, don't update the real time, let it advance it as fast as we can with getNextIntervalTime()
  {
    cal = Calendar.getInstance();
  }
  if(intervalTime == cal.get(Calendar.MINUTE))
  {
    getNextIntervalTime();
    return(true);
  }
  else
  {
    return(false);
  }
}  

void getNextIntervalTime()
{
  cal.add(Calendar.MINUTE,1);
  intervalTime = cal.get(Calendar.MINUTE);
  println("Next interval @ " + intervalTime + " minutes");
}

int minuteOfDay()
{
  return(cal.get(Calendar.HOUR_OF_DAY)*60 + cal.get(Calendar.MINUTE));
}

boolean newDay()
{
  if(newDayFlag == cal.get(Calendar.DATE))
  {
    return(false);
  }
  else
  {
    newDayFlag = cal.get(Calendar.DATE);
    return(true);
  }
}