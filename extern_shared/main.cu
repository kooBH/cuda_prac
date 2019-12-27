#include <stdio.h>
#include "cuda_runtime.h"

#define M 8
#define N 12

extern __shared__ int shared[];

__global__ void func(int*data, int m,int n){
  int * t_s = shared;
//  __shared__ int t_s[12];

  if(threadIdx.x==0){
     memcpy(t_s + blockIdx.x*n,data + blockIdx.x*n,sizeof(int)*n);
  }
  __syncthreads();

  data[blockIdx.x*n + threadIdx.x] = 
  t_s[blockIdx.x*n + threadIdx.x+1];
}


int main(){

int h_d[M*N];
int *d_d;

  for(int i=0;i<M*N;i++)
    h_d[i]=i+1;
 
  for(int i=0;i<M;i++){
    for(int j=0;j<N;j++)
      printf("%2d ",h_d[i*N+j]);
    printf("\n");
  }
  printf("\n");

  cudaMalloc((void**)&d_d,sizeof(int)*M*N);
  cudaMemcpy(d_d,h_d,sizeof(int)*M*N,cudaMemcpyHostToDevice);


  func<<<M,N-1,sizeof(int)*M*N>>>(d_d,M,N);

  cudaThreadSynchronize();

  memset(h_d,0,sizeof(int)*M*N);
  cudaMemcpy(h_d,d_d,sizeof(int)*M*N,cudaMemcpyDeviceToHost);

  for(int i=0;i<M;i++){
    for(int j=0;j<N;j++)
      printf("%2d ",h_d[i*N+j]);
    printf("\n");
  }
  printf("\n");



  return 0;

}
