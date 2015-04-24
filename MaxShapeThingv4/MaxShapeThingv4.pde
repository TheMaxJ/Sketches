import ddf.minim.*;
import ddf.minim.analysis.*;

//NOTE: This requires the MINIM and SOUNDCLOUD libraries to run. (Minim should come with processing, I've packaged the Soundcloud.jar library with this.)

/**
* Called once at the very beginning of the program.
*/
void setup() {
  //Setup size using final vars. You should be able to change them to scale the amount of shapes created.
  size(RES_X, RES_Y, P2D);
  //Same thing as the setup
  frameRate(FRAME_RATE);
  //These two for loops just count how many rows and collums we are going to have.
  for (int x = EDGE_BUFFER+R_RADIUS; x < height-EDGE_BUFFER; x+=SPACING) {
    ROWS++;
  }
  for (int y = EDGE_BUFFER+R_RADIUS; y < width-EDGE_BUFFER; y+=SPACING) {
    COLLUMS++;
  }
  minim = new Minim(this); //Main class of the library used to stream audio
  player = minim.getLineIn();
  beat = new BeatDetect(player.bufferSize(), player.sampleRate());
  beat.setSensitivity(100); 
}
/**
* Called FRAME_RATE times every second
*/
void draw() {
  //Use a FrameController class to decide what should be draw. (See FrameController)
  frame.update();
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

