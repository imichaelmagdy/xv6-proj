#include "types.h"
#include "user.h"

int main(void)
{
  int *p;
  p = (int *) sbrk(1);
  printf(1, "Memory location %p contents: %d\n", p, *p);
  printf(1, "Trying to overwrite with value 100...\n");
  *p =100;
  printf(1, "COMPLETED! memory location %p contents: %d\n", p, *p);
  mprotect((void *)p, sizeof(int));
  printf(1, "Used mprotect(), trying to overwrite with value 200...\n");
  *p =200;
  printf(1, "COMPLETED! memory location %p contents: %d\n", p, *p);
  exit();
}
