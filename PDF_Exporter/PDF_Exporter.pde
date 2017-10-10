import processing.pdf.*;

boolean recordToPDF = false;

Table table;

float minX = 9999;
float maxX = -9999;
float minY = 9999;
float maxY = -9999;
    
  
void setup() {
  size(1000,800);
  
  loadData();
}

void draw() {
  //-- draw background elements
  background(0);
  fill(0,0,255);
  stroke(127,127,127);
  
  if( recordToPDF ) {
    beginRecord(PDF, "data_file.pdf");
    background(255);    // flash to white
  }
  
  //-- draw data
  drawData();
  
  if( recordToPDF ) {
    endRecord();
    recordToPDF = false;
  } 
}

void loadData() {
  table = loadTable("tree_caretakers.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  int rowNum = 0;
  
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    int treeHeight = row.getInt("Width");
    
    if( x < minX )
      minX = x;
    else if( x > maxX )
      maxX = x;
    
    if( y < minY )
      minY = y;
    else if( y > maxY )
      maxY = y;
    
    rowNum = rowNum + 1;
    println("row :" + rowNum + "  X: " + x );
  }  
  
  println("min X =" + minX );
  println("min Y =" + minY );
  println("max X =" + maxX );
  println("max Y =" + maxY );
}

void drawData() {
  for (TableRow row : table.rows()) {
    
    float x = row.getFloat("Longitude");
    float y = row.getFloat("Latitude");
    int treeHeight = row.getInt("Width");
    
    drawTree(x,y, treeHeight);
  }
}

void drawTree(float x, float y, int treeHeight) {
  float drawX = map(x, minX, maxX, 100, width - 100);
  float drawY = map(y, minY, maxY, 100, height - 100);
  
  
  ellipse(drawX, drawY, treeHeight/4, treeHeight/4); // Constraint of where circles appear and size of circles
  
}

void keyPressed() {
  if( key == ' ' )
    recordToPDF = true;
}