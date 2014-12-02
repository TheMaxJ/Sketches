void setup() {
  size(400,400);
  float x = width/2, y = height/2;
  float w = 1;
  float r = PI/4;
  float i = 2;
  
  while(x < width && x > 0 && y < height && y > 0) {    
    line(x,y,(x+=cos(r)*(w)),(y+=sin(r)*w));
    w += i;
    r += PI/2;
  }  
}

