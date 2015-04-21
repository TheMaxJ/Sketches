void setup() {
/* Uncomment these if you would like to test them,
 * But they take up space in the console for new tests
 * So I commented them out. 
 */
 
//  TimeVector vect = TimeVector.fromYears(1);
//  println(vect.inWeeks());
//  println(vect.inDays());
//  println(vect.inMinutes());
//  println(vect.inSeconds());

  // Let's get the date for three days from now
  TimeVector now = TimeVector.now();
  TimeVector three_days = TimeVector.fromDays(3);
  TimeVector in_three_days = now.add(three_days);
  println("The date three days from now will be " + in_three_days.toDateString());  
}

