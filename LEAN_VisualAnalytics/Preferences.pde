//Preferences-based settings variables:
String machineName;
float overheadRatePerHour;
float profitRatePerHour;

void ResetSystemDefaultParameters()
{
  machineName          = "Komatsu";
  overheadRatePerHour   =  15.00;
  profitRatePerHour     =  75.00; // $60/hour netprofit per hour when active

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
    machineName         = programPreferences.getText("machineName"); 
    overheadRatePerHour = programPreferences.getFloat("overheadRatePerHour");
    profitRatePerHour   = programPreferences.getFloat("profitRatePerHour");
  }
}

void saveSystemParameters()
{
  programPreferences.setText("machineName",                  machineName,                false);
  programPreferences.setNumber("overheadRatePerHour",        overheadRatePerHour,        false);
  programPreferences.setNumber("profitRatePerHour",          profitRatePerHour,          false);

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
  String preferencesFileName = "data/Preferences.txt";
  
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