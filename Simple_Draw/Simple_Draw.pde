/*
  Simple_Draw
  Written by Scott Kildall
  September 2017
  
  Draws some simple shapes
*/


//-- do any sort of setup functions here
void setup() {
  size(1000,800);
}

void draw() {
  //-- draw background elements
  background(0);
  
  //-- these are settings that have to be done AFTER the record
  fill(0,0,255);
  stroke(127,127,127);
  
  //-- draw data
  drawData();
}

//-- function that will draw all of our data
void drawData() {
  ellipse(width/2, height/2, 100, 100); // Constraint of where circles appear and size of circles
}