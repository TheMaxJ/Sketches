//Unchanging values
final int R_RADIUS = 40; //Radius of the polygons.
final int RES_X = 800; //Window width
final int RES_Y = 800; //Window height
final int EDGE_BUFFER = (int) (2.5 * R_RADIUS); //Distance separating the first polygon and the edge of the screen
final int SPACING = (int) (2.5 * R_RADIUS); //Spacing between polygon 
final int FRAME_RATE = 10; //Frame rate variable

//Replaces Magic Numbers for the sessions.
final int TYPING = 0;
final int INTRO = 1;
final int SONG = 2;

//Changing values
int ROWS = 0; //This will be used in void setup() to store the amount of rows to be made.
int COLLUMS = 0; //See above, but with collums
float R_LIMIT = 7; /* Interesting little number, used to calculate how "random" the corners of each shape can be. 
                   Basically it increases the random's maximum. and decreases the minimum distance from the center. 
                   It get's changed based on the avg frequency amount of the song playing each frame */

//Classes I made.
//  Unchanging values
final ModeController modeController = new ModeController();
final AudioBarGenerator barGen = new AudioBarGenerator();
final FrameController frame = new FrameController();
final InputController input = new InputController();
final SessionController session = new SessionController();

//Api stuff
final SoundCloud soundCloudAPI = new SoundCloud("8e4a0596a16e19f6b4b159b973ac7344", "https://www.dropbox.com/s/ic1bqsivp2vis18/callback.html"); //The two values required by the soundcloud API. Uses my personal account. Accesses a drop box html file provided by SoundCloud.

//  Changing values
//AudioPlayer player;
AudioPlayer player;
Minim minim;
FFT fft;
