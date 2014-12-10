class Node {
  PVector location; 
  Field field;
  Node previous;
  int G;

  Node(Field field, PVector location) {
    this.location = location.get();
    this.field = field;
  }

  void setPrev(Node previous) {  
    this.previous = previous;
    this.G = previous.G + 1;
  }

  void path() {
    stroke(PATH_COLOR);
    point(location.x, location.y);
  }

  void open(Node prev) {
    if (!(this instanceof Edge)) {
      if (!field.open.contains(this) && !field.closed.contains(this)) {
        setPrev(prev);
        field.open.add(this);
        _point(OPEN_COLOR);
      }
    }
  }

  void close() {
    if (field.open.contains(this)) {
      field.open.remove(this);
    }
    field.closed.add(this);
    _point(CLOSE_COLOR);
  }
  
  void _point(int c) {
    if (showProgress) {
      stroke(c);
      point(location.x, location.y);
    }
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
    return (int) (this.location.dist(field.target)) + G;
  }

  void openAt(int x, int y) {
    if(x >= 0 && y >= 0 && x < field.nodes.length && y < field.nodes[0].length) {
      field.nodes[x][y].open(this);
    }
  }

  void traceBack(Node node) {
    node.path();
    if (node.previous != node) {
      traceBack(node.previous);
    }
  }
}

