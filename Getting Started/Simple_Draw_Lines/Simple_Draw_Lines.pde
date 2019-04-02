/*
  Simple_Draw
  Written by Scott Kildall
  September 2017
  
  Draws some simple shapes
*/


//-- do any sort of setup functions here
void setup() {
  size(1000,800);
  rectMode(CENTER);
}

void draw() {
  //-- draw background elements
  // Background of 0 = back, background of 255 = white
  background(0);
  
  //-- Draws a row of squares
  fill(255,0,0);        // fill color
  stroke(127,127,127);      // color of the stroke
  strokeWeight(2);
  drawRowSquares(5, 100, 30);
  
  //-- Fill
  fill(255,0,255);        // fill color
  stroke(127,127,127);      // color of the stroke
  strokeWeight(2);          // thickness of the line
  
  //-- This draws a centered circle 
  drawCenteredCircle(30);
}

//-- draw a centered circle
 void drawCenteredCircle( int diameter) {
   ellipse(width/2, height/2, diameter, diameter);
 }
 
 // draw a row of squares
 void drawRowSquares(int num, int h, int edgeSize) {
   //-- like white space between framed pictures
   int spaceBetween = width/(num +1);
   
   for( int i = 0; i < num; i++ )   {
     strokeWeight(1);
     line(width/2, height/2, spaceBetween * (i+1), h);
     
     rect( spaceBetween * (i+1), h, edgeSize, edgeSize );
   }
 }
 