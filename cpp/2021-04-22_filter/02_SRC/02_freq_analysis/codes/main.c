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

	//signal processing...
	//ex.. fourier transform...
	//the given polynomial signal includes a specific frequency component...
	float freq_component[H] = {0,};
	for(int i=0; i<H; i++)
	{
		for(int j=0; j<F; j++)
		{
			float probe = (float)(A) * sin(2 * PI * i * T *j /* + n*/);	//+ 항목은 쉬프트
			freq_component[i] += polynomial[j] * probe;
		}
	}

	for(int i=0; i<H; i++)
	{
		printf("%dHz component : %.1f\n", i, freq_component[i]);
		fprintf(file_out1, "%d\t%.1f\n", i, freq_component[i]); 
	}

	fclose(file_out1);
	
	return 0;
}
