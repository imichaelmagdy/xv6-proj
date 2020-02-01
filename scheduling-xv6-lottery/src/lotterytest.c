#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
  if (argc == 2){
    int t = atoi(argv[1]);
    settickets(t);
    while(1)
      ;
  }
  exit();
}
