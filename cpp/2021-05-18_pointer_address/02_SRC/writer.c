#include<stdio.h>
#include<unistd.h>
#include<sys/ipc.h>
#include<sys/shm.h>

#define KEY_NUM 3306
#define MEM_SIZE 1024

int main(void){

    int     shm_id;
    void*   shm_addr;
    int     count;

    shm_id = shmget((key_t)KEY_NUM, MEM_SIZE, IPC_CREAT | 0666);

    if(shm_id == -1){
        perror("shmget error : ");
        return 0;
    }   

    shm_addr = shmat(shm_id, (void*)0, 0);

    if((void*)-1 == shm_addr){
        perror("shmat error : ");
        return 0;
    }

    printf("Shared memory address : %p\n", shm_addr);

    count = 0;
	int cnt=0;
    while(cnt < 10)
	{
        sprintf((char*)shm_addr, "%d", count++);
		printf("write memory : %d\n", count);

        sleep(1);
		cnt++;
    }
	
	sleep(2);

	if(-1 == shmdt( shm_addr ))
	{
		printf("Separation shared memory failed\n");
		return -1;
	}

	if(-1 == shmctl( shm_id, IPC_RMID, shm_addr))
	{
		printf("erase shared memory failed\n");
		return -1;
	}

    return 0;
}
