# Interpolation

$$
y = ax^4 + bx^3 + cx^2 + dx + e
$$

- 샘플 포인트를 기반으로 해당 포인트 값들을 갖은 다항식을 구하는 방법
- 해당 방법을 통해 해당 포인트 이외의 값을 유추할 수 있음
- 저해상도 라이다 정보를 기반으로 포인트 사이의 값을 유추하여 고해상도로 보정 가능

## 소스코드

```c
//N 은 샘플의 개수
// 찾으려는 함수의 개수만큼의 샘플 개수가 필요.

float x[N] = {1,2,4,3,5};
float y[N] = {1,3,3,2,5};
for(int i=0; i<N; i++) 
{
	for(int j=0; j<N; j++)
	{
		A[i][j] = powf(x[i],N-j-1);
	}
}
/*
	x[0] 값일 때,
	[0][0] = x[0]^(5-0-1) = x[0]^4 = 1
	[0][1] = x[0]^(5-1-1) = x[0]^3 = 1
	[0][2] = x[0]^(5-2-1) = x[0]^2 = 1
	[0][3] = x[0]^(5-3-1) = x[0]^1 = 1
	[0][4] = x[0]^(5-4-1) = x[0]^0 = 1
*/
```

## inverse

```c
int inverse(int size, float* A, float* inverse) 
{ 
    //포인터 주소와 사이즈를 받아서 다중 어레이의 크기를 가늠
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
```

```c
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
```

```c
// Function to get cofactor of A[p][q] in temp[][]. n is current 
// dimension of A[][] 
void get_cofactor(int size, float* A, float* temp, int p, int q, int n) 
{ 
    // size = 5
    // p = 0
    // q = f(0 < < n:5)
    // n = 5
    int i = 0, j = 0; 
  
    // Looping for each element of the matrix 
    // 5 x 5
    for (int row = 0; row < n; row++) 
    { 
        for (int col = 0; col < n; col++) 
        { 
            //  Copying into temporary matrix only those element 
            //  which are not in given row and column 
            // p값은 0으로 고정
            // q 값은 0부터 N(5)까지 증가
            if (row != p && col != q) 
            { 
                //temp[i][j++] = A[row][col]; 
                //temp : 주소값 + 5 * i + j : 배열의 위치[i][j]
                // A(input)
                // ex)
                // 1 1 1 1 1
                // 2 2 2 2 2
                // 3 3 3 3 3
                // 4 4 4 4 4
                // 5 5 5 5 5
                *(temp + size*i + j) = *(A + size*row + col); 
                j++;
                /*
                p=0, q=0
                [0][0] : x
                [0][1] : [0][1]
                ...
                */
  
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
```
