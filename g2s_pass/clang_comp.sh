#! /usr/bin/bash
clang++ $1 -o $2 -L/sw/arcts/centos7/cuda/10.1.243/lib64 --cuda-gpu-arch=sm_70 -lcudart_static -ldl -lrt -pthread
