int pinActiveInput = 25;
int pinCounInput = 24;
int activityFlag;
int cycleCounter = 0;

// Machine Cycle counting:

void SetupHardwareIO()
{
  if(runningOnPi)
  {
    GPIO.pinMode(pinActiveInput, GPIO.INPUT);
    GPIO.pinMode(pinCounInput, GPIO.INPUT);
    GPIO.attachInterrupt(pinCounInput, this, "countEvent", GPIO.FALLING);
  }
}

void countEvent(int pin)
{
  cycleCounter++;
  // pin is required by the attachInterrupt method, though it's not used here
}

int readCycleCounter()
{
  return(cycleCounter);
}

void checkActivityInput()  // call this often
{
  if(!useMouseInputMode && runningOnPi)
  {
    if(GPIO.digitalRead(pinActiveInput) == GPIO.LOW)  //machine is active, set the flag
    {
      activityFlag = 1;
    }
  }
}

int readActivityState()
{
  return(activityFlag);
}

void resetActivityInputs()
{
  activityFlag = 0;
  cycleCounter = 0;
}

void mouseWheel(MouseEvent event) // mouse wheel drives counts when emulating & sets activity flag
{
  if(useMouseInputMode || !runningOnPi)
  {
    cycleCounter+= abs(event.getCount());
    activityFlag = 1;
  }
}