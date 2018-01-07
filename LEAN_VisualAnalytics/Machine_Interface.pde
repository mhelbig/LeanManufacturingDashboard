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

void clearCycleCounter()
{
  cycleCounter = 0;
}

void checkActivityInput()  // call this often
{
  if(!inEmulatorMode && runningOnPi)
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

void clearActivityFlag()
{
  activityFlag = 0;
}

void mouseWheel(MouseEvent event) // mouse wheel drives counts when emulating & sets activity flag
{
  if(inEmulatorMode)
  {
    // Update the counter value, bounds check to keep from going negative
    cycleCounter+= abs(event.getCount());
    if(cycleCounter < 0)
    {
      cycleCounter = 0;
    }
    
    // Set the activity flag as well
    activityFlag = 1;
  }
}