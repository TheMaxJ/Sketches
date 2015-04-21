public class SessionController {
  private int type; //Type of session
  private int framesSinceLastSessionChange; //Frames counter
  
  /**
  * Constructor. Initializes vars.
  */
  public SessionController() {
    type = TYPING;
    framesSinceLastSessionChange = 0;
  }
  //Sets session type and resets frame counter
  private void setSessionType(int newType) {
    type = newType;
    framesSinceLastSessionChange = 0;
  }
  //These all set the session to various modes.
  public void startTypingSession() {
    setSessionType(TYPING); //0 == typing
  }
  public void startIntroSession() {
    setSessionType(INTRO); //1 == Intro
  }
  public void startSongSession() {
    setSessionType(SONG); //2 == song is playing 
  }
  //Basic getters
  /**
  * Increments the frame counter and gets the type
  */
  public int getSessionType() {
    framesSinceLastSessionChange++;
    return type;
  }
  public int getSessionFrames() {
    return framesSinceLastSessionChange;
  }
}
