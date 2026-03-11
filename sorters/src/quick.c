#include "quick.h"
#include "comparator.h"
#include "swap.h"

void sortQuick(char **arr, int size) {
  char *p = arr[size / 2];
  int l = 0, r = size;

  while(l <= r) {
    while ( compare(p, arr[l]) ) {
      l++;
    }

    while ( compare(arr[r], p) ) {
      r--;
    }

    if (l <= r) {
      swap(&arr[l++], &arr[r--]);
    }
  }

  if (r > 0) {
    sortQuick(arr, r);
  }

  if (size > l) {
    sortQuick(arr + l, size - l);
  }
}
