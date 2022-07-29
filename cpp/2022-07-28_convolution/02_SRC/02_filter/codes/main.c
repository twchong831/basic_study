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
#define A 5


void convolution(float h[], int len_h, float x[], int len_x, float* y, int len_y )
{
    int i,j,h_start,x_start,h_end;

    for (i=0; i<len_y; i++)
    {
        h_start = i >= len_x ? i-len_x+1 : 0;
        h_end   = i >= len_h ?   len_h-1 : i;   
        x_start = i >= len_x ?   len_x-1 : i;   

        for(j=h_start; j<=h_end; j++)
        {
            y[i] += h[j]*x[x_start];
            x_start--;
        }
    }
}

float add_noise(float signal, float min, float max) {
    float noise =((2 * ((double)rand()/RAND_MAX) - 1)); // -1~1
    noise = noise*(max-min)*0.3; // 30% noise
    return signal + noise;
}


int main()
{
	FILE* file_out1;
	FILE* file_out2;
	file_out1 = fopen("out.txt", "w");
	file_out2 = fopen("point.txt", "w");

    float signal[F];
    float signal_with_noise[F];

    for(int i=0; i<F; i++) {
        signal[i] = A*sin(2*PI*T*i);
        signal_with_noise[i] = add_noise(signal[i], -A, A);
    }

    float h[] = { 0.1, 0.1, 0.2, 0.2, 0.4 };
    int len_h = 5;

    int len_x = F;
    int len_y = len_h + len_x - 1;
    float* y = (float*)malloc(sizeof(float)*len_y);

    for(int i=0;i<len_y;i++) {
        y[i] = 0.0;
    }

    convolution(h, len_h, signal_with_noise, len_x, y, len_y);

    for(int i=0;i<len_x;i++) {
        printf("%.1f ",y[i]);
        fprintf(file_out1, "%d\t%.1f\t%.1f\n", i, signal_with_noise[i], y[i]);
    }
    puts("");
    free(y);
    return 0;
}

