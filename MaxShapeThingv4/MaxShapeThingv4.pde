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
float la = a;
float xu = 0;
float yu = 1;
float zu = 0;
void draw() {
  //Use a FrameController class to decide what should be draw. (See FrameController)
  frame.update();
  if (session.getSessionType() == SONG) {
    la = a;
    a += (fft.calcAvg(20, 20000) * 2);
    float x = 400.0 * cos(radians(a));
    float y = width/2.0;
    float z = 400.0 * sin(radians(a));

    if (frameCount % (FRAME_RATE * 10) == 0) {
      do {
        xu = rup();
        yu = rup();
        zu = rup();
      } while (xu == 0 && yu == 0 && zu == 0);
    }
    camera(width/2.0 + x, y, z, width/2.0, height/2.0, 0, xu, yu, zu);
  }
}

float rup() {
  return 1.0 - (int) round(random(2));
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

