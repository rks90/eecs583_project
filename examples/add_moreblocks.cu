#include <iostream>
#include <math.h>
#include <stdio.h>

//function to add the elements of two arrays
__global__
void add(int n, float *x, float *y)
{
	int index = blockIdx.x* blockDim.x + threadIdx.x;
	int stride = blockDim.x * gridDim.x;

	/*printf("threadIdx.x = %d threadIdx.y = %d threadIdx.z = %d\
		blockIdx.x = %d blockIdx.y = %d blockIdx.z = %d\
		blockDim.x = %d blockDim.y = %d blockDim.z = %d\
		gridDim.x = %d gridDim.y = %d gridDim.z = %d\n",\
		threadIdx.x, threadIdx.y, threadIdx.z,\
		blockIdx.x,blockIdx.y,blockIdx.z,\
		blockDim.x,blockDim.y,blockDim.z,\
		gridDim.x,gridDim.y,gridDim.z);*/
	
	
	for (int i = index; i < n; i+= stride)
		y[i] = x[i] + y[i];
}

int main(void)
{
	int N = 1<<20; //1M elements
	//int N = 100; //100 elements

	int blockSize = 256;
	int numBlocks = (N+blockSize -1) / blockSize;
	//int numBlocks = 1;
	
	//Allocate Unified Memory -- accessible from CPU or GPU
	float *x, *y;
	cudaMallocManaged(&x, N*sizeof(float));
	cudaMallocManaged(&y, N*sizeof(float));
	
	//initialize x and y arrays on the host
	for (int i = 0; i < N; i++) {
		x[i] = 1.0f;
		y[i] = 2.0f;
	}

	// Run kernel on 1M elements on the CPU
  	add<<<numBlocks,blockSize>>>(N, x, y);

	//Wait for GPU to finish before accessing on host
	cudaDeviceSynchronize();

  	// Check for errors (all values should be 3.0f)
  	float maxError = 0.0f;
  	for (int i = 0; i < N; i++)
    		maxError = fmax(maxError, fabs(y[i]-3.0f));
  	std::cout << "Max error: " << maxError << std::endl;

  	// Free memory
	cudaFree(x);
	cudaFree(y);

  	return 0;
}
