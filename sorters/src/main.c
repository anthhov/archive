#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "bubble.h"
#include "insertion.h"
#include "quick.h"
#include "merge.h"
#include "printStrings.h"

int main(int argc, char **argv) {
  int stringsNumber = atoi(argv[1]);
  struct stat buff;
  int fdin;

  if ( (fdin = open(argv[2], O_RDONLY, 0)) < 0 ) {
    printf("Error, file open failed.\n");
    exit(1);
  }

  if (fstat(fdin, &buff) < 0) {
    printf("Error, fstat failed.\n" );
    exit(1);
  }

  if (!buff.st_size) {
    printf("File is empty.\n");
    return 0;
  }

  char *file = (char*)mmap(0, buff.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fdin, 0);

  // mmap should return the address at which the mapping was placed

  if (file == MAP_FAILED) {
    printf("Error, MMAP failed.\n");
    exit(1);
  }

  file[buff.st_size - 1] = '\n';
  char** strings = (char**)malloc(sizeof(char*) * stringsNumber);

  int i = 1;
  int j = 0;

  // pointer to the first string

  strings[0] = file;

  while (i != stringsNumber && j != buff.st_size) {
	  if (file[j++] == '\n') {
      strings[i++] = &(file[j]);
    }
  }

  if (stringsNumber > i) {
    stringsNumber = i - 1;
  }

  printf("\nChoose sorting method\n[1] bubble sort\n[2] insertion sort\n[3] quick sort\n[4] merge sort\n");

  int done = 0, choice = 0;

  do {
    if (scanf("%d", &choice) == 1)
      switch (choice) {
      case 1:
        sortBubble(strings, stringsNumber);
        done = 1;
        break;

      case 2:
        sortInsertion(strings, stringsNumber);
        done = 1;
        break;

      case 3:
        sortQuick(strings, stringsNumber - 1);
        done = 1;
        break;

      case 4:
        sortMerge(strings, 0, stringsNumber - 1);
        done = 1;
        break;

      default:
        break;
      }
  } while (!done);

  printStrings(strings, stringsNumber, buff.st_size);

  free(strings);
  return 0;
}
