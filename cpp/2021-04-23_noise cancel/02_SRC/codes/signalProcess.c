#include "signalProcess.h"

float generateSignal(float Amp, float freq, int sampling)
{
	float val = Amp * sin(2 * PI * freq * T * sampling);
	return val;
}

float addSignal(float (*harmonics)[F], int total_freq, int sampling)
{
	float sum = 0;
	for(int i=0; i<total_freq; i++)
	{
		sum += harmonics[i][sampling];
	}

	return sum;
}


