/*
  Easy Shapes
  Written by Scott Kildall
  November 2020
  
  Illustrates a few basic prinicples
  (1) variables
  (2) calling a function to so something
  (3) drawing shapes and using fills and colors and transparencies
  (4) the basic architecture of a for loop

  What I'm sidestepping is some of the match placement from some of the other
  code that can be confusing for newbies.
*/


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
  
  // Draw a square at upper-left corner of the screen
  fill(255,0,0);        // fill color
  strokeWeight(0);      // no outline on the shape

// EXERCISE 1: modify these values
  int drawX = 100;
  int drawY = 50;
  rect( drawX, drawY, 60, 20 );
//-- DONE EXERCISE 1
  

// EXERCISE 2: modify the values of these for drawing
  fill(255,0,255);        // fill color
  stroke(127,127,127);      // color of the stroke
  strokeWeight(2);          // thickness of the line
  
  //-- This is a FUNCTION that draws a centered circle 
  //-- what is void? I'll go over this
  //-- EXERCISE 3: change the parameter below
  drawCenteredCircle(100);
  //-- done EXERCISE 3

//-- DONE EXERCISE 2

// This function will execute a for loop
// EXERCISE 4: modify these two parameters for drawing — see how we are SENDING these parameters to the function
  drawRowOfSquares(5, 40);
//-- Done EXERCISE 4
}

//-- draw a centered circle
//-- width is the width of the screen, height is the height of the screen
 void drawCenteredCircle( int diameter) {
   ellipse(width/2, height/2, diameter, diameter);
 }


void drawRowOfSquares( int numSquares, int edgeSize ) {
   // the start point for each square
// EXERCISE 5: modify these values
   int drawX = 200;
   int drawY = 650;
   
    fill(0,255,255);        // fill color
   stroke(127,127,127);      // color of the stroke
   strokeWeight(0);          // thickness of the line
  
   // how much space is between each square
   int spaceBetween = 40; 
//-- Done EXERCISE 5   
   
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
