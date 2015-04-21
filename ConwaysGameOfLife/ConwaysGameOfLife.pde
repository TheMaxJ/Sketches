boolean[][] grid;
final int ALIVE = 0;
final int DEAD = 255;
int generation = 0;
void setup() {
  size(200,200);
  populateInitialGrid();
}

void draw() {
  println("Generation: " + ++generation);
  if (mousePressed) {
    rspawn((int)mouseX, (int) mouseY);
  }
  show();
  update();
}

/* Rules
Any live cell with less than two live neighbours dies, as if caused by under-population.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overcrowding.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
 */
void show() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      boolean alive = grid[x][y];
      if (alive) {
        stroke(ALIVE);
        fill(ALIVE);
      } else {
        stroke(DEAD);
        fill(DEAD);
      }
      point(x,y);
    }
  }
}
void update() {
  boolean[][] nextGen = new boolean[width][height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int nearby = calculateNearby(x, y);
      boolean alive = false;
      switch(nearby) {
      case 8:
      case 7:
      case 6:
      case 5:
      case 4:
      case 1:
      case 0:
        alive = false;
        break;
      case 3:
        alive = true;
        break;
      case 2:
        alive = grid[x][y];
        break;
      default:
        alive = false;
      }
      nextGen[x][y] = alive;
    } 
  }
  grid = nextGen;
}

int calculateNearby(int x, int y) {
  int total = 0;
  // Left
  if (grid.length - 1 > x && grid[x+1][y]) {
    total++;
  }
  // Right
  if (x > 0 && grid[x-1][y]) {
    total++;
  }
  // Down
  if (grid[x].length - 1 > y && grid[x][y+1]) {
    total++;
  }
  // Up
  if (y > 0 && grid[x][y-1]) {
    total++;
  }
  // Top-Right
  if (grid.length - 1 > x && y > 0 && grid[x+1][y-1]) {
    total++;
  }
  // Top-Left
  if (x > 0 && y > 0 && grid[x-1][y-1]) {
    total++;
  }
  // Bottom-Left
  if (x > 0 && grid[x].length - 1 > y && grid[x-1][y+1]) {
    total++;
  }
  // Bottom-Right
  if (grid.length - 1 > x && grid[x].length - 1 > y && grid[x+1][y+1]) {
    total++;
  }
  return total;
}

void populateInitialGrid() {
  // pop is now based on mouse
  grid = new boolean[width][height];
  int spawns = 100;
  for (int i = 0; i < spawns; i++) {
      rspawn((int)random(width-20)+10,(int)random(height-20)+10); 
  }
}

void rspawn(int x, int y) {
  // Left
  if (grid.length - 1 > x) {
    grid[x+1][y] = rbool();
  }
  // Right
  if (x > 0) {
    grid[x-1][y] = rbool();
  }
  // Down
  if (grid[x].length - 1 > y) {
    grid[x][y+1] = rbool();
  }
  // Up
  if (y > 0) {
    grid[x][y-1] = rbool();
  }
  // Top-Right
  if (grid.length - 1 > x && y > 0) {
    grid[x+1][y-1] = rbool();
  }
  // Top-Left
  if (x > 0 && y > 0) {
    grid[x-1][y-1] = rbool();
  }
  // Bottom-Left
  if (x > 0 && grid[x].length - 1 > y) {
    grid[x-1][y+1] = rbool();
  }
  // Bottom-Right
  if (grid.length - 1 > x && grid[x].length - 1 > y) {
    grid[x+1][y+1] = rbool();
  }
}

boolean rbool() {
  return (int) Math.round(random(1)) == 0;
}


