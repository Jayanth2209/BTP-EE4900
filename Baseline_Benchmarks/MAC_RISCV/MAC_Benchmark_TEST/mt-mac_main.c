#include <stdlib.h>
#include <stdio.h>
#include<stdint.h>

//--------------------------------------------------------------------------
// Input/Reference Data
#include "dataset.h"
//--------------------------------------------------------------------------

void __attribute__((noinline)) mt_mac( 
    int n,
    int m1[], int m2[], int a[],
    int res[])
{

  for (int i = 0; i < n; i++) {
    res[i] += ((m1[i]*m2[i]) + a[i]);
  }
}

uint64_t read_cycles() {
  uint64_t cycle = 0;
  asm volatile ("rdcycle %0" : "=r" (cycle));
  return cycle;
}
// Main

int main()
{

  uint64_t start, end;

  int result[DATA_SIZE];

  start = read_cycles();

  mt_mac(DATA_SIZE, input_data_m1, input_data_m2, input_data_a, result);

  end = read_cycles();

  printf("\nData Size = %d\nM1[0] = %d, M2[0] = %d, A[0] = %d\nRES[0] = %d and VERIF[0] = %d\n", DATA_SIZE, input_data_m1[0], input_data_m2[0], input_data_a[0], result[0], verify_data[0]);
  printf("\nCycles = %d\n", (end-start));
  return 0;

}
