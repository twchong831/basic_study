#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

#define SIZE	10
int main()
{
	unsigned char*array;
	array = (unsigned char*)malloc(sizeof(unsigned char)*SIZE);

	for(int i=0; i<SIZE; i++)
	{
		array[i] = i;
	}

	printf("check pointer array address : %x\n", array);	//address
//	printf("check pointer array address : %x\n", &array);	//address of address?
	printf("check pointer array address : %d\n", array);
//	printf("check pointer array address : %d\n", &array);
	printf("check value : %d\n", array[0]);

	while(1)
	{
		Sleep(2000);
		printf("client loop....\n");
	}

	free(array);

	return 0;
}
