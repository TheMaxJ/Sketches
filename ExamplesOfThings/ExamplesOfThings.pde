/****************************************
 * Max Johnson
 *
 * One-Week Challenge
 * Due: Firday, Nov. 14, by 11:59 pm
 * Coding as Art - "November Challenge"
 ****************************************/


/* 
 * Syntax describes the "grammar" and structure of code, and its many conventions.
 * 
 * For examples of proper style, see either of the following
 * http://www.oracle.com/technetwork/java/codeconvtoc-136057.html
 * https://google-styleguide.googlecode.com/svn/trunk/javaguide.html
 * 
 * Some peole are evil and do not indent their code.
 * Dante's lesser-known 10th circle of hell is reserved for such attrocities. 
 */

int iAmAnInt = 1; // I can be any whole number integer between 0 and +- 2^32-1
boolean iAmABoolean = true; // I can be true or false (Or more technically 0 or 1)
float iAmAFloat = 1.5; // I am a floating-point decimal
char iAmAChar = 'a'; // I am a ASCII character, with a value from 0 to 255
color iAmAColor = color(0, 0, 0); // Hexadecimal integer based on Red, Green, and Blue values. HSB mode works based on Hue Saturation and Brightness.
// Colors can also be changed based on Alpha values (Transperancy), Hues, and Saturation.
// Alpha is based on a scale of 0-255, with 0 being invisible, and 255 being fully visible.

String iAmAString = "I am a string, I represent an unmutuable char array";

public static String publicStaticString = "I can be accessed by any class at runtime, and do not change in between my instances";
public String publicString = "I can be accessed by any class at runtime as long as they have an instance of my class";
private static String privateStaticString = "I can be accessed by any instance of my own class, but not by any others. I do not change between instances";
private String privateString = "I can only be accessed by my own class, and I change in between instances";

void unusedMethodToMakeAPoint() {
  String localString = "I can only be seen in this specific call of this method";
}
// I would talk about protected, but that is not important in processing for the most part

int declared; //I have been declared, but I have no value. The heap has room for me though.
int initialized = 1; //I have been declared and initiliazed with a value of 1, and have been added to the stack

// Separate (See setup)
int aboutToBeInitializedButFirstIWillBeDeclared;

void doMath() {
  newSection("Basic Math");
  println("Addition of 5+2 -> " + (5+2));
  println("Subtraction of 5-2 -> " + (5-2));
  println("Multiplication of 5*2 -> " + (5*2));
  println("Division of 5/2 -> " + (5F/2F));

  newSection("Mapping Values");
  println("Maps map values from one scale to their equivalent in another. We will now map '5' from a scale of 1-10 to 6 on a scale of 1-12");
  println("map(5, 1, 10, 1, 12) -> " + map(5, 0, 10, 0, 12));

  newSection("Unary Operations");
  int five = 5; //Wouldn't want that to change
  println("Unarys increment variables by -1 or +1, either before evaluation or after");
  println("Pre-Evaluation Unary --5, I will be one less -> " + --five); // I get changed before I get printed;
  five = 5;
  println("Post-Evaluation Unary 5--, I will still be five until the next line of code -> "+ five--);
  println("See, now I am one less -> " + five);
  println("++ works the same way, but with a positive increment of one");

  newSection("In-place Addition operations");
  five = 5;
  println("Now I will be incremented by 2 with +=2 -> " + (five+=2) + " If I had used -=2 it would be the same as += -2");
}

