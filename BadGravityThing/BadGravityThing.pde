ArrayList<Planet> planets = new ArrayList<Planet>();
float G = 6.67384 * pow(10,-11); // Universal Gravitational Constant
PVector mDown;
Sun sun;

void setup() {
  size (500, 500);
  sun = new Sun();
  planets.add(sun);
  //noStroke();
}

void draw() {
  background(0);
  for (Planet planet : planets) {
    planet.update();
  }
}

void mousePressed() {
  mDown = new PVector(mouseX, mouseY);
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
    effectByGravity();
    location.add(velocity);
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
    gravity.add(force/mass, force/mass, 0);
    println(force);
    println(mass);
    println(force/mass);
    
    velocity.add(gravity);
    
    dist = this.location.dist(planet.location);
    if (dist <= radius) {
      PVector bounce = PVector.fromAngle(2 * velocity.heading() + PI);
      bounce.mult(force);
      velocity.add(bounce);
    }
  }
  
  void draw() { 
    ellipse(location.x, location.y, radius, radius);
  }
}

class Sun extends Planet {
  Sun() {
    super(10, 10000, new PVector(width/2, height/2), new PVector(0,0));
  }
  
  void effectByGravity() {
    //do nothing, because the sun is cool
  }
}
  
