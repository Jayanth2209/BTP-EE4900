#include <stdlib.h>

void __attribute__((noinline)) mt_mac( 
    int n,
    int m1[], int m2[], int a[],
    int res[])
{

  for (int i = 0; i < n; i++) {
    res[i] += ((m1[i]*m2[i]) + a[i]);
  }
}