void setup() {
  newSection("Void Setup");
  println("I am void setup, and I run as soon as the program starts. I am used to choose the initial settings and initilialize variables");

  newSection("Math");
  println("Let's do some math");
  doMath();

  newSection("FrameRate");
  println("The framerate is " + frameRate + " frames/second"); // I am a variable that changes the refresh rate in terms of updates/second

  // Settings
  size(200, 200); //Lets make our window 200px by 200px. This method takes in two arguments, width and height, in terms of pixels
  background(iAmAColor); //We just gave our square a black background
  stroke(255);

  newSection("Methods");
  // Writing println takes too long. We will use this method to abbreviate it
  pr("See?"); // I am a function call. I run the code of the function with my given parameter(s)

  newSection("Overloading");
  pr("Let's run that again, but with our overloaded char[] version");
  char[] chars = new char[] {
    'S', 'e', 'e', '?'
  }; // I am an array, a fixed-length set of a certain type. I am the most efficient form of a collection.
  pr(chars);

  println("The processing println function is overloaded as well: it can take multiple types of variables");
  println(iAmAnInt);
  println(iAmAString);
  println(iAmAFloat);
  println("These are only three of the types that one can print.");

  newSection("While Loops");
  println("Starting while loop. We're going to use an int variable to count to ten.");
  int counter = 1;
  while (counter <= 10) {
    print(counter++ + " ");
    // I am a while loop. I re-run code until my boolean is false. This will run once.
  }
  println("\nNo more while loop. Look at our outstanding counting prowess.");
  println("While loops work by first evaluating a boolean statement, in this case whether we have reached 10");
  println("And then running code in the brackets. As you can see, we increment counter (Using the post-evaluation unary)");
  println("at the same time as we print it. Once it finished the code, it repeats the process by checking our new counter.");
  println("It stops once counter <= 10");

  newSection("If Statements");
  if (true) {
    println("An if statement does it's imbedded code if it is given a true boolean");
  }
  if (false) {
    println("I will not print");
  }

  newSection("Advanced Boolean Logic");
  println("&& and || signify AND and OR statements.");
  println("true && true -> " + (true && true));
  println("true && false -> " + (true && false));
  println("false && false -> " + (false && false));
  println("true || true -> " + (true || true));
  println("true || false -> " + (true || false));
  println("false || false -> " + (false || false));

  newSection("Advancedier Boolean Logic (XOR)");
  println("^ is known as the XOR statement. It acts like || except it is true if only one is true");
  println("true ^ true -> "  + (true ^ true));
  println("true ^ false -> " + (true ^ false));
  println("false ^ false -> " + (false ^ false));
  
  newSection("Bitwise Operators");
  println("Into the rabbit hole we go, Alice");
  println("~ is the unary bitwise operator. It flips all of the bits. (Every 1 becomes and 0, and visa versa)");
  println("~1011 -> 0100");
  println("a << b is the left-shift. It discards the front-bit and adds a 0 to the end (b times)");
  println("1011 << 2 -> 1100");
  println("a >> b is the unsigned bitwise right-shift. It drops the last bit, and adds a 0 to the front (b times)");
  println("1011 >> 2 -> 0010");
  
  // newSection("Comments");
  // Comments are cool because they explain stuff (See everything so far)
  // Comments can also be used for TODO lists and giving advice
  // To other developers.
  // This is a single line comment. It comments a single line.
  // println("This will not get printed, because it is a comment")

  /*
   * This is a
   * Multi-line
   * comment. It comments
   * multiple lines
   */

  /*
   * They are very usefule for writing Haikus
   * 
   * Title- The Duality of Man
   * 
   * This program is dumb
   * But this poem is awesome
   * Multi-line comment
   *
   * Copyright @ Max Johnson 2014
   */

  /**
   * This is a doc-comment used by Javadocs. You can tell because it has two stars.
   * This comment won't do anything in processing, so I am not sure why I mentioned it.
   */

  // print() adds something to the console text-output.
  // println() appends "\n" to the print() method, creating a new line.
  // They can be used to keep track of variables and conditions during runtime.

  // Keyboard input calls the keyPressed() and keyReleased() methods, where the key is stored as 'key'
  // key-char that was pressed; keyCode-a set of codes that point to non-letter keys such as the directional arrows
  // keyPressed is a boolean that returns whether the key is currently held down.
  // keyPressed is called on key depresssion; keyReleased(), when the key is released.
  // Mouse input calls mouseClicked(), mouseMoved(), mousePressed(), and mouseReleased()
  // mouseX- Current x-coord of the mouse; mouseY- current y-coord
  // p- prefix is the previous frame's coordinate.
  // mouseReleased() and mousePressed() work like their key- counterparts
  // mouseClicked() requires mousePressed() and mouseReleased() to be called in rapid succession
  // mouseMoved() is called on x,y change in mouse location
  // mouseMoved() is called every frame if the mouse has moved in between that and the previous frame

  newSection("Extra-Credit");
  // Extra Credit. Let's give grant some.
  ExtraCredit extracredit = new ExtraCredit("Grant");
  // Whoops, it looks like it went to me instead.
}

void draw() {
  background(iAmAColor);

  // Remember our old pal frameRate? I get called *frameRate* times per second automatically. I am used to update what the user sees over time or based on input.
  // We're also going to use matricies to randomly movie our text about the window.
  pushMatrix(); //I just started a Matrix
  // Code here (Such as translate(), rotate(), scale()) will change the position of what comes next
  translate(random(width), random(height));
  textSize(72);
  text(frameCount, 0, 0); // frameCount++ is automatically run after this method.
  // That was an example of how text is drawn.
  popMatrix(); // I Stop the Matrix

  /*
   * When to use Matrices:
   * Moving multiple of the same type, or moving things with relative relations but no absolute
   * When drawing a shape that will be repeated based on an input multiple times.
   * For example, each corner of my MaxShapeThing polygons is drawn the same way, then use matricies to shift them to the right position
   * Do not use them when drawing only one shape, or when drawing shapes with absolute-hardcoded coords
   */
}

// I am a function declaration, I decide what happens when I am called.
void pr(String s) { 
  // S is a parameter, it is used to change the output of our method
  println(s);
}

//I am an overloaded version of pr that takes a char array instead of a string
void pr(char[] chars) { 
  String s = "";
  
  //I turn the char[] into a string. I am a for-loop. I can be a foreach style forloop with Class varname : Collection of Class
  // Or I can be incremental, with for (Class name = startingValue; boolean conditional; final statement, normally incrementation.
  for (char c : chars) s+=c; 
  
  pr(s);
}

// I keep this crazy program organized.
void newSection(String title) {
  println("\n-=-=-=- How it Be: " + title + " -=-=-=-");
}

