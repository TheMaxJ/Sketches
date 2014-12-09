class AsyncInformer implements Runnable {
  
  Field field;
  
  AsyncInformer(Field field) {
    this.field = field;
  }
   
  public void run() {
    while(!field.finished) {
      long time = (millis()-millis)/1000 + 1; //+1 is a hackish divide/0 fix
      long processed = field.closed.size();
      println("--- " +time+ " seconds. ---");
      println("Processed: " + processed);
      println("Queued: " + field.open.size());
      println("Rate: " +(processed/time)+ " nodes/second");
      try {
        Thread.sleep(1000);
      } catch (Exception ex) {
        ex.printStackTrace();
      }
    }
  } 
}
