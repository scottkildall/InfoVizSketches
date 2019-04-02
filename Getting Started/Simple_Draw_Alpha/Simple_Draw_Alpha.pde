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
  noStroke();
}

void draw() {
  //-- draw background elements
  // Background of 0 = back, background of 255 = white
  background(0);
  
  //-- Fill
  //-- Draws a row of circles, use alpha channel
  fill(255,0,0,100);        // fill color
  drawRowCircles(5, 200, 200);
}

 
 // draw a row of squares
 void drawRowCircles(int num, int h, int edgeSize) {
   //-- like white space between framed pictures
   int spaceBetween = width/(num +1);
   
   for( int i = 0; i < num; i++ )   {
     ellipse( spaceBetween * (i+1), h, edgeSize, edgeSize );
   }
 }
 