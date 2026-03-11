#include <stdio.h>
#include "printStrings.h"

void printStrings(char** strings, int stringsNumber, int fileSize) {
	int i = 0;
	int j = 0;

	while (j < stringsNumber && i < fileSize - 1) {
    while (strings[j][i] != '\n') {
      printf("%c", strings[j][i++]);
    }

    j++;
    i = 0;
    printf("\n");
  }
}
