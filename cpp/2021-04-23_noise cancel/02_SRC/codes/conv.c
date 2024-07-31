#include "conv.h"

void convolution(float h[], int len_h, float x[], int len_x, float* y, int len_y)
{
	int i, j, h_start, x_start, h_end;

	for(i = 0; i<len_y; i++)
	{
		h_start = i >= len_x ? i - len_x +1 : 0;
		h_end	= i >= len_h ? len_h -1		: i;
		x_start = i >= len_x ? len_x -1		: i;
		for(j = h_start; j<=h_end; j++)
		{
			y[i] += h[j] * x[x_start];
			x_start--;
		}
	}
}
