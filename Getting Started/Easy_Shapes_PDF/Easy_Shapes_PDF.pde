/*
  Easy_Shapes_PDF
  Written by Scott Kildall
  November 2020
  
  Sames as Easy_Shapes except saves to a PDF file when the spacebar is pressed
  AND removed the EXERCISES comments
*/

// library to save to PDF
import processing.pdf.*;

// set to TRUE when we press the spacebar
boolean recordToPDF = false;

//-- do any sort of setup functions here
void setup() {
  // This is the side of the screen
  size(1000,800);
  
  // Draws from the center points for ellipses (circles), rectangles (squares)
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw() {
  // Background of 0 = black, background of 255 = white
  background(0);
  
  if( recordToPDF ) {
     beginRecord(PDF, "saved_file.pdf");
  }
  
  
  // Draw a square at upper-left corner of the screen
  fill(255,0,0);        // fill color
  strokeWeight(0);      // no outline on the shape

  int drawX = 100;
  int drawY = 50;
  rect( drawX, drawY, 60, 20 );

  
  fill(255,0,255);        // fill color
  stroke(127,127,127);      // color of the stroke
  strokeWeight(2);          // thickness of the line
  
  //-- This is a FUNCTION that draws a centered circle 
  drawCenteredCircle(100);

// This function will execute a for loop
  drawRowOfSquares(5, 40);
  
   //-- check the flag to record to PDF
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
  } 
}

//-- draw a centered circle
//-- width is the width of the screen, height is the height of the screen
 void drawCenteredCircle( int diameter) {
   ellipse(width/2, height/2, diameter, diameter);
 }


void drawRowOfSquares( int numSquares, int edgeSize ) {
   // the start point for each square
   int drawX = 200;
   int drawY = 650;
   
   fill(0,255,255);        // fill color
   stroke(127,127,127);      // color of the stroke
   strokeWeight(0);          // thickness of the line
  
   // how much space is between each square
   int spaceBetween = 40; 
   
   // This is the for loop
   // i is a CONTROL VARAIBLE and the loop will execute for the number of squares
   // each time the loop goes, we add 1 to i
   // i starts at zero
   for( int i = 0; i < numSquares; i++ ) {
      rect( drawX + (i * (edgeSize+spaceBetween)), drawY, edgeSize, edgeSize );
   }
   
   // It's like framing a row of pictures!
   // edgeSize = the width of the frame
   // spaceBetween is how much space is between each square
}

 //-- when user pressed the SPACE bar, set recordToPDF = true and we will save to PDF in the draw functions
void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}
