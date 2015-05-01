import javax.swing.JOptionPane;
import processing.video.*;

PImage maze; // Loaded maze image

Capture cam;


PVector start; // Start of maze
PVector stop; // End of maze

long millis; // Starting time in millis

boolean started; // Has the program started yet?
boolean showProgress; // Should it animate?

Field field; // The field instance
String[] cameras;

void setup() {
  size(1920, 1080);

   cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  } else {
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }

  showProgress = true;
}

void draw() {
  if (started) {  
    if (field == null) {
      Thread fieldThread = new Thread((field = new Field(maze, start, stop)));
      fieldThread.start();
    }
  } else {
    if (cam.available() == true && maze == null) {
      cam.read();
      image(cam, 0, 0);
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
  if (maze == null) {
    cam.stop();
    _filter();
    return;
  }
  if (start == null) {
    start = new PVector(mouseX, mouseY);
    println("Starting Point chosen");
  } else if (stop == null) {
    stop = new PVector(mouseX, mouseY);
    beginExecution();
  } else {
    showProgress = !showProgress;
  }
}
int c = 0;
float t = .5;
void keyPressed() {
  if (key == 'w') {
    t+=.01;
  }
  if (key == 's') {
    t-=.01;
  }
  if (key == ' ') {
    c = (c + 1) % cameras.length;
    cam = new Capture(this, cameras[c]);
    cam.start();
    return;
  }
  _filter();
}

void _filter() {
  maze = cam.get();
  maze.filter(THRESHOLD, t);
  image(maze, 0, 0);
}


