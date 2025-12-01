#include "ta_common.h"
#include "ta_defs.h"
#include "ta_func.h"
#include "ta_libc.h"
#include <stdio.h>

int main(void) {

  // return code declaration
  TA_RetCode return_code;

  // initialized TA-Lib
  return_code = TA_Initialize();
  if (return_code != TA_SUCCESS) {
    fprintf(stderr, "TA_Initialize failed: %d\n", return_code);
    return 1;
  }

  // construct close prices
  // as a number sequence
  const int N = 20;
  TA_Real close_price[N];
  for (int i = 0; i < N; ++i) {
    close_price[i] = (TA_Real)(i + 1);
  }

  // construct output containers
  //
  TA_Real out[N];
  double *realupperband = out;
  double *realmiddleband = out + 1 * N;
  double *reallowerband = out + 2 * N;
  int outBeg = 0;
  int outNbElement = 0;

  // output values
  return_code =
    TA_BBANDS(
      0, 
      N - 1, 
      close_price, 
      4, 
      4.0,
      4.0,
      TA_MAType_SMA,
      &outBeg, 
      &outNbElement, 
      realupperband,
      realmiddleband,
      reallowerband
  );

  if (return_code != TA_SUCCESS) {
    fprintf(stderr, "TA_MA failed: %d\n", return_code);
    TA_Shutdown();
    return 1;
  }

  for (int i = 0; i < outNbElement; ++i) {
    int day = outBeg + i;
    printf("Day %d = %.4f\n,%.4f\n, %.4f\n", day, out[i], out[i + N], out[i + 2*N]);
  }

  TA_Shutdown();
  return 0;
}


/*
Day 19 = 20.7361
,18.5000
, 16.2639
*/