PImage maze;
Field field;
PVector start;
PVector stop;
long millis;
AsyncInformer info;

void setup() {
  println("Starting! Beginning Startup...");
  println("Loading maze.png...");
  maze = loadImage("maze.png");
  println("maze.png found. Beginning black/white filtering.");
  maze.filter(THRESHOLD, .03);
  println("Finished Filtering.");
  image(maze, 0, 0);
  size(maze.width, maze.height);
  println("Please select two points, beginning and end.");
}

void draw() {
  if (start != null && stop != null) {
    
    info = new AsyncInformer(field);
    
    Thread infoThread = new Thread(info);
    
    infoThread.start();
    field.run();
    
  } else {
      image(maze, 0, 0);
  }
}

void beginExecution() {
  field = new Field(maze, start, stop);
  frameRate(60);
  println("Populated. Finished Setup. Executing.");
  image(maze,0,0);
  millis = millis();
}

void mousePressed() {
  if (start == null) {
    start = new PVector(mouseX, mouseY);
    println("Starting Point chosen");
  } else if (stop == null) {
    stop = new PVector(mouseX, mouseY);
    println("Ending Point chosen. Beginning Setup.");
    beginExecution();
  }
}







