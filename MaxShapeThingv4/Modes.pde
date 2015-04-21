/**
* Implements Mode interface.
* Does the pulse-like animation.
*/
public class WaveMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int window_x = width/2;
    int window_y = height/2;
    int stage = controller.getModeFrames() % ROWS;
    int dx = (int) (dist(window_x, window_y, cx, window_y));
    int dy = (int) (dist(window_x, window_y, window_x, cy));
    dx = (int) dx/SPACING;
    dy = (int) dy/SPACING;
    if ((dx == stage && dy < stage) || (dy == stage && dx < stage)) { //This gets all that are the right distance except the corners
      return BACKGROUND_COLOR;
    } else if (dx == stage && dy == stage) { //this gets the corners.
      return BACKGROUND_COLOR;
    } else {
      return ANIMATION_OBJECT_COLOR;
    }
  }
  public int getFrames() {
    return ROWS;
  }
}
/**
* Implements Mode interface.
* Same as WaveMode except colors are reversed.
* See WaveMode comments.
*/
public class InverseWaveMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int window_x = width/2;
    int window_y = height/2;
    int stage = controller.getModeFrames() % ROWS;
    int dx = (int) (dist(window_x, window_y, cx, window_y));
    int dy = (int) (dist(window_x, window_y, window_x, cy));
    dx = (int) dx/SPACING;
    dy = (int) dy/SPACING;
    if ((dx == stage && dy < stage) || (dy == stage && dx < stage)) {
      return ANIMATION_OBJECT_COLOR;
    } else if (dx == stage && dy == stage) {
      return ANIMATION_OBJECT_COLOR;
    } else {
      return BACKGROUND_COLOR;
    }
  }
  public int getFrames() {
    return ROWS;
  }
}
/**
* Implements Mode interface.
* Alternates between the top and bottom halves.
*/
public class UpDownMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
     //Will parse as being true every other frame.
    if (frameCount % 2 == 1) { 
      //check which half it is in
      if (cy < width/2) { 
        return ANIMATION_OBJECT_COLOR;
      }
    } else {
      //check which half it is in
      if (cy > width/2) {
        return ANIMATION_OBJECT_COLOR;
      }
    }
    return BACKGROUND_COLOR;
  }
  public int getFrames() {
    return 10; //Arbitrary amount of frames to play
  }
}
/**
* Implements Mode interface.
* Alternates between the left and right halves.
* See UpDownMode comments.
*/
public class LeftRightMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    if (frameCount % 2 == 1) {
      if (cx < width/2) {
        return ANIMATION_OBJECT_COLOR;
      }
    } else {
      if (cx > width/2) {
        return ANIMATION_OBJECT_COLOR;
      }
    }
    return BACKGROUND_COLOR;
  }
  public int getFrames() {
    return 10; //Arbitrary amount of frames to play
  }
}
/**
* Implements Mode interface.
* Alternates between all and none
*/
public class AllFlashMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    return frameCount % 2 == 1 ? BACKGROUND_COLOR : 0; //Will parse true every other frame.
  }
  public int getFrames() {
    return 10; //Arbitrary amount of frames to play
  }
}
/**
* Implements Mode interface.
* Highlights the rows in order
*/
public class RowMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = ROWS;
    //Calculates which row to color based on the amount of frames played so far during the mode.
    int toColor = controller.getModeFrames() % ROWS; 
    int row = indexOf % ROWS;
    if (row == toColor) {
      return BACKGROUND_COLOR;
    } else {
      return ANIMATION_OBJECT_COLOR;
    }
  }
  public int getFrames() {
    return ROWS * 2;
  }
}
/**
* Implements Mode interface.
* Highlights the collums in order
* See RowMode comments.
*/
public class CollumMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = COLLUMS;
    int toColor = controller.getModeFrames() % COLLUMS;
    int collum = indexOf % COLLUMS;
    if (collum == toColor) {
      return BACKGROUND_COLOR;
    } else {
      return ANIMATION_OBJECT_COLOR;
    }
  }
  public int getFrames() {
    return COLLUMS * 2;
  }
}
/**
* Implements Mode interface.
* Zig-zag pattern.
* See RowMode comments.
*/
public class SnakeMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = ROWS * COLLUMS;
    int toColor = controller.getModeFrames() % total;
    if (indexOf == toColor) {
      return BACKGROUND_COLOR;
    } else {
      return ANIMATION_OBJECT_COLOR;
    }
  }
  public int getFrames() {
    return ROWS * COLLUMS * 2;
  }
}
/**
* Implements Mode interface.
* Same as SnakeMode but opposite colors.
* See SnakeMode comments
*/
public class InverseSnakeMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = ROWS * COLLUMS;
    int toColor = controller.getModeFrames() % total;
    if (indexOf == toColor) {
      return ANIMATION_OBJECT_COLOR;
    } else {
      return BACKGROUND_COLOR;
    }
  }
  public int getFrames() {
    return ROWS * COLLUMS * 2;
  }
}
/**
* Implements Mode interface.
* RowMode but opposite colors
* See SnakeMode comments
*/
public class InverseRowMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = ROWS;
    int toColor = controller.getModeFrames() % ROWS;
    int row = indexOf % ROWS;
    if (row == toColor) {
      return ANIMATION_OBJECT_COLOR;
    } else {
      return BACKGROUND_COLOR;
    }
  }
  public int getFrames() {
    return ROWS * 2;
  }
}
/**
* Implements Mode interface.
* Collum mode but opposite colors
*/
public class InverseCollumMode implements Mode {
  public int getColor(ModeController controller, int cx, int cy, int indexOf) {
    int total = COLLUMS;
    int toColor = controller.getModeFrames() % COLLUMS;
    int collum = indexOf % COLLUMS;
    if (collum == toColor) {
      return ANIMATION_OBJECT_COLOR;
    } else {
      return BACKGROUND_COLOR;
    }
  }
  public int getFrames() {
    return COLLUMS * 2;
  }
}


