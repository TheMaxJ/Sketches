void setup() {
  // Printer test. Uses Title printformat
  Printer p = new Printer(new Title());
  p.p("Testing Basic Printer");
  p.br();
  
  // Advanced Printer test, uses Title and Subtitle format
  AdvancedPrinter<String> ap = new AdvancedPrinter<String>();
  ap.add("Title", new Title());
  ap.add("Subtitle", new Subtitle());
  
  ap.p("Title", "Testing titles with Advanced Printer");
  ap.p("Subtitle", "Testing subtitles with Advanced Printer");
  //Test lastUsed
  ap.p("This will be a subtitle too!");
  //Test error handling
  ap.p("HerpDerp", "This shouldn't print");
  ap.br();
  
  // Debugger test.
  Debugger debug = new Debugger();
  debug.p("Testing debugger");
  debug.br();
  
  // Titler test
  Titler titler = new Titler();
  titler.p(1, "Basic");
  titler.p(2, "Subtitle");
  titler.p(3, "Title");
  titler.p(4, "FancyTitle");
}

