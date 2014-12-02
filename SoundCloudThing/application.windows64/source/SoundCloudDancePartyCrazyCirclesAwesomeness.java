import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.voidplus.soundcloud.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SoundCloudDancePartyCrazyCirclesAwesomeness extends PApplet {





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
Minim minim;
FFT fft;
PImage albumArt;

//Main Setup method.
public void setup() {
  //Create window
  size(600,600); 
  //Setup Vars
  font = createFont("Helvetica", 18);
  minim = new Minim(this);
}

//Draw method (Called 60 times/second)
public void draw() {
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
  } else if (isValidUrl) {
    shouldPlayNextFrame = true;
  }
}

//This is the typing handler.
public void keyReleased() {
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
        Track track = soundCloudAPI.getTrack(Integer.parseInt(trackID));
        typedText = "Found track: " + track.getTitle();
        player = minim.loadFile(track.getStreamUrl());
        fft = new FFT(player.bufferSize(), player.sampleRate());
        albumArt = loadImage(track.getArtworkUrl());
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "SoundCloudDancePartyCrazyCirclesAwesomeness" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
