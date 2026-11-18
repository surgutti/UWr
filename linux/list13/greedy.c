#include <stdlib.h>
#include <stdio.h>


int main(int argc, char **argv) {
  if (argc != 2) {
    printf("Usage: %s <memory to allocate in bytes>\n", argv[0]);
    return EXIT_FAILURE;
  }

  size_t size = strtoull(argv[1], 0, 10);
  printf("Allocating %llu bytes\n", size);
  void* data = malloc(size);

  for (size_t i = 0; i < size; i++) {
    ((unsigned char*)data)[i] = 0;
  }

  free(data);

  puts("Success");

  return EXIT_SUCCESS;
}
