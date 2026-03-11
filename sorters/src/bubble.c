#include "bubble.h"
#include "comparator.h"
#include "swap.h"

void sortBubble(char **arr, int size) {
  int n = size - 1;

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; ++j) {
      if (compare(arr[j], arr[j+1]) > 0) {
        swap(&arr[j], &arr[j+1]);
      }
    }
  }
}
