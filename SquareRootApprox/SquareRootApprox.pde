final float TO_FIND = 1111;
float pos = 0;

void setup() {
  size(1000, 100);
  stroke(255, 0, 0);
  background(0);
}

void draw() {
  if (frameCount == 1) {
    Thread thread = new Thread(new ASR(TO_FIND));
    thread.start();
  }
}

class ASR implements Runnable {
  float target;

  public ASR(float target) {
    this.target = target;
  }

  public void run() {
    approxSqrt(target, 0, TO_FIND);
  }

  void approxSqrt(float goal, float start, float stop) {    
    float avg = (start+stop)/2.0;
    float sqrd = avg * avg;
    
    pos = map(avg, 0, TO_FIND, 0, 1000);
    line(pos, 0, pos, height);

    if (abs(goal-sqrd) < .0001) {
      println("Found approx. square root: " + avg);
      stroke(255);
    } else if (sqrd > goal) {
      approxSqrt(goal, start, avg);
    } else {
      approxSqrt(goal, avg, stop);
    }
  }
}

