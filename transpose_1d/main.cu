#include "cuda_runtime.h"
#include <stdio.h>
#include <iostream>
#include <time.h>

#define M 5
#define N 3

// cuComplex or cuDoubleComplex
#define CPLX cuDoubleComplex

void init_rand(int *data,int size){
    for (int i = 0; i < size; ++i)
        data[i] = rand() %100;
}

void print_cplx(int *data,int m,int n){
  for(int i=0;i<m;i++){
    for(int j=0;j<n;j++){
      printf("%d ",data[i*n+ j]);
    }
    printf("\n");
  }
    printf("\n");
}

__global__ void transpose(int*X,int*X_T,int m,int n);


int main(void) 
{
    int *d_a, *d_b, *d_c; 
    int *h_a, *h_b, *h_c; 

    time_t t;
    srand(time(&t));

    int memsize = sizeof(int)*M*N;
 
    h_a = (int*)malloc(memsize);
    h_b = (int*)malloc(memsize);
    h_c = (int*)malloc(memsize);

    init_rand(h_a,M*N);

    print_cplx(h_a,M,N);
 

    cudaMalloc((void **)&d_a, memsize);
    cudaMalloc((void **)&d_b, memsize);
    cudaMalloc((void **)&d_c, memsize);


    cudaMemcpy(d_a, h_a, memsize, cudaMemcpyHostToDevice);

    transpose<<<M,N>>>(d_a,d_b,M,N);

    cudaMemcpy(h_b, d_b, memsize, cudaMemcpyDeviceToHost);

    print_cplx(h_b,N,M);
/************************************************************/
    cudaMemcpy(d_a, h_b, memsize, cudaMemcpyHostToDevice);

    //Roll Back
    transpose<<<N,M>>>(d_a,d_b,N,M);

    cudaMemcpy(h_a, d_b, memsize, cudaMemcpyDeviceToHost);

    print_cplx(h_a,M,N);

    free(h_a);free(h_b);free(h_c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    return 0;
}


__global__ void transpose(int*X,int*X_T,int m,int n){

   int idxX = threadIdx.x ;
   int idxY = blockIdx.x ;

   int idx_in  = idxX + n*idxY;
   int idx_out = idxY + m*idxX;
   X_T[idx_out] = X[idx_in];
}

