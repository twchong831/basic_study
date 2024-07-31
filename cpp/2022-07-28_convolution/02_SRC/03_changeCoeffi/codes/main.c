#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "signalProcess.h"
#include "convolutionFilter.h"
#include "noiseFilter.h"

#include "parameter.h"

// Converting to radian
float radian(float angle) { return (angle * PI) / 180; }

int main()
{
	FILE* file_out1;
	file_out1 = fopen("out.txt", "w");

	//signal generation
	float harmonics[H][F];
	float polynomial[F];

	for(int i=0; i<F; i++)
	{
		int hi = 1;
		for(int j=0; j<H; j++)
		{
			harmonics[j][i] = generateSignal((float)(A/hi), hi, i);
			hi += 2;
		}
	}

	//noise generate
	for(int i=0; i<F; i++)
	{
		polynomial[i] = harmonics[0][i] + harmonics[3][i] + harmonics[15][i] + harmonics[30][i];
	}

	//convolution
	printf("convolution\n");
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
	//change coeffi.
	float resu[5][len_y];
	for(int i=0; i<5; i++)
	{
		for(int j=0; j<len_y; j++)
		{
			resu[i][j] = 0;
		}
//		h[0] += 0.1;
//		h[1] += 0.1;
//		h[2] += 0.1;
//		h[3] += 0.1;
		h[4] += 0.1;
		convolution(h, len_h, polynomial, len_x, resu[i], len_y);
	}

	//generate file
	for(int i=0; i<F/2; i++)
	{
		fprintf(file_out1, "%d\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n", 
							i, polynomial[i], y[i], resu[0][i],resu[1][i], resu[2][i], resu[3][i], resu[4][i]); 
	}

	puts("");
	fclose(file_out1);
	
	return 0;
}

