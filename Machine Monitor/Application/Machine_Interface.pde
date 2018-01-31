int machineActiveInputBCM = 25; // Pin 22 = BCM 25 = input "1" on SimpleIO PCB
int machineCycleInputBCM = 24;  // Pin 18 = BCM 24 = input "2" on SimpleIO PCB
int activityFlag;
int cycleCounter = 0;

// Machine Cycle counting:
void SetupHardwareIO()
{
  if(runningOnPi == 1)
  {
    GPIO.pinMode(machineActiveInputBCM, GPIO.INPUT);
    GPIO.pinMode(machineCycleInputBCM, GPIO.INPUT);
    GPIO.attachInterrupt(machineCycleInputBCM, this, "countEvent", GPIO.FALLING);
  }
}

void countEvent(int pin)    // pin is required by the attachInterrupt method, though it's not used here
{
  cycleCounter++;
}

int readCycleCounter()
{
  return(cycleCounter);
}

void checkActivityInput()  // call this often
{
  if(useMouseInputMode ==0 && runningOnPi == 1)
  {
    if(GPIO.digitalRead(machineActiveInputBCM) == GPIO.LOW)  //machine is active, set the flag
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
  if(useMouseInputMode == 1 || runningOnPi == 0)
  {
    cycleCounter+= abs(event.getCount());
    activityFlag = 1;
  }
}