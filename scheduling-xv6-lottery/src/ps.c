#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

#define NPROC 64

int main(int argc, char *argv[])
{
  struct pstat pinfo = {0};
  if (getpinfo(&pinfo) == 0){
    printf(1, "PID\t|\tUSED?\t|\tTickets\t|\tTicks\n");
    int i;
    for(i=0;i<NPROC;i++){
      if (pinfo.pid[i] || pinfo.ticks[i]){
        printf(1, "%d\t|\t%d\t|\t%d\t|\t%d\n",
		pinfo.pid[i],
		pinfo.inuse[i],
		pinfo.tickets[i],
		pinfo.ticks[i]
		);
      }
    }
  }
  exit();
}
