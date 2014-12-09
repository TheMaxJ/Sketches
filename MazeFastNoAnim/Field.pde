class Field {

  PVector source;
  PVector target;

  boolean finished = false;

  Node[][] nodes;

  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Edge> edges = new ArrayList<Edge>();
  ArrayList<Node> closed = new ArrayList<Node>();

  Field(PImage image, PVector source, PVector target) {
    this.source = source;
    this.target = target;
    populate(image);

    // Open the source-node.
    Node sourceNode = nodes[(int)source.x][(int)source.y];
    sourceNode.open(sourceNode); // It is its own parent node.
  }

  void populate(PImage image) {
    nodes = new Node[width][height];
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        if (image.get(x, y) != color(0)) {
          nodes[x][y] = new Node(this, new PVector(x, y));
        } else {
          nodes[x][y] = new Edge(this, new PVector(x, y));
        }
      }
    }
  }

  public void run() {
    while (!finished) {
      Node best = getBest();
      best.close();
      if (best.location.dist(field.target) >= 1) {
        best.openAdjacent();
      } else {
        finished = true;
        best.traceBack(best);
      }
    }
    println("Finished. Took " + (millis()-millis) + "ms.");
  }

  Node getBest() {
    Node currentBest = null;
    for (Node node : open) {
      if (currentBest == null || currentBest.calc() > node.calc()) {
        currentBest = node;
      }
    }
    return currentBest;
  }
}

