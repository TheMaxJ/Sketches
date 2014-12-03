// Radix Sort
ArrayList<Integer> list = new ArrayList<Integer>();

for (int i = 0; i < 10; i++) {
   list.add((int)random(10000));
}

println("Unsorted:");
println(list);

int k = 0;
int pos = 0;
do {
  ArrayList<Integer> pass = new ArrayList<Integer>();
  int[][] buckets = new int[10][list.size()];
  for (int i = 0; i < list.size(); i++) {
    int index = list.get(i);
    int digit;
    String string = String.valueOf(index);
    try {
      digit = Integer.parseInt(String.valueOf(string.charAt(string.length() - pos)));
    } catch (StringIndexOutOfBoundsException ex) {
      digit = 0;
    }
    buckets[digit][i] = index;
  }
  list.clear();
  for (int[] bucket : buckets) {
    for (int i : bucket) {
      if (i != 0) {
        list.add(i);
      }
    }
  }
  println("Pass: " + pos);
  println(list);
  pos++;
  k++;
} while(k < 5);


