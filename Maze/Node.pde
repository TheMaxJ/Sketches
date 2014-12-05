class Field {

  PVector source;
  PVector target;

  boolean finished = false;

  Node[][] nodes;

  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Node> closed = new ArrayList<Node>();
  ArrayList<Edge> edges = new ArrayList<Edge>();

  Field(PImage image, PVector source, PVector target) {
    this.source = source;
    this.target = target;
    populate(image);
    for (Node[] nodeArr : nodes) {
      for (Node node : nodeArr) {
        if (node.location.x == source.x && node.location.y == source.y) {
          node.open(node);
          node.setState(PATH);
        } else if (node instanceof Edge) {
          edges.add((Edge)node);
        } else {
//          node.open(node);
        }
      }
    }
  }

  void populate(PImage image) {
    nodes = new Node[width][height];
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        color c = image.get(x, y);
        if (c == color(0)) {
          nodes[x][y] = new Edge(this, new PVector(x, y));
        } else {
          nodes[x][y] = new Node(this, new PVector(x, y));
        }
      }
    }
  }

  void update() {
    for (Node node : open) {
      node.update();
    }
    for (Node node : closed) {
      node.update();
    }
  }

  void execute() {
    if (!finished) {
      Node best = getBest();
      best.close();
      if (best.location.dist(field.target) >= 1) {
        best.openAdjacent();
      } else {
        best.setState(PATH);
        finished = true;
        best.traceBack(best);
      }
      println(best.location.toString());
      update();
    }
  }

  Node getBest() {
    Node currentBest = null;
    for (Node node : open) {
      if (currentBest == null || currentBest.calc() > node.calc()) {
        currentBest = node;
      }
    }
    if (currentBest == null) {
      println(open.size());
    }
    return currentBest;
  }
}

class Node {
  PVector location; 
  int state;
  Field field;
  Node previous;
  int G;

  Node(Field field, PVector location) {
    this.location = location.get();
    state = UNCHECKED;
    this.field = field;
  }

  void setPrev(Node previous) {  
    this.previous = previous;
    this.G = previous.G + 1;
  }

  void update() {
    fill(state);
    stroke(state);
    point(location.x, location.y);
  }

  void setState(int s) {
    state = s;
  }

  void open(Node prev) {
    if (!(this instanceof Edge)) {
      if (!field.open.contains(this) && !field.closed.contains(this)) {
        setPrev(prev);
        field.open.add(this);
        state = UNCHECKED;
      }
    }
  }

  void close() {
    if (field.open.contains(this)) {
      field.open.remove(this);
    }
    field.closed.add(this);
    this.state = CLOSED;
  }

  void openAdjacent() {
    int x = (int) location.x;
    int y = (int) location.y;

    openAt(x+1, y);
    openAt(x-1, y);
    openAt(x, y+1);
    openAt(x, y-1);

    openAt(x+1, y+1);
    openAt(x+1, y-1);
    openAt(x-1, y-1);
    openAt(x-1, y+1);
  }

  int calc() {
    return (int) (this.location.dist(field.target)) + 10 * G;
  }

  void openAt(int x, int y) {
    try {
      field.nodes[x][y].open(this);
    } 
    catch(ArrayIndexOutOfBoundsException ex) {
    }
  }

  void traceBack(Node node) {
    node.setState(PATH);
    if (node.previous != node) {
      traceBack(node.previous);
    } else {
      println("Finished");
    }
  }
}

class Edge extends Node {
  Edge(Field field, PVector location) {
    super(field, location);
    state = EDGE;
  }
}

