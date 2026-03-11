#include "insertion.h"
#include "comparator.h"
#include "swap.h"

void sortInsertion(char **arr, int size) {
  for(int i = 1; i < size; i++) {
    for(int j = i; j > 0 && compare(arr[j-1], arr[j]) > 0; j--) {
      swap(&arr[j], &arr[j - 1]);
    }
  }
}
