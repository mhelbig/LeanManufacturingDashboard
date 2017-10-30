void detectMachineActiveState()
{
 opencv.loadImage(imageRecognition);
 opencv.setROI(mouseX, mouseY, roiWidth, roiHeight);
 
 opencv.findCannyEdges(20,75);
 image(opencv.getSnapshot(), mouseX, mouseY);  
  
}