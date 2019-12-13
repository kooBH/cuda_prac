#! /bin/bash

cmake -DCMAKE_CUDA_COMPILER=/usr/local/cuda-9.2/bin/nvcc ..

# -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-9.2 
# -DCMAKE_CUDA_FLAGS="arch=sm_61" 
