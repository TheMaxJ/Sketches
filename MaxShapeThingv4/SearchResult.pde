public class SearchResult {
  private Track track; //stores the track that this result represents
  private int startY;
  private PImage albumArt;
  private PFont font;

  public SearchResult(Track result, int y) {
    track = result;
    startY = y;
    println(track.getTitle());
    try {
      albumArt = loadImage(track.getArtworkUrl());
    } 
    catch (Exception e) {
      albumArt = loadImage("http://frs102.net/wp-content/uploads/2013/06/FRS-102-WHITE-SQUARE.jpg");
    }
    albumArt.resize(40, 40);
    font = createFont("Helvetica", 18);
  }
  public void draw() {
    stroke(SEARCH_BAR_BORDER_COLOR);
    fill(SEARCH_BAR_INNER_COLOR);
    rect(15, startY, width-50, 50);
    image(albumArt, 15 + 5, startY + 5);
    textFont(font, 18);
    fill(TEXT_COLOR_2);
    text(track.getTitle(), 15 + 55 + 10, startY + 9 + 10);
  }
  public Track getTrack() {
    return track;
  }
  public boolean isBeingTouched(int y) {
    return y > startY && y < startY + 50;
  }
}

