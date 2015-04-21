/**
* Interface that provides the structure to the different modes.
*/
public interface Mode {
  /** 
  * Get whether it should be visible.
  * @param ModeController used to certain calculations
  * @param the x coord of the shape
  * @param the y coord of the shape
  * @param the amount of rows
  * @param the amount of collums
  * @param the index of the shape
  */
  public int getColor(ModeController controller, int cx, int cy, int indexOf); 
  /** 
  * Get the amount of frames that have been drawn during the current mode.
  */
  public int getFrames(); 
}
