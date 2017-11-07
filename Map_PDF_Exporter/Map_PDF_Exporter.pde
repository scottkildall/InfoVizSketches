/*
  Map_PDF_Exporte
  Written by Scott Kildall
  September 2017
  
  Renders out a simple CSV file
  
  Looks for 2 header columns: "Latitude" and "Longitude"
  
  Need to fix the scaling for longitude and latitude to the screen, there will currently be distortion
*/

//-- this is a build in PDF library for Processing that allows for export 
import processing.pdf.*;

//-- this is a flag. When you press the SPACE bar, it will set to TRUE/
//-- then, in the draw() functon we will record 
boolean recordToPDF = false;

//-- this is our table of data
Table table;

float minLon = 9999;
float maxLon = -9999;
float minLat = 9999;
float maxLat = -9999;

float lonRange;
float latRange;

float lonAdjust;
float latAdjust;


void setup() {
  //-- right now width and height have to be the same, otherwise it won't map properly
  size(600,600);
  
  loadData();
}

void draw() {
  //-- draw background elements
  background(0);
  
  
  if( recordToPDF ) {
    beginRecord(PDF, "data_output.pdf");
  }
  
  fill(0,0,255);
  noStroke();
  //stroke(127,127,127);
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
    
     if( x < minLon )
      minLon = x;
    else if( x > maxLon )
      maxLon = x;
    
    if( y < minLat )
      minLat = y;
    else if( y > maxLat )
      maxLat = y;
    
    rowNum = rowNum + 1;
    //println("row :" + rowNum + "  X: " + x );
  }  
  
  println("min X =" + minLon );
  println("min Y =" + minLat );
  println("max X =" + maxLon );
  println("max Y =" + maxLat );
  
  lonRange = maxLon-minLon;
  latRange = maxLat-minLat;
  
  
  println("lon range = " + lonRange );
  println("lat range = " + latRange );
  
  latAdjust = 0;
  lonAdjust = 0;
  if( lonRange > latRange ) {
    latAdjust = (lonRange-latRange)/2;
    
  }
  else if( latRange > lonRange ) {
    lonAdjust = (latRange-lonRange)/2;
  }
    
  println("lon adjust = " + lonAdjust );
  println("lat adjust = " + latAdjust );
  
  println("total lat = " + ((maxLat + latAdjust) - (minLat - latAdjust))  );
  println("total lon = " + ((maxLon + lonAdjust) - (minLon - lonAdjust))  );
}


void drawAllData() {
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    
    drawDatum(x,y, 20);
  }
}

void drawDatum(float x, float y, float dataSize) {
  float  margin = 50;
  float drawX = map(x, (minLon - lonAdjust), (maxLon + lonAdjust), 50, width - 50);
  float drawY = map(y, (minLat - latAdjust), (maxLat + latAdjust), height - 50, 50) * 1.3333 - 100;
  
  
  ellipse(drawX, drawY, dataSize/4, dataSize/4); // Constraint of where circles appear and size of circles
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}