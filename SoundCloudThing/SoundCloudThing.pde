import de.voidplus.soundcloud.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

SoundCloud soundCloudAPI = new SoundCloud(
  "39f78cd9832ba1d7dc42b9a01393ea4",
  "111e9e55e95d9e27721bbf1c4a610c8b"
);

String typedText = "Enter video id: ";
String trackID = "";

boolean isValidUrl = false;
boolean shouldPlayNextFrame;

PFont font;

AudioPlayer player;
AudioInput in;
Track loaded;
Minim minim;
FFT fft;
PImage albumArt;

//Main Setup method.
void setup() {
  //Create window
  size(600,600); 
  //Setup Vars
  font = createFont("Helvetica", 18);
  minim = new Minim(this);
}

//Draw method (Called 60 times/second)
void draw() {
  background(0,0,0); //Black
  fill(255); //White
  textFont(font,18);
  //Following code adds the blinking underscore
  text(typedText+(frameCount/10 % 2 == 0 ? "_" : " "), 35, 35);
  
  //Only call after the audio has been found.
  if (shouldPlayNextFrame) {
    player.play(); //play audio.
    image(albumArt,0,0,600,600); //album art.
    //Call foward on the fft. Not sure what this does :P
    fft.forward(player.mix);
    
    //Begin to draw the objects
    //Setup lines
    strokeWeight(10);
    
    //Setup matrix
    pushMatrix();
    translate(0,-180);
    
    int total = 0; //this will be used to make an average.
    //Draw the veticle lines
    for (int i = 0; i < 600; i+=10) {
      stroke(random(255), random(255), random(255)); //Random colors
      //Draws both sets up lines.
      line(300 + i, height * 4/5, 300 + i, height * 4/5 - fft.getBand(i/10)*3);
      line(300 - i, height * 4/5, 300 - i, height * 4/5 + fft.getBand(i/10)*3);
      total += fft.getBand(i/10) * 4; //Sums up all bands
    }
    int avg = total/50;
    //Close matrix
    popMatrix();
    
    strokeWeight(2); //Change thickness
    //This draws the crazy cirle waveform thing. Got to this by messing with some public code.
    stroke(0,0,0);
    fill(20,20,20);
    for (int i = 0; i < player.left.size() - 3; i += 3) {
      ellipse(
        i,300 + player.left.get(i)*100, 
        player.mix.get(i)*30, 
        player.left.get(i)*30
      ); //Draws each circle.
    }
    fill(0,0,0,50); //Make it black and somewhat transparant.
    while (avg > 0) {
      stroke(random(255),random(255),random(255));
      ellipse(300, 300, avg * 5, avg * 5);
      avg = avg - 4; //Minus 4 because it will subtract 20 once multiplied by 5.
    }
    //ProgressBar
    double duration = loaded.getDuration();
    double currentTime = player.position();   
    strokeWeight(1.3);  
    for (float px = 20; px < (600-20); px++) {
      int hex = #141414;
      println(currentTime / duration + ":" + px/(600-20));
      if((px/(600-20) <= (currentTime/duration))) {
        hex = #0066FF;
      }
      stroke(hex);
      line(px,580,px,575);
    }  
  } else if (isValidUrl) {
    shouldPlayNextFrame = true;
  }
}

//This is the typing handler.
void keyReleased() {
  if (typedText.startsWith("Enter") || typedText.startsWith("Track not found")) {
    typedText = ""; //reset if error or first keypress.
  }
  if (key != CODED) {
    switch(key) {
    case BACKSPACE:
      typedText = typedText.substring(0,max(0,typedText.length()-1));
      break;
    case TAB:
      break;
    case ENTER:
    case RETURN:
      //Attempt to get track
      trackID = typedText;
      typedText = "Getting track";
      try {
        loaded = soundCloudAPI.getTrack(Integer.parseInt(trackID));
        typedText = "Found track: " + loaded.getTitle();
        player = minim.loadFile(loaded.getStreamUrl());
        fft = new FFT(player.bufferSize(), player.sampleRate());
        albumArt = loadImage(loaded.getArtworkUrl());
        isValidUrl = true;
      } catch (Exception e) {
        typedText = "Track not found!";
      }
      break;
    case ESC:
    case DELETE:
      break;
    default:
      typedText += key;
    }
  }
}
