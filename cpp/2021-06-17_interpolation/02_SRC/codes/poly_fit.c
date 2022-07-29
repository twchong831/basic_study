#include "matrix.h"

int main() 
{ 

    #define N 5
    float x[N] = {1,2,4,3,5};
    float y[N] = {1,3,3,2,5};

    // set of points
    FILE* file_out1 = fopen("point.txt", "w");
    for(int i=0; i<N; i++)
	{
        fprintf(file_out1, "%f\t%f\n", x[i], y[i]);
	}

    // matrix for coefficient representing equations crossing the given points 
    // given polynomial: y = a*x^2 + b*x + c 
    // if this function has to cross three points {(Xi,Yi)}
    //   x[0]^2*a + x[0]*b + 1*c = y[0]
    //   x[1]^2*a + x[1]*b + 1*c = y[1]
    //   x[2]^2*a + x[2]*b + 1*c = y[2]
    // 
    // | x[0]^2, x[0], 1 |   |a| = y[0]
    // | x[1]^2, x[1], 1 | * |b| = y[1]
    // | x[2]^2, x[2], 1 |   |c| = y[2]
    // 
    //  ==> find a, b, c, 
    //  ==> then  y = a*x^2 + b*x + c, crosses three points
    /*
    float A[N][N] = { 
                    {powf(x[0],4), powf(x[0],3), powf(x[0],2), powf(x[0],1), powf(x[0],0)}, 
                    {powf(x[1],4), powf(x[1],3), powf(x[1],2), powf(x[1],1), powf(x[1],0)}, 
                    {powf(x[2],4), powf(x[2],3), powf(x[2],2), powf(x[2],1), powf(x[2],0)},
                    {powf(x[3],4), powf(x[3],3), powf(x[3],2), powf(x[3],1), powf(x[3],0)},
                    {powf(x[4],4), powf(x[4],3), powf(x[4],2), powf(x[4],1), powf(x[4],0)}
                  };
    */
    float A[N][N];
    for(int i=0; i<N; i++) 
	{
        for(int j=0; j<N; j++)
		{
            A[i][j] = powf(x[i],N-j-1);
		}
	}


    printf("Input matrix is :\n"); 
    display(&A[0][0], N); 
  
    /*
    float adj[N][N];  
    printf("\nThe Adjoint is :\n"); 
    adjoint(N, &A[0][0], &adj[0][0]); 
    display(&adj[0][0], N); 
    */

    float A_inv[N][N]; 
    printf("\nThe Inverse is :\n"); 
    if (inverse(N, &A[0][0], &A_inv[0][0])) 
        display((float*)A_inv, N); 

    // coefficient calcuation using product of inverse matrix and output
    float c[N];
    for(int i=0; i<N; i++)
	{
        c[i] = 0;
	}

    for(int i=0; i<N; i++)
	{
        for(int j=0; j<N; j++)
		{
            c[i] += A_inv[i][j]*y[j];
		}
	}

    printf("\n---------------------------------------------------------------\n");
    printf("y(x)=");
    for(int i=0; i<N-1; i++)
        printf("c[%d]*x^%d + ", i, N-i-1);
    printf("c[0]");
    printf("\n---------------------------------------------------------------\n");

    for(int i=0; i<N; i++)
        printf("c[%d] = %7.1f\n", i, c[i]);

    
    // plot the estimated polynomial equation 
    FILE* file_out2 = fopen("fit.txt", "w");
    float y_fit = 0;
    for(float t=0; t<N; t=t+0.1) 
	{
        y_fit = 0;
        for(int i=0; i<N; i++)
		{
            y_fit += c[i]*powf(t,N-i-1);  
		}

        fprintf(file_out2, "%f\t%f\n", t, y_fit);
    }
  
    return 0; 
} 
