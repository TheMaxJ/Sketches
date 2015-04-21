/*************************************
 * PRINTLIB
 * Max Johnson 2015
 * 
 * -Description-
 * Printlib is a framework designed to make 
 * adding beautiful debugging, logging, and warning
 * easy and efficient in processing sketches.
 * 
 * -Installation-
 * Simply copy/paste the contents of
 * This processing file into your sketch.
 * Optional- Copy/Paste any of my pre-built
 * PrintFormats from "PrintFormats.pde"
 * Optional- Copy/Paste any of my pre-built
 * Printers from "Printers.pde"
 *
 * See Test.pde for examples of usage.
 * If anyone wants it I can write up a guide,
 * just let me know.
 *************************************/

/*******************
 * Printers
 *******************/

class AdvancedPrinter<T> implements Printable{
  HashMap<T, PrintFormat> formats;
  PrintFormat lastUsed;
  
  AdvancedPrinter() {
    formats = new HashMap<T, PrintFormat>();
  }
  
  /*
   * Store a new printformat
   */
  void add(T k, PrintFormat pf) {
    formats.put(k, pf);
  }
  
  /**
   * Remove a stored PrintFormat
   */
  void remove(T k) {
    formats.remove(k);
  }
  
  /**
   * Print a message with the format stored under the given key
   */
  void p(T key, String s) {
    try {
      lastUsed = formats.get(key);
      p(s);
    } catch (NullPointerException npe) {
      println("ERROR: NO FORMAT FOUND FOR: " + key);
    }
  }
  
  /**
   * Only use this if you have already printed a message with this AdvancedPrinter
   * Prints a message with the last used format
   */
  void p(String s) {
    println(lastUsed.compile(s));
  }
  
  /**
   * See Printable interface
   */
  void br() {
    println("");
  }
}

class Printer implements Printable {
  PrintFormat pf; 
  
  Printer(PrintFormat pf) {
    this.pf = pf;
  }
  
  /**
   * Prints a message with the given format.
   */
  void p(String s) {
    println(pf.compile(s));
  }
  
  /**
   * See Printable interface
   */
  void br() {
    println("");
  }
}

/*******************
 * Interfaces And Abstracts
 *******************/

interface PrintFormat {
  String compile(String s);
}

interface Printable {
  /**
   * Basic printing method. See individual printers for details.
   */
  void p(String s);
  
  /**
   * Prints an empty line to the text window.
   */
  void br();
}

