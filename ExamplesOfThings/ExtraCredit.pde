public class ExtraCredit {
  // My data is called my members.

  // This is my constructor
  public ExtraCredit(String studentsName) {
    giveExtraCredit("Max"); // Ignore the parameter, give it to me.

    //This is a 2d array capable of storing the color of every pixel in the window
    int[][] iAmATwoDimensionalArray = new int[width][height];

    // This populates that 2dArray
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        iAmATwoDimensionalArray[x][y] = get(x, y);
      }
    }
    // Now it stores every color, in order, as x,y coords.
  }

  // This is a function being declared. It is private so only the class instance can see it.
  private void giveExtraCredit(String name) {
    println(name + " has received extra credit");
  }

  // Polygons can be draw as groups of vectors, starting with a beginShape() and ending with a endShape()
  // Images can be called with loadImage and image methods. They can also be called from internet URLs
  // sin(), asin(), cos(), acos(), tan(), and atan() are some of the trigonometric functions found in processing. They can be very useful for drawing with angles and circles.
  // sin(b) / tan(b) = Bill Cosby
  // Eclipse is a Java Integrated Developement Environment. (IDE)
  // A PVector is An entity that stores both a magnitude and a direction.
  // Shaders can be used to simulate lighting on 2d and 3d objects.
}

