public class InputController {
  private String typedText; //Keeps track of what's been written. Also used to display the text.

  SongFetcher songfetcher = new SongFetcher();
  public InputController() {
    typedText = "Search for a song or begin playing music on the computer.";
  }
  /**
   * Called on key-press by the main class. Uses code borrowed from the internet to gather key input.
   * "Enter & Return" case edited to update the session to the intro if it is a correctly entered song.
   */
  public void keyPressed() {
    //Only go further if it's a typing session.
    if (session.getSessionType() == 0) { 
      //Used to reset on the first keypress and after an error in finding a track.
      if (typedText.startsWith("Search") || typedText.startsWith("Track not found")) {
        typedText = "";
      }
      if (key != CODED) {
        switch(key) {
        case BACKSPACE:
          typedText = typedText.substring(0, max(0, typedText.length()-1));
          break;
        case TAB:
          break;
        case ENTER:
        case RETURN:
          Thread fetch = new Thread(songfetcher);
          fetch.start();
          break;
        case ESC:
        case DELETE:
          break;
        default:
          typedText += key; //Add it to the string
        }
      }
    }
  }
  /**
   * Called on mouse click by the main class. Decides which track to play.
   */
  public void mouseClicked() {
    if (session.getSessionType() == TYPING) {
      if (!frame.getSearchResults().isEmpty()) {
        for (SearchResult result : frame.getSearchResults ()) {
          if (result.isBeingTouched(mouseY)) {
            frame.finalizeTypingSession(result.getTrack());
          }
        }
      }
    }
  }
  /**
   * Used to populate the search result list. Changed to public for inputcontroller
   */

  /**
   * Gets the tracks that meet the title
   */
  private ArrayList<Track> searchForTracks(String search) {
    return soundCloudAPI.findTrack(search);
  }
  /**
   * Gets the typed text
   */
  public String getTyped() {
    return typedText;
  }
  /**
   * Sets Typed text
   */
  public void setTyped(String typed) {
    typedText = typed;
  }

  public class SongFetcher implements Runnable {
    int startY = 60;
    String text = "";
    public void run() {
      text = typedText;
      typedText = "Searching...";
      frame.resetSearchResults();
      for (Track track : input.searchForTracks(text)) {
        if (track != null && track.isStreamable()) {
          SearchResult result = new SearchResult(track, startY);
          frame.addSearchResults(result);
          startY += 55;
        }
      }
      searchDone = true;
    }
  }
}


