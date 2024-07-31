#include <stdlib.h>
#include <stdio.h>

void convolution(float h[], int len_h, float x[], int len_x, float* y, int len_y)
{
	int i, j, h_start, x_start, h_end;

	for(i = 0; i<len_y; i++)
	{
		/*
		*	var1 ? var2 : var3
		*	--> var is true(1), value is var2
		*	--> var is false(0), value is var3
		*/
		h_start = i >= len_x ? i - len_x +1 : 0;
		/*
		*	len_x = 7
		*	h_start range : if i = 7~11 -> i - len_x +1 = 1~6	
		*/
		h_end	= i >= len_h ? len_h -1		: i;
		/*
		*	len_h = 5
		*	h_end range : if i = 5~11 -> len_h -1 = 4
		*/
		x_start = i >= len_x ? len_x -1		: i;
		/*
		*	len_x = 7
		*	x_start range : if i = 7~11 -> len_x-1 = 6
		*/

		for(j = h_start; j<=h_end; j++)
		{
			y[i] += h[j] * x[x_start];
			x_start--;
		}
		/*
		i = 0, h_start = 
		*/
	}
}

int main()
{
	float h[] = {1.0, 1.0, 1.0, 1.0, 1.0};
	float x[] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};

	int len_h = 5;
	int len_x = 7;
	int len_y = len_h + len_x -1;	//11
	float *y = (float*)malloc(sizeof(float) * len_y);

	for(int i=0; i<len_y; i++)
	{
		y[i] = 0.0;
	}

	convolution(h, len_h, x, len_x, y, len_y);

	for(int i=0; i<len_y; i++)
	{
		printf("%.0f ", y[i]);
	}
	puts("");
	free(y);

	return 0;
}
