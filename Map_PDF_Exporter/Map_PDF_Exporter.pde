/*
  Map_PDF_Exporte
  Written by Scott Kildall
  September 2017
  
  Renders out a simple CSV file
  
  Looks for 2 header columns: "Latitude" and "Longitude"
  
  Need to fix the scaling for longitude and latitude to the screen, there will currently be distortion
*/

import processing.pdf.*;

boolean recordToPDF = false;

Table table;

float minX = 9999;
float maxX = -9999;
float minY = 9999;
float maxY = -9999;
float xRange;
float xScale;
float yRange;
float yScale;
  
void setup() {
  size(1000,800);
  
  loadData();
}

void draw() {
  //-- draw background elements
  background(0);
  
  
  if( recordToPDF ) {
    beginRecord(PDF, "data_output.pdf");
  }
  
  fill(255,0,0);
  stroke(127,127,127);
  strokeWeight(0);
  //-- draw data
  drawAllData();
  
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    
    background(255);    // flash to white
  } 
}

void loadData() {
  table = loadTable("data_input.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  int rowNum = 0;
  
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    
    if( x < minX )
      minX = x;
    else if( x > maxX )
      maxX = x;
    
    if( y < minY )
      minY = y;
    else if( y > maxY )
      maxY = y;
    
    rowNum = rowNum + 1;
    //println("row :" + rowNum + "  X: " + x );
  }  
  
  println("min X =" + minX );
  println("min Y =" + minY );
  println("max X =" + maxX );
  println("max Y =" + maxY );
  
  xRange = maxX-minX;
  yRange = maxY-minY;
  
  println("X range =" + xRange);
  println("Y range =" + yRange );
  
  //-- this only works in cases like SF where yScale < xScale
  yScale = yRange/xRange;
  println("Y scale =" + yScale );
}

void drawAllData() {
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    
    drawDatum(x,y, 10);
  }
}

void drawDatum(float x, float y, float dataSize) {
  float drawX = map(x, minX, maxX, 100, width - 100);
  float drawY = map(y, minY, maxY, 100, height - 100);// * yScale;
  
  ellipse(drawX, drawY, dataSize/4, dataSize/4); // Constraint of where circles appear and size of circles
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}