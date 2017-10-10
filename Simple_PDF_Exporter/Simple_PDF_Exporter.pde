/*
  Simple_PDF_Exporter
  Written by Scott Kildall
  September 2017
  
  Draws shapes and exports them a PDF file, to be read by Illustrator
*/

import processing.pdf.*;

//-- used in keyPressed() as flag to save to PDF
boolean recordToPDF = false;

  
//-- do any sort of setup functions here
void setup() {
  size(1000,800);
}

void draw() {
  //-- draw background elements
  background(0);
  
  if( recordToPDF ) {
    beginRecord(PDF, "saved_file.pdf");
  }
  
  //-- these are settings that have to be done AFTER the record
  fill(255,0,255);
  stroke(127,127,127);
  
  //-- draw data
  drawData();
  
  //-- check the flag to record to PDF
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    background(255);    // flash to white so we can indicate that we are recording
  } 
}

//-- function that will draw all of our data
void drawData() {
  ellipse(width/2, height/2, 100, 100); // Constraint of where circles appear and size of circles
}


//-- when user pressed the SPACE bar, set recordToPDF = true and we will save to PDF in the draw functions
void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}