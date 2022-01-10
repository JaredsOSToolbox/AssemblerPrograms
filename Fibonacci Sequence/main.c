// C-Code to be called

#include <stdio.h>
extern long fib(long n);

int main() {

  for(long n =0; n < 15; ++n){
      printf("%ld\n", fib(n));
  }
}
