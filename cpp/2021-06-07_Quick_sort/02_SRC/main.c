#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define WIN_CLK
#ifdef	WIN_CLK
#include <windows.h>
#endif

#define MAX_SIZE 100000
#define SWAP(x, y, temp) ((temp)=(x), (x)=(y), (y)=(temp))

int partition(int list[], int left, int right)
{
	int pivot = 0;
	int temp = 0;
	int low =0;
	int high = 0;

	low = left;
	high = right + 1; 
	pivot = list[left];

	do
	{
		do
		{
			low++;
		}while(low <= right && list[low] < pivot);

		do
		{
			high--;
		}while(high >= left && list[high] > pivot);

		if(low <high)
		{
			SWAP(list[low], list[high], temp);
		}
	}while(low < high);

	SWAP(list[left], list[high], temp);

	return high;
}

void quick_sort(int list[], int left, int right)
{
	if(left < right)
	{
		int q = partition(list, left, right);

		quick_sort(list, left, q-1);
		quick_sort(list, q+1, right);
	}
}

int main()
{
	int i=0;
	int n = MAX_SIZE;

	srand((unsigned int) time(NULL));

	int list[n] = {0,};

	for(int i=0; i<n; i++)
	{
		list[i] = rand() % n + 1;
	}
#ifdef WIN_CLK
	LARGE_INTEGER	frequency;
	LARGE_INTEGER	start;
	LARGE_INTEGER	end;
	double			interval;
	QueryPerformanceFrequency(&frequency);
	QueryPerformanceCounter(&start);
#else
	clock_t cl_start = clock();
#endif

	quick_sort(list, 0, n-1);
#ifdef WIN_CLK
	QueryPerformanceCounter(&end);
	interval = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart;
	printf("processing time : %1f ms\n", interval*1000);
#else
	clock_t cl_end = clock() - cl_start;
	printf("processing time : %f ms\n", (double)((double)(cl_end)/CLOCKS_PER_SEC) * 1000.0);
#endif
	// for(int i=0; i<n; i++)
		// printf("%d\n", list[i]);

	return 0;
}
