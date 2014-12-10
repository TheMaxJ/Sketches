PImage maze; // Loaded maze image

PVector start; // Start of maze
PVector stop; // End of maze

long millis; // Starting time in millis

boolean started; // Has the program started yet?
boolean showProgress; // Should it animate?

Field field; // The field instance

void setup() {
  
  showProgress = true;
  
  println("Starting! Beginning Startup...");
  println("Loading maze.png...");
  maze = loadImage("maze.png");
  
  println("maze.png found. Beginning black/white filtering.");
  maze.filter(THRESHOLD, .03);
  println("Finished Filtering.");
  
  size(maze.width, maze.height);
  image(maze, 0, 0);

  println("Please select two points, beginning and end.");
}

void draw() {
  if (started) {  
    if (field == null) {
      Thread fieldThread = new Thread((field = new Field(maze, start, stop)));
      fieldThread.start();
    }
  } 
}

void beginExecution() {
  frameRate(60);
  println("Populated. Finished Setup. Executing.");
  image(maze, 0, 0);
  millis = millis();
  started = true;
}

void mousePressed() {
  if (start == null) {
    start = new PVector(mouseX, mouseY);
    println("Starting Point chosen");
  } else if (stop == null) {
    stop = new PVector(mouseX, mouseY);
    println("Ending Point chosen. Beginning Setup.");
    beginExecution();
  } else {
    showProgress = !showProgress;
  }
}






