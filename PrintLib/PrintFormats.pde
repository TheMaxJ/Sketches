class FancyTitle implements PrintFormat {
  String compile(String s) {
    return "-=-=-=- " + s + " -=-=-=-";
  }
}

class Title implements PrintFormat {
  String compile(String s) {
    return "---- " + s + " ----";
  }
}

class Subtitle implements PrintFormat {
  String compile(String s) {
    return "--- " + s + " ---";
  }
}

class Basic implements PrintFormat {
  String compile(String s) {
    return "- " + s + "-";
  }
}

class Debug implements PrintFormat {
  String compile(String s) {
    return "[Debug] " + s;
  }
}

