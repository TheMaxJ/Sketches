import de.voidplus.soundcloud.*;

public class FrameController {
  private PFont font;
  private int trackID; //Id of the track. Soundcloud stores songs as IDs in its API.
  private ArrayList<SearchResult> searchResults; //Used to store search results.
  private Track currentTrack; //Type Track from the soundcloud api library.
  private ArrayList<BeatMarker> beats;

  /**
   *  Constructor, sets up var values/initializing
   */
  public FrameController() {
    font = createFont("Helvetica", 18);
    trackID = 0;
    searchResults = new ArrayList<SearchResult>();
    beats = new ArrayList<BeatMarker>();
  }
  /**
   * Called every frame by void draw(). Decides which "draw" method to use.
   */
  public void update() {
    switch (session.getSessionType()) {
    case TYPING: //Typing
      drawTyping();
      break;
    case INTRO: //Intro
      drawIntro();
      break;
    case SONG: //Song playing. Main animation
      drawSong();
      break;
    default:
    }
  }
  /**
   * Begins intro session and sets up the song session
   */
  public void finalizeTypingSession(Track track) {
    currentTrack = track;
    player2 = minim.loadFile(currentTrack.getStreamUrl());
    fft = new FFT(player2.bufferSize(), player2.sampleRate());
    session.startIntroSession(); //Updates session type
  }
  /**
   * Draws Typed Text on a black background.
   */
  private void drawTyping() {
    background(BACKGROUND_COLOR);
    fft = new FFT(player.bufferSize(), player.sampleRate());
    fft.forward(player.mix);
    beat.detect(player.mix);
    if (isBeat()) {
      session.startSongSession();
    }
    drawSearchBar();
    fill(TEXT_COLOR_2); //White Font
    textFont(font, 18);
    updateText();
    displayResults();
  }
  /**
   * Just throwing a bit of humor in there because why not.
   */
  private void drawIntro() {
    drawBackground();
    session.startSongSession();
    player2.play();
  }
  /**
   * This is the important part. Plays that animation I made in class.
   */
  private void drawSong() {
    //Runs fft calulations
    if (player2 != null) {
      fft.forward(player2.mix);
      beat.detect(player2.mix);
    } else {
      fft.forward(player.mix);
      beat.detect(player.mix);
    }
    updateSong();
    //Returns to typing if the song is over to get a new song.
    //if (!player.isPlaying()) {
    // session.startTypingSession();
    //}
  }
  /**
   * Called based on how loud the song is. Might mess with the threshold a bit.
   */
  private void updateSong() {
    drawBackground(); //Simple method at the moment. Just draws the background.

    // Starts graphics here
    //    Mode mode = modeController.getMode(); //Gets the type of animation to play. (See Mode and Modes files)
    R_LIMIT = getFFTAvg() * 10; //The randomness var. See Global Vars.
    //    int index = 0; //Used to calculate how many have been drawn. Used by certain Modes.
    //    for (int y = EDGE_BUFFER+R_RADIUS; y < width-EDGE_BUFFER; y+=SPACING) {
    //      for (int x = EDGE_BUFFER+R_RADIUS; x < height-EDGE_BUFFER; x+=SPACING) {
    //        index++;
    //        RepeatedPolygon poly = new RepeatedPolygon(x, y, index, modeController, mode);
    //      }
    //    }
    RepeatedPolygon poly = new RepeatedPolygon(width/2, height/2, 0, modeController);
    barGen.draw();
    if (isBeat()) {
      beats.add(new BeatMarker());
    }
    
    for (int i = 0; i < beats.size(); i++) {
      BeatMarker marker = beats.get(i);
      if (marker.r > width) {
        beats.remove(marker);
      } else {
        marker.draw();
        i++;
      }
    }
  }
  /**
   * Super simple background method. Probably doesn't need its own method, but I might add to the background.
   */
  private void drawBackground() {
    background(BACKGROUND_COLOR);
    if (isBeat()) {
      
    }
  }
  /**
   * Used to draw the search bar.
   */
  private void drawSearchBar() {
    fill(SEARCH_BAR_INNER_COLOR);
    stroke(SEARCH_BAR_BORDER_COLOR);
    rect(15, 15, width-50, 27);
  }
  /**
   * Used to draw the search bar text
   */
  public void updateText() {
    //Following code adds the blinking underscore
    text(input.getTyped() + (frameCount/10 % 2 == 0 ? "|" : ""), 35, 35);
  }
  /**
   * Used to display the results
   */
  private void displayResults() {
    for (SearchResult result : searchResults) {
      result.draw();
    }
  }
  /**
   * Calculates average band width of each frequency, adds them together, then averages.
   */
  private float getFFTAvg() {
    return fft.calcAvg(0, fft.specSize()) / 10;
  }
  /**
   * Uses fft's built in average calc to decide whether it is loud enough.
   */
  private boolean isBeat() {
    return beat.isHat();
  }
  /**
   * gets search results
   */
  public ArrayList<SearchResult> getSearchResults() {
    return searchResults;
  }
  /**
   * sets search results
   */
  public void setSearchResults(ArrayList<SearchResult> results) {
    searchResults = results;
  }
  /**
   * Adds to the search results
   */
  public void addSearchResults(SearchResult... results) {
    for (SearchResult result : results) {
      if (result.getTrack().isStreamable()) {
        searchResults.add(result);
      }
    }
  }
  /**
   * resets search results
   */
  public void resetSearchResults() {
    searchResults = new ArrayList<SearchResult>();
  }
}

public class BeatMarker {
  
  private int r = 300;    
  
  public void draw() {
    noFill();
    stroke(BEATMARKER_COLOR, 255 - (r * .4));
    ellipse(width/2.0,height/2.0,r,r);
    r+=25;
  }
}

