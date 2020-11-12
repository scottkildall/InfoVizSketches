/*
  Map_PDF_Exporter
  Written by Scott Kildall
  September 2017
  
  Renders out a simple CSV file to (x,y) points on the screen
  Looks for 2 header columns: "Latitude" and "Longitude"
  
  This version includes a "Size" field
  
  Output file is: data_output.pdf
  Input file is: data_input.csv
  
  Spacebar will save the file
  
*/

//-- this is a build in PDF library for Processing that allows for export 
import processing.pdf.*;

MercatorMap mapper;

//---------------------------------------------------------------------------
//-- DEFAULT VARIABLES
final float defaultSize = 5;
final int defaultCategoryNum = 0;
final float  margin = 50;
float screenWidth;
float screenHeight;

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


// 1 degree of longitude = 54.6 miles
// 1 degree of latutide = 69 miles
// this is the ratio between them
float latLonAdjustment = 1.2637;

//
void setup() {
  //-- right now width and height have to be the same, otherwise it won't map properly
  //-- set to something like (2400,2400) for a large image
  size(800,800);
  
  
  
  loadData("data_input.csv");
    
  mapper = new MercatorMap(width,height, maxLat, minLat , minLon, maxLon );
    
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  screenWidth  = width;
  screenHeight = height;
}

void draw() {
  //-- draw background elements
  background(0);
  
  
  //-- respond to flag for recording
  if( recordToPDF ) {
    beginRecord(PDF, "data_output.pdf");
  }
  
  // use various strokes and weights to respond to size here
  fill(0,0,255);
  noStroke();
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
    
     if( x < minLon ) {
      minLon = x;
    }
    else if( x > maxLon ) {
      maxLon = x;
    }
    
     //println("y = " + y);
     //  println("maxLat = " + maxLat);
    if( y < minLat ) {
      minLat = y;
    }
    
    if( y > maxLat ) {
      maxLat = y;
    }
  }  
  
  //-- determine various ranges and make simple math adjustments for plotting on the screen
  println("min lon (Y) = " + minLon );
  println("min lat (X) = " + minLat );
  println("max lon (Y) = " + maxLon );
  println("max lat (X) = " + maxLat );
  
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
  /*
  println("----------------");
  float xLeft = (minLon - lonAdjust);
  float xRight = (maxLon + lonAdjust);
   float yLeft = (minLat - latAdjust);
   float yRight = (maxLat + latAdjust);
   println("x left = " + xLeft );
   println("x right = " + xRight );
   println("y left = " + yLeft );
   println("y right = " + yRight );
    println("x size = " + (xRight-xLeft) );
  println("y size = " + (yRight-yLeft) );
  println("----------------");
  */
  
   // Re-do CENTER drawing b/c PDFs operate strangle
   rectMode(CENTER);
   ellipseMode(CENTER);
    
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    float s = getSizeData(row);       // size
    int year = getYearData(row);   // category 
    
   
    //-- draw data point here
    drawDatum(x,y, s, year);
  }
}

//-- read .size column, if there is none, then we use a default size variable (global)
float getSizeData(TableRow row) {
   float s = defaultSize;

   //-- Process size column
    try {
      //-- there IS size column
      s = row.getFloat("Size");
      
      // modify the size data here:
      // Cisterns: use something like  s = s/10000;
      // Prisons: use soemthing like s = s/400;
      s = s/400;
      
    } catch (Exception e) {
      //-- there is NO size column in this data set
      //-- no size coulumn, set s to plottable value
      
    }
    
    return s;
}

//-- read .category column, if there is none, then we use a default category
//-- category is always an int
int getYearData(TableRow row) {
   int y = 2004;    // default

   //-- Process size column
    try {
      //-- there IS size column
      y = row.getInt("Year");
    } catch (Exception e) {
      //-- there is NO category column in this data set
      //-- OR there is a non-integer
    }
    
    return y;
}

void drawDatum(float x, float y, float dataSize, int year) {
  
  float drawX = map(x, (minLon - lonAdjust), (maxLon + lonAdjust), margin, (float)(screenWidth - margin) );
  float drawY = map(y, (minLat - latAdjust), (maxLat + latAdjust), (float)(screenHeight - margin), margin) * latLonAdjustment;
  
  // inconsistent results...
  //float drawX = mapper.getScreenX(x);
  //float drawY = mapper.getScreenY(y) * .575;
  
  
  //-- change color based on size
  if( dataSize > 10 ) {
    fill(255,0,0);
    ellipse(drawX, drawY, dataSize, dataSize); // Constraint of where circles appear and size of circles   
}
  else {
    fill(0,240,128);
    rect(drawX, drawY, dataSize, dataSize); // Constraint of where circles appear and size of circles   
   } 
 }
  

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}
