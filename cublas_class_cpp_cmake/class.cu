#include "cuda_runtime.h"
#include <cublas_v2.h>
#include <stdio.h>

__global__ void some_func(double*data,double value);

class A{
  double *d_a;
  double *h_a;
  const int size  = 10;
  int memsize;

  public : 
  A();
  void Print();
};


__global__ void some_func(double*data,double value){

      data[threadIdx.x] = value;
}


A::A(){

  memsize = size * sizeof(double);


  h_a = (double*)malloc(memsize);
  cudaMalloc((void**)&d_a,memsize);

  some_func<<<1,size>>>(d_a,1);

  cudaMemcpy(&h_a,d_a,memsize,cudaMemcpyDeviceToHost);

}

void A::Print(){
   for(int i=0;i<size;i++)
     printf("%lf ",h_a[i]);
   printf("\n");
}


