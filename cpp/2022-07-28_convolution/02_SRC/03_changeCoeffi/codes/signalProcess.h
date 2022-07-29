#ifndef SIGNALPROCESS
#define SIGNALPROCESS

#include "parameter.h"

float generateSignal(float Amp, float freq, int sampling);

float addSignal(float (*harmonics)[F], int total_freq, int sampling);


#endif
