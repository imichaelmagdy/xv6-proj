#include "types.h"
#include "stat.h"
#include "user.h"

int
main (int argc, char* argv[])
{
  int *ptr;
  ptr = 0;
  printf(1, "NULL pointer value: %p\n", *ptr);
  exit();
}
