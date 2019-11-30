#include "cuda_runtime.h"
#include <cublas_v2.h>
#include <stdio.h>

__global__ void add(int *a, int *b, int *c) 
{
    *c = *a + *b;
}


int main(void) 
{
    int a, b, c; 
    int *d_a, *d_b, *d_c; 
 
    cudaMalloc((void **)&d_a, sizeof(int));
    cudaMalloc((void **)&d_b, sizeof(int));
    cudaMalloc((void **)&d_c, sizeof(int));

    a = 3;
    b = 4;

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    add<<<1,1>>>(d_a, d_b, d_c);

    cudaMemcpy(&c, d_c, sizeof(int), cudaMemcpyDeviceToHost);

    printf("%d + %d = %d\n",a,b,c);

    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
}


