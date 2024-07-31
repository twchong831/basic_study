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
		polynomial[i] = harmonics[0][i] + harmonics[10][i] + harmonics[20][i];
	}

	// identify the freq components in the given noisy signal
	float freq_component = 0;
	int probe_freq = 21;	//7hz
	for(int i=0; i<F; i++)
	{
		float probe = (float)(A) * sin(2 * PI * probe_freq * T * i);
		freq_component += polynomial[i] * probe;
	}
	printf("%dhz component is %.3f\n", probe_freq, freq_component);

	//compoensate
	float K = A/probe_freq;		//you have to search this parameter
	float reversedNoise[F];
	float probe_result[F];
	for(int i=0; i<F; i++)
	{
		reversedNoise[i] = (float)(K) * sin(2 * PI * probe_freq * T * i + PI); 
		probe_result[i] = polynomial[i] + reversedNoise[i];	//180 degree delay
	}	

	for(int i=0; i<F; i++)
	{
		fprintf(file_out1, "%d\t%.1f\t%.1f\n", i, polynomial[i], probe_result[i]); 
	}

	puts("");
	fclose(file_out1);
	
	return 0;
}

