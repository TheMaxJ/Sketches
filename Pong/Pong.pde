float left_x, left_y, right_x, right_y;
float ball_x, ball_y, pball_x, pball_y;
int r = 10;
int w = 20;
int h = 100;

float angle;

int p1score = 0, p2score = 0;

void setup() {

  size(500, 500);

  newRound();

  rectMode(CENTER);
  ellipseMode(RADIUS);
  fill(0);
  textSize(24);
  textAlign(CENTER, BOTTOM);
  frameRate(240);
}

void draw() {
  background(255);

  if (keyPressed) {
    movePaddles();
  }

  updateBars();
  updateBall();
  updateScore();
}

void updateBars() {
  rect(left_x, left_y, w, h);
  rect(right_x, right_y, w, h);
}

void updateBall() {
  ellipse(ball_x, ball_y, r, r);

  if (isTouchingPaddle()) {}
  if (isTouchingEdges()){}
  if (isTouchingGoal()) {
    newRound();
  }
  moveBallByAngle();

  pball_x = ball_x;
  pball_y = ball_y;
}

void updateScore() {
  text(p1score + " - " + p2score, width/2, 50);
}

// add break
boolean isTouchingPaddle() {
  float touching_x = -999, touching_y = -999;
  float bx = ball_x;
  float by = ball_y;
  float px = bx > width/2 ? right_x : left_x;
  float py = px == right_x ? right_y : left_y;
  float d = 0;
  for (float x = px-w/2; x < px + w/2; x++) {
    d = dist(x, px + (by>px?h/2:-h/2), bx, by);
    if (d <= r) {
      touching_x = x;
      touching_y = px + (by>px?h/2:-h/2);
    }
  }
  for (float y = py-h/2; y < py+h/2; y++) {
    d = dist(px + (bx>px?w/2:-w/2), y, bx, by);
    if (d <= r) {
      touching_y = y;
      touching_x = px + (bx>px?w/2:-w/2);
    }
  }
  if (touching_x != -999 && touching_y != -999) {
    angle += PI + atan((touching_x-bx)/(touching_y-by));
    return true;
  }
  return false;
}

boolean isTouchingEdges() {
  float touching_x = -999, touching_y = -999;
  // pre-calculate next frame
  float bx = ball_x;
  float by = ball_y;
  float d = 0;
  float ey = ball_y > height/2 ? height : 0;
  
  for (int x = 0; x < width; x++) {
    d = dist(x,ey,bx,by);
    if (d <= r) {
      touching_x = x;
      touching_y = ey;
    }
  }
  if (touching_x != -999 && touching_y != -999) {
    angle += PI + atan((touching_x-bx)/(touching_y-by));
    return true;
  }
  return false;
}

boolean isTouchingGoal() {
  float touching_x = -999, touching_y = -999;
  // pre-calculate next frame
  float bx = ball_x;
  float by = ball_y;
  float d = 0;
  float ex = ball_x > width/2 ? width : 0;
  
  for (int y = 0; y < height; y++) {
    d = dist(ex,y,bx,by);
    if (d <= r) {
      if (ex == 0) {
        p2score++;
      } else {
        p1score++;
      }
      return true;
    }
  }
  return false;
}

void moveBallByAngle() {
  ball_x = ball_x + cos(angle);
  ball_y = ball_y + sin(angle);
}

void movePaddles() {
  switch (key) {
  case 'w':
    left_y += -2;
    break;
  case 's':
    left_y += 2;
    break;
  case 'i':
    right_y += -2;
    break;
  case 'k':
    right_y += 2;
    break;
  }
}

void newRound() {
  left_x = width/20;
  left_y = height/2;
  right_x = width - width/20;
  right_y = height/2;

  ball_x = width/2;
  ball_y = height/2;
  angle = ((int)random(2)) * PI; //Random starting direction
}

