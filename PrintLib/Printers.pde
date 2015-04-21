class Debugger extends Printer {
  Debugger() {
    super(new Debug());
  }
}

class Titler<Integer> extends AdvancedPrinter {
  Titler() {
    this.add(1, new Basic());
    this.add(2, new Subtitle());
    this.add(3, new Title());
    this.add(4, new FancyTitle());
  } 
}
