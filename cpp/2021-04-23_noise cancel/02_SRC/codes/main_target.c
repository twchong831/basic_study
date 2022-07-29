#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "signalProcess.h"
#include "conv.h"
#include "noiseFilter.h"

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

	// selective signal accumulation (interferenced from external signal)
	for(int i=0; i<F; i++)
	{
		polynomial[i] = harmonics[0][i] + harmonics[3][i] + harmonics[30][i];
	}

	// identify the freq components in the given noisy signal
	float freq_component = 0;
	float noiseFiletered[F];
	int probe_freq = 7;	//7hz
	freq_component = probe(noiseFiletered, F, (float)(A/F), probe_freq);
	printf("%dhz component is %.3f\n", probe_freq, freq_component);

	//compoensate
	float K = A/probe_freq;		//you have to search this parameter
	for(int i=0; i<F; i++)
	{
		noiseFiletered[i] = filtering(polynomial[i], K, probe_freq, (float)T*i);
	}

	float h[] = {0.1, 0.1, 0.2, 0.2, 0.4};
	int len_h = 5;
	int len_x = F;
	int len_y = len_h + len_x -1;	//11
	float *y = (float*)malloc(sizeof(float) * len_y);

	for(int i=0; i<len_y; i++)
	{
		y[i] = 0.0;
	}

	convolution(h, len_h, noiseFiletered, len_x, y, len_y);
	

	for(int i=0; i<F; i++)
	{
		fprintf(file_out1, "%d\t%.1f\t%.1f\t%.1f\t%.1f\n", i, polynomial[i], noiseFiletered[i], y[i], harmonics[0][i]); 
	}

	puts("");
	free(y);
	fclose(file_out1);
	
	return 0;
}

