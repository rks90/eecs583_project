#include <iostream>

__device__ int memr[2048];
__device__ int memg[2048];
__device__ int memb[2048];
__shared__ int mem_out[2048];

__global__ void func() {
	int i = blockIdx.x * 256 + threadIdx.x;
	// This line is different from the line in our presentation,
	// but it works similarly and yields similar results.
	mem_out[i] = memr[(i*4 + 1) % 2048] * memr[i*4 % 2048]
			   + memg[i*4 % 2048] + memb[i*4 % 2048];
}

int main() {
	for (int i = 0; i < 1000000; i++) {
		func<<<8, 256>>>();
		cudaDeviceSynchronize();
	}
	return 0;
}

