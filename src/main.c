#include "ta_common.h"
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
  int outBeg = 0;
  int outNbElement = 0;

  // output values
  return_code =
    TA_MA(0, N - 1, close_price, 4, TA_MAType_SMA, &outBeg, &outNbElement, out);
  if (return_code != TA_SUCCESS) {
    fprintf(stderr, "TA_MA failed: %d\n", return_code);
    TA_Shutdown();
    return 1;
  }

  for (int i = 0; i < outNbElement; ++i) {
    int day = outBeg + i;
    printf("Day %d = %.4f\n", day, out[i]);
  }

  TA_Shutdown();
  return 0;
}
