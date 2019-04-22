/*
  WaterSamples_Ma[
  Written by Scott Kildall
  September 2019
  
  Renders out a simple CSV file to (x,y) points on the screen
  Looks for 2 header columns: "Latitude" and "Longitude"
  
  This version includes a "Size" field
  
  Output file is: data_output.pdf
  Input file is: data_input.csv
  
  Spacebar will save the file
  
  Based on the Map_PDF_Exporter
  
*/

//-- this is a build in PDF library for Processing that allows for export 
import processing.pdf.*;

//---------------------------------------------------------------------------
//-- DEFAULT VARIABLES
final float defaultSize = 5;
final int defaultCategoryNum = 0;
final float  margin = 50;

final float homeLat = 37.777133;
final float homeLon = -122.452745;
float homeX;
float homeY;

//---------------------------------------------------------------------------
//-- this is a flag. When you press the SPACE bar, it will set to TRUE
//-- then, in the draw() functon we will record 
boolean recordToPDF = false;

//-- this is our table of data
Table table;

//---------------------------------------------------------------------------
//-- these are all variables for doing accurate mapping
float minLon = 9999;
float maxLon = -9999;
float minLat = 9999;
float maxLat = -9999;

float lonRange;
float latRange;

float lonAdjust;
float latAdjust;
//---------------------------------------------------------------------------


//
void setup() {
  //-- right now width and height have to be the same, otherwise it won't map properly
  //-- set to something like (2400,2400) for a large image
  size(1000,1000);
  
  loadData("data_input.csv");
  
  homeX = map(homeLon, (minLon - lonAdjust), (maxLon + lonAdjust), margin, width - margin);
  homeY = map(homeLat, (minLat - latAdjust), (maxLat + latAdjust), height - margin, margin) * 1.25 - 100;
  
  
  println(homeX);
  println(homeY);
  
}

void draw() {
  //-- draw background elements
  background(0);
  
  
  //-- respond to flag for recording
  if( recordToPDF )
    beginRecord(PDF, "data_output.pdf");
  
  
  // use various strokes and weights to respond to size here
  fill(0,0,255);
  noStroke();
  //stroke(127,127,127);
  strokeWeight(0);
  
  //-- draw data
  drawAllData();
  
  //-- done recording to PDF, set flag to false and flash white to indicate that we have recorded
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
    background(255);    // flash to white
  } 
}

//-- loads the data into the table variable, does some testing for the output
void loadData(String filename) {
  //-- this loads the actual table into memory
  table = loadTable(filename, "header");

  println(table.getRowCount() + " total rows in table"); 

  
  //-- go though table and deterime min and max lat/lon for mapping to the screen
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
  }  
  
  //-- determine various ranges and make simple math adjustments for plotting on the screen
  println("min X =" + minLon );
  println("min Y =" + minLat );
  println("max X =" + maxLon );
  println("max Y =" + maxLat );
  
  lonRange = maxLon-minLon;
  latRange = maxLat-minLat;
  
  
  println("lon range = " + lonRange );
  println("lat range = " + latRange );
  
  //-- we do this so that we don't have skewed maps
  latAdjust = 0;
  lonAdjust = 0;
  if( lonRange > latRange )
    latAdjust = (lonRange-latRange)/2;
  else if( latRange > lonRange )
    lonAdjust = (latRange-lonRange)/2;
  
    
  println("lon adjust = " + lonAdjust );
  println("lat adjust = " + latAdjust );
  
  // total lat should be = total lon
  println("total lat = " + ((maxLat + latAdjust) - (minLat - latAdjust))  );
  println("total lon = " + ((maxLon + lonAdjust) - (minLon - lonAdjust))  );
}


//-- draw each data
void drawAllData() {
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    float pH = getpHData(row);       // size
    float ec = getECData(row);   // category 
    
   
    //-- draw data point here
    drawWaterSample(x,y, pH, ec);
  }
  
  //-- draw home
  //fill(255,0,0);
  //ellipse(homeX, homeY, 10,10);
}

//-- read .size column, if there is none, then we use a default size variable (global)
float getpHData(TableRow row) {
   float pH = 7.0;  // make this the default
  
   //-- Process size column
    try {
      //-- there IS size column
      pH = row.getFloat("pH");
    } catch (Exception e) {
      //-- there is NO size column in this data set
      //-- no size coulumn, set s to plottable value
      
    }
    
    return pH;
}

//-- read .category column, if there is none, then we use a default category
//-- category is always an int
float getECData(TableRow row) {
   float ec = 400;  // make this the default
  
   //-- Process size column
    try {
      //-- there IS size column
      ec = row.getFloat("EC (Instrument)");
    } catch (Exception e) {
      //-- there is NO size column in this data set
      //-- no size coulumn, set s to plottable value
      
    }
    
    return ec;
}

void drawWaterSample(float x, float y, float pH, float ec) {
  
  float drawX = map(x, (minLon - lonAdjust), (maxLon + lonAdjust), margin, width - margin);
  float drawY = map(y, (minLat - latAdjust), (maxLat + latAdjust), height - margin, margin) * 1.25 - 100;
  
  //-- regular blue  
  fill(0,0,255);
  
  //-- change according to pH
  //fill(0,0,255-(pH*20));
  
  //-- change according to ec and pH
  //fill(255 * (30/ec),0,255-(pH*20));
   
     
  ellipse(drawX, drawY, 15, 15); // Constraint of where circles appear and size of circles   
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}