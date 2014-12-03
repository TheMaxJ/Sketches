ArrayList<Planet> planets = new ArrayList<Planet>();
float G = 6.67384 * pow(10,-11);
PVector mDown;

void setup() {
  size (500, 500);
  println(G);
  planets.add(new Planet(10, Float.MAX_VALUE, new PVector(width/2, height/2), new PVector(0,0)));
}

void draw() {
  background(0);
  for (Planet planet : planets) {
    planet.update();
  }
}

void mousePressed() {
  mDown = new PVector(mouseX, mouseY);
  //planets.add(new Planet(20, 50000, new PVector(mouseX, mouseY), PVector.random2D()));
}

void mouseReleased() {
  PVector mUp = new PVector(mouseX, mouseY);
  PVector location = mUp.get();
  PVector velocity = mUp.get();
  
  velocity.sub(mDown);
  velocity.rotate(PI);
  velocity.div(20);
  
  planets.add(new Planet(5, 1000, location, velocity));
}

class Planet {
  float mass;
  float radius;
  PVector velocity;
  PVector location;
  
  Planet(float r, float m, PVector starting_location, PVector starting_velocity) {
    mass = m;
    radius = r;
    velocity = starting_velocity.get();
    velocity.mult(random(3));
    location = starting_location.get();
  }
  
  void update() {
    location.add(velocity);
    effectByGravity();
    draw();
  }
  
  void effectByGravity() {
    for (Planet planet : planets) {
      if (!planet.equals(this)) {
        gravitateTowards(planet);
      }
    }
  }
  
  void gravitateTowards(Planet planet) {
    float dist = this.location.dist(planet.location);
    float mass2 = planet.mass;
    
    float force = (G * mass * mass2) / pow(dist, 2);
    PVector gravity = planet.location.get();
    gravity.sub(location);
    gravity.normalize();
    
    println(force);
    location.add(gravity);
    
    dist = this.location.dist(planet.location);
    if (dist <= radius) {
      velocity.rotate(PI);
    } 
  }
  
  void draw() { 
    ellipse(location.x, location.y, radius, radius);
  }
}
  
