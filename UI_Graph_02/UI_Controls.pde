void keyPressed() {
  if(key == 'r' || key == 'R') {
    machineActive = !machineActive;
    addEvent(playbackTime,(machineActive ? 1 : 0));
    println("Recording is " + (machineActive ? "ON" : "OFF"));
  }
  if (key == 'q') {
//    videoExport.endMovie();
    exit();
  }
}