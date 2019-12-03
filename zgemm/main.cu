#include "cuda_runtime.h"
#include <cublas_v2.h>
#include <stdio.h>
#include <iostream>
#include <time.h>

// cuComplex or cuDoubleComplex
#define CPLX cuDoubleComplex

void init_rand(double*data,int size){
    for (int i = 0; i < size; ++i)
        data[i] = rand() / (double)RAND_MAX;
}

void print_cplx(double*data,int size){
  for(int i=0;i<size;i++){
    for(int j=0;j<size;j++){
      printf("%lf %lf | ",data[i*(2*size)+ 2*j],data[i*(2*size)+ 2*j+1]);
    }
    printf("\n");
  }
    printf("\n");
}


int main(void) 
{
    const int size = 4;
    double*d_a, *d_b, *d_c; 
    double*h_a, *h_b, *h_c; 

    time_t t;
    srand(time(&t));

    int memsize = sizeof(double)*size*size*2;
 
    h_a = (double*)malloc(memsize);
    h_b = (double*)malloc(memsize);
    h_c = (double*)malloc(memsize);

    init_rand(h_a,size*size*2);
    init_rand(h_b,size*size*2);

    print_cplx(h_a,size);
    print_cplx(h_b,size);


    cudaMalloc((void **)&d_a, memsize);
    cudaMalloc((void **)&d_b, memsize);
    cudaMalloc((void **)&d_c, memsize);


    cudaMemcpy(d_a, h_a, memsize, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, memsize, cudaMemcpyHostToDevice);


   cublasHandle_t handle;
   cublasCreate(&handle);

    cuDoubleComplex alpha {1.0,0.0};
    cuDoubleComplex beta {0.0,0.0};

    std::cout<<"alpha : "<<alpha.x<<" "<<alpha.y<<"\n";

    cublasZgemm(handle,
        CUBLAS_OP_N,CUBLAS_OP_N,
        size,size,size,
        &alpha,
        (CPLX*)d_a, size,
        (CPLX*)d_b, size,
        &beta,
        (CPLX*)d_c, size);

    cudaMemcpy(h_c, d_c, memsize, cudaMemcpyDeviceToHost);
    cudaThreadSynchronize();

    print_cplx(h_c,size);

    free(h_a);free(h_b);free(h_c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
}


