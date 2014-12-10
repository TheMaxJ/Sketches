import javax.swing.JOptionPane;

PImage maze; // Loaded maze image

PVector start; // Start of maze
PVector stop; // End of maze

long millis; // Starting time in millis

boolean started; // Has the program started yet?
boolean showProgress; // Should it animate?

Field field; // The field instance

void setup() {
  showProgress = true;
  
  while(maze == null) {
    try {
      maze = loadImage(JOptionPane.showInputDialog("Enter an image url"));
    } catch (NullPointerException npe) {
      println("Invalid maze");
    }
  }
  maze.filter(THRESHOLD, .3);
 
  size(maze.width, maze.height);
  image(maze, 0, 0);
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






