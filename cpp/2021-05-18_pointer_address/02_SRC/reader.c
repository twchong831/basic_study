#include <stdio.h>      // printf()
#include <unistd.h>     // sleep()
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>

#define  KEY_NUM     3306
#define  MEM_SIZE    1024

int main( void){
   int   shm_id;
   void *shm_addr;

   if ( -1 == ( shm_id = shmget( (key_t)KEY_NUM, MEM_SIZE, IPC_CREAT | 0666)))
   {
		// IPC_CREAT : generate shared memory
		// 0666 : shared memory used authority
		printf( "shared memoty generate failed\n");
		return -1;
   }

    if ( ( void *)-1 == ( shm_addr = shmat( shm_id, ( void *)0, 0))){
        printf( "shared memort add failed\n");
        return -1;
    }

    printf("start address of shared memory : %p\n", shm_addr);

	int cnt=0;
	while( cnt < 10 )
	{
		printf( "Data read from shared mem :   %s\n", (char *)shm_addr);
		sleep( 1);
		cnt++;
	}
	return 0;
}
