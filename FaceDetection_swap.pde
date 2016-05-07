import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture cam;
OpenCV opencv;
Rectangle[] faces;
PImage face;
PImage faceOne;

void setup() {
  size(640, 480);
  
  cam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  cam.start();
  
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    opencv.loadImage(cam);
   
  }
  //image(opencv.getInput(), 0, 0);
   image(cam, 0, 0, width, height);

 
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();

  
 if(faces.length > 1){ //If there is more than 1 face detected
  PImage [] facePix = new PImage [faces.length]; //make an array of PImages called facePix which is the legnth of "faces" (rectangle array that detects faces)
    for (int i = 0; i < faces.length; i++) { // scroll through facePix 
      facePix[i] = cam.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height); // store pixels of faces 
    }
    PImage faceOne = facePix[0]; // Store the first face in the array
    for (int i = 0; i<faces.length; i++){
      if(i!=faces.length-1){ //if the current face is not the last one in the array
        facePix[i] = facePix[i+1]; // replace the current face with the next face in the array
      }else {
        facePix[i] = faceOne; // replace the last face in the array with the first face
      }
    }
    for (int i = 0; i<faces.length; i++){ 
      image(facePix[i], faces[i].x, faces[i].y, faces[i].width, faces[i].height); //overlay the faces in the newly shuffled positions
    }
  }
  
  
}