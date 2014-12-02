ArrayList<Integer> factors = new ArrayList<Integer>();
ArrayList<Integer> primes = new ArrayList<Integer>();

void setup() {
  int n = 495;
  populatePrimes(495);
  populateFactors(n);
  println(factors);
}

void populateFactors(int n) {
  if (primes.contains(n)) {
    factors.add(n);
    return;
  }
  
  for (int p : primes) {
    if (n % p == 0) {
      factors.add(p);
      populateFactors(n/p);
      break;
    }
  }
}

void populatePrimes(int n) {
  primes.add(2);
  for (int i = 3; i < n; i++) { 
    boolean isPrime = true;
    for (int p : primes) {
      if (i % p ==0) {
        isPrime = false;
        break;
      }
    }   
    if (isPrime) {
      primes.add(i); 
    }
  }
}
