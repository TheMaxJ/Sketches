PImage maze;
Field field;
PVector start;
PVector stop;
long millis;
AsyncInformer info;
boolean started;

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
  if (started) {  
    if (field == null) {
      Thread fieldThread = new Thread((field = new Field(maze,start,stop)));
      fieldThread.start();
    }
  } else {
    image(maze, 0, 0);
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
  }
}






