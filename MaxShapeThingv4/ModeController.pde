/**
* Class that provides the current mode to the Frame controller, and certain info to the modes.
*/
public class ModeController {
  private ArrayList<Mode> allModes; //Editable list of modes for on-the-fly additions.
  private int framesSinceLastModeChange = 0; //Updates every frame. Reset on mode-change
  private int modeIndex = 0; //Which mode is being used currently. Index is applicable to allModes.
  /**
  * Constructor. Calls the getModes function to populate allModes
  */
  public ModeController() {
    allModes = getModes();
  }
  /**
  * Used by FrameController to get which mode should be used.
  */
  public Mode getMode() {
    Mode mode = allModes.get(modeIndex);
    framesSinceLastModeChange++;
    /* 
    Each mode has a specfic amount of frames it should play for.
    Check whether that amount has happened, if so, increment the modeIndex and start a new mode
    */
    if (framesSinceLastModeChange >= mode.getFrames()) {
      mode = next();
    }
    return mode;
  }
  public ArrayList<Mode> getModes() {
    ArrayList<Mode> modes = new ArrayList<Mode>();
    modes.add(new AllFlashMode());
    modes.add(new UpDownMode());
    modes.add(new LeftRightMode());
    modes.add(new WaveMode());
    modes.add(new RowMode());
    modes.add(new CollumMode());
    modes.add(new SnakeMode());
    modes.add(new InverseWaveMode());
    modes.add(new InverseRowMode());
    modes.add(new InverseCollumMode());
    modes.add(new InverseSnakeMode());
    return modes;
  }
  //Used mainly by the modes in calculations (See Modes)
  public int getModeFrames() {
    return framesSinceLastModeChange;
  }
  //Begins next mode and resets the frame counter
  public Mode next() {
    modeIndex = (modeIndex + 1) % allModes.size();
    framesSinceLastModeChange = 0;
    Mode mode = allModes.get(modeIndex);
    return mode;
  }
}

