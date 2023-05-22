// Compile me with: clang -c mul.c -o mul.o
int sum(int a, int b) {
  int i = 0;
  int sum = 0;
  for (i = 0;i < b;i++) {
      sum += a;
  }
  return sum;
}
