#include <iostream>

int main()
{
	uint16_t BIT = 0;
	for(int i=0; i<16; i++)
	{
		BIT |= 1 << i;
		printf("val : %x\n", BIT);
	}
	return 0;
}
