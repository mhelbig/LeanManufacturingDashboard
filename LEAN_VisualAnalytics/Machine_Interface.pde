int pinCountRegister;
int pinTimeRegister;
int activeStartTime;

// Machine Cycle counting:

void mouseWheel(MouseEvent event) // mouse wheel drives counts when emulating
{
  if(!runningOnPi)
  {
    pinCountRegister+= event.getCount();
    if(pinCountRegister < 0)
    {
      pinCountRegister = 0;
    }
    println("Counts = "+pinCountRegister);
  }
}

void SetupCycleCounter(int pin)
{
  GPIO.pinMode(pin, GPIO.INPUT);
  GPIO.attachInterrupt(pin, this, "countEvent", GPIO.FALLING);
}

void countEvent(int countPin)
{
  pinCountRegister++;
  println("Pin "+countPin+" counts = "+pinCountRegister);
}

// Machine Active timer:
void SetupTimeCounter(int pin)
{
  GPIO.pinMode(pin, GPIO.INPUT);
  GPIO.attachInterrupt(pin, this, "timeEvent", GPIO.CHANGE);
  activeStartTime = millis()/1000;  // preset the start time, just in case the machine is already active
}

void timeEvent(int timePin)
{
  if(GPIO.digitalRead(timePin) == GPIO.HIGH)  //machine just went active, record the time it started
  {
    activeStartTime = millis() / 1000;
    println("Active: "+timePin+" time = "+pinTimeRegister);
  }
  else  //machine just went inactive, add up the time that it was active
  {
    pinTimeRegister+=( (millis()/1000) - activeStartTime);
    println("Inactive: "+timePin+" time = "+pinTimeRegister);
  }
}