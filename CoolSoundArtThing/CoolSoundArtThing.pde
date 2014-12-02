import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim mnm;
AudioPlayer song;
FFT fft;
float specSize;
float avg;
float _RADIUS = 50;

void setup() {
  size(800,800);
  mnm = new Minim(this);
  song = mnm.loadFile("song.mp3");
  song.play();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  stroke(255);
}

void draw() {
  background(0);
  
  flakes();
  center();
  forward();
}

void center() {
  float increment = (2 * PI)/specSize;
  float angle = .5* PI;
  float line_width = (PI*2*_RADIUS) / specSize;
  strokeWeight(line_width);
  for (int i = 0; i < specSize; i++) {
    angle += increment;
    float x1 = width/2  + cos(angle) * 2*_RADIUS;
    float x2 = width/2  + cos(angle) * (2*_RADIUS+fft.getBand(i)/2);
    float y1 = height/2 + sin(angle) * 2*_RADIUS;
    float y2 = height/2 + sin(angle) * (2*_RADIUS+fft.getBand(i)/2);
    line(x1, y1, x2, y2);
  }
  
  float x = width/2, y = height/2;
  float w = 1;
  float r = PI/4;
  float i = 2;
  float ry = y + (avg < 8*_RADIUS/5 ? avg : 8*_RADIUS/5);
  float rx = x + (avg < 8*_RADIUS/5 ? avg : 8*_RADIUS/5);
  while(x < rx && x > 0 && y < ry && y > 0) {    
    line(x,y,(x+=cos(r)*(w)),(y+=sin(r)*w));
    w += i;
    r += PI/2;
  }  
}

void flakes() {
  int amount = (int) random(width);
  for (int i = 0; i < amount; i++) {
  }
}

void forward() {
  fft.forward(song.mix);
  specSize = fft.specSize() / 4; //Cut off 2/3 the spec, those are too low
  avg = fft.calcAvg(0, specSize);
}
