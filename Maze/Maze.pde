PImage maze;
Field field;
void setup() {
  println("Starting! Beginning Setup...");
  println("Loading maze.png...");
  maze = loadImage("maze.png");
  println("maze.png found. Beginning black/white filtering.");
  maze.filter(THRESHOLD, .03);
  println("Finished Filtering. Compressing Image.");
  image(maze, 0, 0);
  size(maze.width, maze.height);
  println("Populating Path Nodes");
  field = new Field(maze, new PVector(0,0), new PVector(width, height));
  frameRate(60);
  println("Populated. Finished Setup. Executing. Stand By.");
  image(maze,0,0);
}

void draw() {
  field.execute();
}


