#include <stdlib.h>
#include <stdio.h>
#include <math.h>
// Converting to radian
#define PI 3.14
float radian(float angle) { return (angle * PI) / 180; }
// sampling frequency
#define F 200
// sampling period
#define T 1/F
// amplitude
#define A 5.0
//number of harmonics
#define H	32//16


extern void convolution(float h[], int len_h, float x[], int len_x, float* y, int len_y);

int main()
{
	FILE* file_out1;
	file_out1 = fopen("out.txt", "w");

	//signal generation
	float harmonics[H][F];
	float polynomial[F];

	for(int i=0; i<F; i++)
	{
		int hi = 1;			//frequency
		float sum = 0;
		polynomial[i] = 0;
		for(int j=0; j<H; j++)
		{
			float signal = (float)(A/hi) * sin(2 * PI * hi * T * i);	//
			harmonics[j][i] = signal;	//signal dump
			hi += 2;
		}
	}

	// selective signal accumulation (interferenced from external signal)
	for(int i=0; i<F; i++)
	{
		polynomial[i] = harmonics[0][i] + harmonics[20][i] + harmonics[10][i];
	}

	// convolution -- smoothing
	float h[] = {0.1, 0.1, 0.2, 0.2, 0.4};
	int len_h = 5;
	int len_x = F;
	int len_y = len_h + len_x -1;	//11
	float *y = (float*)malloc(sizeof(float) * len_y);

	for(int i=0; i<len_y; i++)
	{
		y[i] = 0.0;
	}

	convolution(h, len_h, polynomial, len_x, y, len_y);
	

	for(int i=0; i<F; i++)
	{
		fprintf(file_out1, "%d\t%.1f\t%.1f\n", i, polynomial[i], y[i]); 
	}

	puts("");
	free(y);
	fclose(file_out1);
	
	return 0;
}
