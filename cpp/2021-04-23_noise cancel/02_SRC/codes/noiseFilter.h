#ifndef NOISEFILTER
#define NOISEFILTER

#include "parameter.h"


float probe(float *signal, int size, float amp, float freq);
float filtering(float input, float amp, float freq, float time);
#endif
