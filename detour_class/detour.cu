#include "cuda_runtime.h"

int *d_a,*d_b,*d_c;
int *h_a,*h_b,*h_c;

__host__ void init(){
  h_a = (int*)malloc(sizeof(int));
  h_b = (int*)malloc(sizeof(int));
  h_c = (int*)malloc(sizeof(int));

  *h_c=0;

  cudaMalloc((void**)&d_a,sizeof(int));
  cudaMalloc((void**)&d_b,sizeof(int));
  cudaMalloc((void**)&d_c,sizeof(int));

  cudaMemcpy(d_c,h_c,sizeof(int),cudaMemcpyHostToDevice);
}

__host__  void assign(int a,int b){
  *h_a = a;
  *h_b = b;

  cudaMemcpy(d_a,h_a,sizeof(int),cudaMemcpyHostToDevice);
  cudaMemcpy(d_b,h_b,sizeof(int),cudaMemcpyHostToDevice);
}

__global__ void add(int *a,int *b,int *c){
  *c += *a + *b;
}

__host__ void process(){
  add<<<1,1>>>(d_a,d_b,d_c);
}

__host__ int get(){
  cudaMemcpy(h_c,d_c,sizeof(int),cudaMemcpyDeviceToHost);
  return *h_c;
}



