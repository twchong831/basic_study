#include "noiseFilter.h"

float probe(float *signal, int size, float amp, float freq)
{
	float response = 0.0f;

	for(int i=0; i<size; i++)
	{
		float prob = amp * sin(2 * PI * freq * T * i);
		response += signal[i] * prob;
	}

	return response;
}

float filtering(float input, float amp, float freq, float time)
{
	
	return input + amp * sin(2 * PI * freq * time + PI);	//180 degree delay
}
