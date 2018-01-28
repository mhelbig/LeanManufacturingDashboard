Calendar cal = Calendar.getInstance(); 
int intervalTime            = 0;
int newDayFlag;
int clockSetCutoffYear = 2018;
boolean timeOfDaySet = false;

boolean timeOfDayJustGotSet()
{
  if(year() >= clockSetCutoffYear && timeOfDaySet == false)
  {
     timeOfDaySet = true;
     return(true);
  }
  else
  {
    return(false);
  }
}

boolean timeOfDayIsSet()
{
  if(!timeOfDaySet)
  {
     Readout settingTimeOfDay     = new Readout();
     settingTimeOfDay.initialize("TOD Set",250,100,300,55);
     settingTimeOfDay.drawReadout("Waiting for Clock to Set");
  }
  return(timeOfDaySet);
}

void initializeTimer()
{
    if(ludicrousSpeed)              // set the time and date to a point in the past
    {
      cal.set(Calendar.MILLISECOND, 0); 
      cal.set(Calendar.SECOND, 0); 
      cal.set(Calendar.MINUTE, 0); 
      cal.set(Calendar.HOUR_OF_DAY, 0); 
      cal.set(Calendar.DATE, 1);
      cal.set(Calendar.MONTH, 0);
      cal.set(Calendar.YEAR, 2018);
    }
    else
    {
      cal = Calendar.getInstance();  // synchronize this clock with the current date
    }
    newDayFlag = cal.get(Calendar.DATE); // save the date so we know when it rolls over to a new one
}

boolean intervalTimeExpired()
{
  if(!ludicrousSpeed)  // when in full speed mode, don't update the real time, let it advance it as fast as we can
  {
    cal = Calendar.getInstance();
  }
  else
  {
    cal.add(Calendar.MINUTE,1);
  }
  if(intervalTime < minuteOfDay())
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
  intervalTime = minuteOfDay() % endMinute;
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