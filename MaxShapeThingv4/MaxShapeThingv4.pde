import ddf.minim.*;
import ddf.minim.analysis.*;

//NOTE: This requires the MINIM and SOUNDCLOUD libraries to run. (Minim should come with processing, I've packaged the Soundcloud.jar library with this.)

/**
* Called once at the very beginning of the program.
*/
void setup() {
  //Setup size using final vars. You should be able to change them to scale the amount of shapes created.
  size(RES_X, RES_Y, P3D);
  //Same thing as the setup
  frameRate(FRAME_RATE);
  //These two for loops just count how many rows and collums we are going to have.
  minim = new Minim(this); //Main class of the library used to stream audio
  player = minim.getLineIn();
  beat = new BeatDetect(player.bufferSize(), player.sampleRate());
  beat.setSensitivity(100); 
}
/**
* Called FRAME_RATE times every second
*/
float a = 0;
void draw() {
  //Use a FrameController class to decide what should be draw. (See FrameController)
  frame.update();
  a += (fft.calcAvg(20,20000) * 100);
  camera(10.0 * cos(radians(a)), width/2.0, 10.0 * sin(radians(a)), width/2.0, width/2.0, 0, 0, 1, 0);
  println(cos(radians(a)));
}
/**
* Called on key-press.
*/
void keyPressed() {
  input.keyPressed();
}
/**
* Called on Mouse-Click
*/
void mouseClicked() {
  input.mouseClicked();
}

