#! /usr/bin/bash
clang++ $1 -emit-llvm -S -L/sw/arcts/centos7/cuda/10.1.243/lib64 --cuda-gpu-arch=sm_70 -pthread
