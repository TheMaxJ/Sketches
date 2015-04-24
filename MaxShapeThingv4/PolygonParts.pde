/**
* All-important class that draws each shape by drawing the corners.
*/
public class RepeatedPolygon { 
  int cx = 0;
  int cy = 0;
  /**
  * Constructor also draws the shape.
  */
  public RepeatedPolygon(int x, int y, int index, ModeController controller) {
    cx = x;
    cy = y;
    //Calls the provided mode to get how it should color.
    int c = ANIMATION_OBJECT_COLOR; 
    stroke(c);
    noFill();
    //Draws the 4 corners. Starts index at 1 (inclusive), ends at 5 (exclusive). (4 total)
    for (int i = 1; i < 5; i++) {
      pushMatrix();
      translate(x, y);
      CornerPolygon corner = new CornerPolygon(i);
      corner.drawMe();
      popMatrix();
    }
  }
}
/**
* Class that actually draws the shape. Draws individual corners.
*/
public class CornerPolygon {
  private int direction; //Which direction? Starts at 1, ends at 4.
  private int vertexCount;
  
  public CornerPolygon (int d) {
    direction = d;
    vertexCount = (int) ((random(3) + 2) * fft.calcAvg(20,20000));
  }
  //Unused constructor. Might be useful in the future.
  public CornerPolygon(int d, int vc) {
    direction = d;
    vertexCount = vc;
  }
  /**
  * Calculates the points to be drawn.
  * Draws each one as a bottom-right. They are then rotated.
  */
  public void drawCorner(int cx, int cy) {
    int[][] points = new int[2][vertexCount + 3];
    //TopRight
    points[0][0] = cx + R_RADIUS;
    points[1][0] = cy;
    //Center
    points[0][1] = cx;
    points[1][1] = cy;
    //BottomLeft
    points[0][2] = cx;
    points[1][2] = cy + R_RADIUS;
    /*
    Somewhat complicated. Starts at 1.5 Radians (bottom right.)
    Then it divides the remaining sector of of the circle evenly amongst the vertecies
    Then it choosen random points a certain distance away. 
    Then it calls the method that will draw the custom shape
    */
    for (int i = 0; i < vertexCount; i++) {
      float a = 1.5 * PI + ((PI/2) / vertexCount) * (i + 1);
      float r = random(R_RADIUS - (R_RADIUS - R_LIMIT)) + R_RADIUS - R_LIMIT;
      int x = (int) abs(cx + r * cos(a));
      int y = (int) abs(cy + r * sin(a));
      points[0][i+3] = cx + x;
      points[1][i+3] = cy + y;
    }
    drawShapeByVertexes(points);
  }
  /**
  * Draws a custom shape based on a list of points. (2d array).
  */
  public void drawShapeByVertexes(int[][] points) {
    beginShape();
    for (int j = 0; j < vertexCount + 3; j++) {
      vertex(points[0][j], points[1][j]);
    }
    endShape();
  }
  /*
  * Draws the corner as a bottom right then rotates it.
  * Also spaces them 2 pixels away from eachother.
  */
  public void drawMe() {
    int bcx = 0; //Bottom Corner x
    int bcy = 0; //Bottom Corner Y
    switch(direction) {
    case 1:
      //Top left
      pushMatrix();
      rotate(PI);
      bcx += -2;
      bcy += -2;
      drawCorner(bcx, bcy);
      popMatrix();
      break;
    case 2:
      //top right
      pushMatrix();
      rotate(PI/2);
      bcx += 2;
      bcy += -2;
      drawCorner(bcx, bcy);
      popMatrix();
      break;
    case 3:
      //bottom right
      pushMatrix();
      bcx += 2;
      bcy += 2;
      drawCorner(bcx, bcy);
      popMatrix();
      break;
    case 4:
      //bottom left
      pushMatrix();
      rotate(-PI/2);
      bcx += -2;
      bcy += 2;
      drawCorner(bcx, bcy);
      popMatrix();
      break;
    default:
      // Do nothing, not possible
    }
  }
  
  //Basic getters and setters
  
  public int getDirection() {
    return direction;
  }
  public void setDirection(int i) {
    direction = i;
  }
  public int getVertexes() {
    return vertexCount;
  }
  public void setVertexCount(int i) {
    vertexCount = i;
  }
}

