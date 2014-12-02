class Source {
  private ArrayList<Node> nodes = new ArrayList<Node>();
  private PVector location;

  Source(PVector location) {
    this.location = location;
  }

  void update() {
    for (int i = 0; i < 5; i++) {
      PVector random_path = PVector.random2D();
      random_path.mult(random(10));
      nodes.add(new Node(location, random_path));
    }
    Node best = nodes.get(0);
    for (Node node : nodes) {
      if (node.calcFitness() < best.calcFitness()) {
        best = node;
      }
    }
    for (int i = 0; i < nodes.size(); i++) {
      Node node = nodes.get(i);
      node.update(best);
      if (node.dead) {
        nodes.remove(i);
        --i; // retrogress the counter because we removed an element
      }
    }
  }
}

