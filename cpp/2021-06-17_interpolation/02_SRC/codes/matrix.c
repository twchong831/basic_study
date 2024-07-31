#include "matrix.h"

void get_cofactor(int size, float* A, float* temp, int p, int q, int n); 
int determinant(int size, float* A, int n); 

// Function to get cofactor of A[p][q] in temp[][]. n is current 
// dimension of A[][] 
void get_cofactor(int size, float* A, float* temp, int p, int q, int n) 
{ 
    int i = 0, j = 0; 
  
    // Looping for each element of the matrix 
    for (int row = 0; row < n; row++) 
    { 
        for (int col = 0; col < n; col++) 
        { 
            //  Copying into temporary matrix only those element 
            //  which are not in given row and column 
            if (row != p && col != q) 
            { 
                //temp[i][j++] = A[row][col]; 
                *(temp + size*i + j) = *(A + size*row + col); 
                j++;
  
                // Row is filled, so increase row index and 
                // reset col index 
                if (j == n - 1) 
                { 
                    j = 0; 
                    i++; 
                } 
            } 
        } 
    } 
} 
  
/* Recursive function for finding determinant of matrix. 
   n is current dimension of A[][]. */
int determinant(int size, float* A, int n) 
{ 
    int D = 0; // Initialize result 
  
    //  Base case : if matrix contains single element 
    if (n == 1) 
        return *A; 
        //return A[0][0]; 
  
    float temp[size][size]; // To store cofactors 
  
    float sign = 1;  // To store sign multiplier 
  
     // Iterate for each element of first row 
    for (int f = 0; f < n; f++) 
    { 
        // Getting Cofactor of A[0][f] 
        get_cofactor(size, A, &temp[0][0], 0, f, n); 
        //D += sign * A[0][f] * determinant(temp, n - 1); 
        D += sign * *(A + f) * determinant(size, &temp[0][0], n - 1); 
  
        // terms are to be added with alternate sign 
        sign = -sign; 
    } 
  
    return D; 
} 
  
// Function to get adjoint of A[N][N] in adj[N][N]. 
void adjoint(int size, float* A, float* adj) 
{ 
    if (size == 1) 
    { 
        *adj = 1; 
        return; 
    } 
  
    // temp is used to store cofactors of A[][] 
    float sign = 1;
    //float temp[N][N]; 
    float* temp = (float*)malloc(sizeof(float)*size*size); 
  
    for (int i=0; i<size; i++) 
    { 
        for (int j=0; j<size; j++) 
        { 
            // Get cofactor of A[i][j] 
            get_cofactor(size, A, temp, i, j, size); 
  
            // sign of adj[j][i] positive if sum of row 
            // and column indexes is even. 
            sign = ((i+j)%2==0)? 1: -1; 
  
            // Interchanging rows and columns to get the 
            // transpose of the cofactor matrix 
            *(adj + size*j + i) = (sign)*(determinant(size, temp, size-1)); 
        } 
    } 

    free(temp);
} 
  
// Function to calculate and store inverse, returns false if 
// matrix is singular 
int inverse(int size, float* A, float* inverse) 
{ 
    // Find determinant of A[][] 
    int det = determinant(size, A, size); 
    if (det == 0) 
    { 
        printf("Singular matrix, can't find its inverse"); 
        return 0; 
    } 
  
    // Find adjoint 
    //float adj[N][N]; 
    float* adj = (float*)malloc(sizeof(float)*size*size); 

    adjoint(size, A, adj); 
  
    // Find Inverse using formula "inverse(A) = adj(A)/det(A)" 
    for (int i=0; i<size; i++) 
        for (int j=0; j<size; j++) 
            *(inverse +size*i + j) = *(adj + size*i + j)/(float)(det); 
  
    free(adj);
    return 1; 
} 
  
void display(float* A, int size) 
{ 

    for (int i=0; i<size; i++)
        printf("---------");

    printf("\n");
    for (int i=0; i<size; i++) 
    { 
        for (int j=0; j<size; j++) 
            printf("%7.1f ", *(A+size*i+j));
        printf("\n"); 
    } 
    for (int i=0; i<size; i++)
        printf("---------");

    printf("\n");
} 
