public class AudioBarGenerator {
  /**
   * Called every frame. Draws 2 mirrored versions of the audiobars of the song in the format of black lines
   */
  /**
   * Called every frame. Draws 2 mirrored versions of the audiobars of the song.
   */
  public void draw() {
    float increment = (2 * PI)/fft.specSize();
    float angle = .5* PI;
    float _RADIUS = 75;
    float specSize = fft.specSize();
    float avg = fft.calcAvg(20,20000);
    float line_width = (PI*2*100) / fft.specSize();
    strokeWeight(line_width);
    for (int i = 0; i < fft.specSize(); i++) {
      angle += increment;
      float x1 = width/2  + cos(angle) * 2*_RADIUS;
      float x2 = width/2  + cos(angle) * (2*_RADIUS+fft.getBand(i));
      float y1 = height/2 + sin(angle) * 2*_RADIUS;
      float y2 = height/2 + sin(angle) * (2*_RADIUS+fft.getBand(i));
      line(x1, y1, x2, y2);
    }
  }
}

