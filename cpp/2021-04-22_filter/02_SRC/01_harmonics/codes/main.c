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
int main()
{
	FILE* file_out1;
	file_out1 = fopen("out.txt", "w");

	//signal generation
	float harmonics[H][F];
	float polynomial[F];

	for(int i=0; i<F; i++)
	{
		fprintf(file_out1, "%d", i);
		int hi = 1;			//frequency
		float sum = 0;
		polynomial[i] = 0;
//			fprintf(file_out1, "\t%.2f\n", signal);
		for(int j=0; j<H; j++)
		{
			float signal = (float)(A/hi) * sin(2 * PI * hi * T * i);	//
			harmonics[j][i] = signal;	//signal dump
			polynomial[i] = polynomial[i] + signal;
			hi += 2;
		}
	}

	//plot
	for(int i=0; i<F; i++)
	{
		fprintf(file_out1, "%d", i);
		int hi = 1;			//frequency
		float sum = 0;
		fprintf(file_out1, "\t%.2f", polynomial[i]);
// #ifdef	DEBUG
		for(int j=0; j<H; j++)
		{
			float signal = harmonics[j][i];
			sum = sum + signal;
			fprintf(file_out1, "\t%.2f", signal);
			hi += 2;
		}
// #endif
		fprintf(file_out1, "\n");
	}
	
	fclose(file_out1);
	
	return 0;
}
