class Node {
  private PVector location;
  private PVector pmove;
  private boolean dead;
  
  public Node(PVector origin, PVector vector) {
    pmove = vector;
    vector.mult(10);
    location = origin.get();
    location.add(vector);
  }

  public void update(PVector fittest_location) {
    PVector path = fittest_location.get();
    path.sub(location);
    path.normalize();
    location.add(path);
    ellipse(location.x, location.y, 1, 1);
    
    dead = location.dist(target) < 10; 
  }

  public void update(Node fittest) {
    update(fittest.location);
  }
  
  public float calcFitness() {
    return pow(this.location.dist(target),2);
  }
}
