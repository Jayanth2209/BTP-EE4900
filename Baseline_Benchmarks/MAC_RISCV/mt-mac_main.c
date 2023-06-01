#include <stdlib.h>
#include <stdio.h>
#include "mt-mac.h"

//--------------------------------------------------------------------------
// Input/Reference Data

#include "dataset.h"


//--------------------------------------------------------------------------
// Main

int main()
{

  int result[DATA_SIZE];
  // Do MAC
  mt_mac(DATA_SIZE, input_data_m1, input_data_m2, input_data_a, result);

  printf("M1[0] = %d, M2[0] = %d, A[0] = %d\nRES[0] = %d and VERIF[0] = %d\n", input_data_m1[0], input_data_m2[0], input_data_a[0], result[0], verify_data[0]);
  
  return 0;

}
