final int AMOUNT = 200;
Node[] nodes = new Node[AMOUNT];
PVector target;
Source source1;
Source source2;

void setup() {
  size(400, 400);
  PVector origin = new PVector(width/2, height/2);
  target = randomVector();
  for (int i = 0; i < AMOUNT; i++) {
    nodes[i] = new Node(randomVector(), PVector.random2D());
  }
  source1 = new Source(randomVector());
  source2 = new Source(randomVector());

  frameRate(120);
}

void draw() {
  background(100);
  target = new PVector(mouseX, mouseY);
  source1.update();
  source2.update();
  ellipse(target.x, target.y, 20, 20);
}

PVector randomVector() {
  return new PVector(random(width), random(height));
}

// Reset the swarm
void mouseClicked() {
  for (Node node : source1.nodes) {
    node.location = randomVector();
  }
  for (Node node : source2.nodes) {
    node.location = randomVector();
  }
}

