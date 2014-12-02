public class AudioBarGenerator {
  /**
   * Called every frame. Draws 2 mirrored versions of the audiobars of the song.
   */
  public void draw() {
    stroke(0);
    //Draws the left side,
    for (int i = 0; i < fft.specSize (); i++) {
      line(i, height, i, height - fft.getBand(i) * 100);
    }
    //Draws the right side.
    for (int i = width; width - i < fft.specSize (); i--) {
      line(i, height, i, height - fft.getBand(width - i) * 100);
    }
  }
}

