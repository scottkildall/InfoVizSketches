/*
  Data Example
  Written by Scott Kildall
  March 2019
  
  NOT WORKING
  
  To be added
   
    Input file is: data_input.csv
    Output file is: saved_file.pdf
    
    Website: http://cow.dss.ucdavis.edu/data-sets/COW-war
    
    Dataset: The Inter-state War Data, a smaller consolidated version:
    
    Header has this infohere:
    WarNum, WarName, StateName, StartYear1, EndYear1, BatDeath
    
*/

import processing.pdf.*;

//-- used in keyPressed() as flag to save to PDF
boolean recordToPDF = false;

//-- this is our table of data
Table table;

//-- min/max years
int startYear = 3000;    // impossibly high
int endYear = 0;        // impossibly low
int screenWidth = 1000;
int margin = 50;

//-- do any sort of setup functions here
void setup() {
  size(1000,800);
  rectMode(CENTER);
  
  loadData("data_input.csv");
}

void draw() {
  //-- draw background elements
  // Background of 0 = back, background of 255 = white
  background(0);
  
  if( recordToPDF ) {
    beginRecord(PDF, "saved_file.pdf");
  }
  
  fill(255,0,0, 100);
  noStroke();
  
  // Draw circles for data, make a minimum mark (though this is not as accurate...)
  for (TableRow row : table.rows()) {
      
      float drawX = map( row.getInt("StartYear1"), startYear, endYear, margin, screenWidth-margin);
      
      int deaths = row.getInt("BatDeath");
      float ellipseArea = sqrt(deaths) / 5;
      
      if( ellipseArea < 2 )
        ellipseArea = 2;
        
      ellipse( drawX, 400,ellipseArea, ellipseArea);
  }
  

  
   //-- check the flag to record to PDF
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    background(255);    // flash to white so we can indicate that we are recording
  } 
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
 
 //-- loads the data into the table variable, does some testing for the output
void loadData(String filename) {
  //-- this loads the actual table into memory
  table = loadTable(filename, "header");

  println(table.getRowCount() + " total rows in table"); 

  
  //-- go though table and do additional processing here, if needed
  
  for (TableRow row : table.rows()) {
    int sy = row.getInt("StartYear1");
    int ey = row.getInt("EndYear1");
    
    //-- store earliest and latest year in variables
    if( sy < startYear )
      startYear = sy;
    if( ey > endYear )
      endYear = ey;
  }  

 
  println( "start year = " + startYear ); 
  println( "start year = " + endYear );
}


 //-- when user pressed the SPACE bar, set recordToPDF = true and we will save to PDF in the draw functions
void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}