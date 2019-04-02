/*
  Mouse Shape
  Written by Scott Kildall
  September 2017
  
  Draws a shape and follow the mouse around
  
  Lesson:
  how to run a sketch
  setup() and draw()
  syntax — curly braces, semi-colons and void
  background to setup
  background w/RGB and 0-255
  change fill colors
  ellipse size
  try other shapes - look up ellipse, go to language, try rect(), line(), triangle()
*/


void setup() {
  size(1000, 800);
  rectMode(CENTER);
}

void draw() { 
  background(0);
  
   if (mousePressed)
     fill(255,0,0);
   else
     fill(0,0,255);
    
  ellipse(mouseX, mouseY, 80, 80);  
}