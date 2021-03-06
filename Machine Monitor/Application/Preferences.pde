//Preferences-based settings variables:

// Target device compile flags:
int runningOnPi         = 0;
int ludicrousSpeed      = 1;
int useMouseInputMode   = 1;
 
String machineName;
float overheadRatePerHour;
float profitRatePerHour;
int   fileSaveInterval;

void ResetSystemDefaultParameters()
{
  runningOnPi           = 0;
  ludicrousSpeed        = 1;
  useMouseInputMode     = 1;
  machineName           = "Komatsu";
  overheadRatePerHour   = 15.00;
  profitRatePerHour     = 75.00; // $60/hour netprofit per hour when active
  fileSaveInterval      = 60;

  saveSystemParameters();
}

void loadPreferences()
{
  if(!programPreferences.loadPref())
  {
    ResetSystemDefaultParameters();
    println("Preferences file missing.  Default settings loaded.");
  }
  else
  {
    runningOnPi         = programPreferences.getInt("runningOnPi");
    ludicrousSpeed      = programPreferences.getInt("ludicrousSpeed");
    useMouseInputMode   = programPreferences.getInt("useMouseInputMode");
    machineName         = programPreferences.getText("machineName"); 
    overheadRatePerHour = programPreferences.getFloat("overheadRatePerHour");
    profitRatePerHour   = programPreferences.getFloat("profitRatePerHour");
    fileSaveInterval    = programPreferences.getInt("fileSaveInterval");
  }
}

void saveSystemParameters()
{
  programPreferences.setNumber("runningOnPi",          runningOnPi,         false);
  programPreferences.setNumber("ludicrousSpeed",       ludicrousSpeed,      false);
  programPreferences.setNumber("useMouseInputMode",    useMouseInputMode,   false);
  programPreferences.setText  ("machineName",          machineName,         false);
  programPreferences.setNumber("overheadRatePerHour",  overheadRatePerHour, false);
  programPreferences.setNumber("profitRatePerHour",    profitRatePerHour,   false);
  programPreferences.setNumber("fileSaveInterval",     fileSaveInterval,    false);

  programPreferences.savePref();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * Load and save variables preference 
 * 
 * Store data from variables in a text file on your hardrive.
 * 
 * By Ben-Tommy Eriksen
 * ben@nornet.no
 * www.nornet.no
 */

class Preference
{
  
  StringDict PreferencesDict = new StringDict();      //Make an String Dictionary
  String preferencesFileName = "../MachineData/Preferences.txt";
  
  Preference() 
  {
  }
  
  void setText(String _key, String _value, boolean saveItToDiskNow)
  {
    PreferencesDict.set(_key, _value);                                              //Change a value for a key. Add if key not exist
    
    if(saveItToDiskNow)
    {                                                           //Save it automatic now or manual later
      savePref();
    }
  }
  
  void setNumber(String _key, float _value, boolean saveItToDiskNow)
  {
    PreferencesDict.set(_key, str(_value));                                         //Chage a value for a key. Add if key not exist
    
    if(saveItToDiskNow)
    {                                                           //Save it automatic now or manual later
      savePref();
    }
  }
  
  String getText(String _key)
  {
    return PreferencesDict.get(_key);                                               //return a value for a key
  }
  
  float getFloat(String _key)
  {
    return float(PreferencesDict.get(_key));                                        //return a value for a key as an float
  }
  
  int getInt(String _key)
  {
    return int(PreferencesDict.get(_key));                                          //return a value for a key as an integer
  }
  
  boolean loadPref()
  {
    String lines[] = loadStrings(preferencesFileName);                              //Load all preferences lines in text file from disk
    
    if(lines == null) return false;                                                 //Returns false if there is a problem opening the file

    for (int i = 1 ; i < lines.length; i++)
    {                                       //Loop thru all lines - but not the header
      String[] PreferencesLoadLineArr = split(lines[i], "=");                       //Split into variable and value
      if(PreferencesLoadLineArr.length == 2)
      {                                      //Check if it is an variable separated by an =
        PreferencesDict.set(PreferencesLoadLineArr[0],PreferencesLoadLineArr[1]);   //put variable and value in String Dictionary
      }
    }
    
//    println(PreferencesDict);                                                        //Print content (for debugging)
    return(true);                                                                    //Returns true if things look good
  }
  
  void savePref()
  {
    String[] preferencesFileContent = {"Preferences:"};                              //Make content file and add header text
    
    for (String k : PreferencesDict.keys())
    {                                        //Loop thru all variable
      String appendString = k + "=" + PreferencesDict.get(k);                        //Put variable and value in a line
      preferencesFileContent = append(preferencesFileContent, appendString);         //add the line to content file
    }
    
    saveStrings(preferencesFileName, preferencesFileContent);                        //Save content file to disk;
    
    println(PreferencesDict);                                                        //Print content (for debugging)
  }
}