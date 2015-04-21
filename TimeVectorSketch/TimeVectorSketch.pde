import java.util.Calendar;

/**************
 * TIMEVECTOR *
 **************
 *
 * This is just a neat idea I had
 * for using Vector-like logic
 * On time as a linear progression
 * represented in milliseconds since epoch
 * Still a WIP, feel free to contribute any 
 * ideas you have.
 *
 * Max Johnson 2015
 */

public static class TimeVector {
  public long millis;
  
  public TimeVector(long millis) {
    this.millis = millis;
  }
  
  /* Instantiations */
  
  public static TimeVector now() {
    return new TimeVector(Calendar.getInstance().getTimeInMillis());
  }
  
  public static TimeVector fromSeconds(long t) {
    return new TimeVector(t * 1000);
  }
  
  public static TimeVector fromMinutes(long t) {
    return fromSeconds(t * 60);
  }
  
  public static TimeVector fromHours(long t) {
    return fromMinutes(t * 60);
  }
  
  public static TimeVector fromDays(long t) {
    return fromHours(t * 24);
  }
  
  public static TimeVector fromWeeks(long t) {
    return fromDays(t * 7);
  }
  
  public static TimeVector fromYears(long t) {
    return fromDays(t * 365);
  } 
  
  public TimeVector clone() {
    return new TimeVector(this.millis);
  }
  
  /* Operations */
  
  public TimeVector add(TimeVector vect) {
    this.millis += vect.millis;
    return this;
  }
  
  public TimeVector sub(TimeVector vect) {
    this.millis -= vect.millis;
    return this;
  }
  
  public TimeVector div(TimeVector vect) {
    this.millis /= vect.millis;
    return this;
  }
  
  /* Conversions */
  
  public Calendar toCalendar() {
    Calendar cal = Calendar.getInstance();
    cal.setTimeInMillis(millis);
    return cal;
  }
  
  public long inSeconds() {
    return millis/1000L;
  }
  
  public long inMinutes() {
    return inSeconds()/60L;
  }
  
  public long inHours() {
    return inMinutes()/60L;
  }
  
  public long inDays() {
    return inHours()/24L;
  }
  
  public long inWeeks() {
    return inDays()/7L;
  }

  public long inYears() {
    return inDays()/365L;
  }
  
  public String toString() {
    return ""+millis;
  }
  
  /**
   * Unit of time used by certain servers (Including Minecraft servers)
   * Under best-case circumstances (no lag), 20 ticks = 1 second.
   */
  public long inTicks() {
    return inSeconds()*20;
  }
  
  public String toDateString() {
    Calendar cal = this.toCalendar();
    return cal.get(Calendar.YEAR) + "-" +(cal.get(Calendar.MONTH)+1) + "-" + cal.get(Calendar.DAY_OF_MONTH);
  }
  
}

