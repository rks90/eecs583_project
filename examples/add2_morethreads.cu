#include <iostream>
#include <math.h>

//function to add the elements of two arrays
__global__
void add(int n, float *x, float *y)
{
	int index = threadIdx.x;
	int stride = blockDim.x;
	for (int i = index; i < n; i+= stride)
		y[i] = x[i] + y[i];
}

int main(void)
{
	int N = 1<<20; //1M elements
	//int N = 100; //100 elements

	int blockSize = 256;
	//int numBlocks = (N+blockSize -1) / blocksize;
	int numBlocks = 1;
	
	//Allocate Unified Memory -- accessible from CPU or GPU
	float *x, *y, *d_x, *d_y;
	x = (float *)malloc(N*sizeof(float));
	y = (float *)malloc(N*sizeof(float));
	cudaMalloc(&d_x, N*sizeof(float));
	cudaMalloc(&d_y, N*sizeof(float));
	
	//initialize x and y arrays on the host
	for (int i = 0; i < N; i++) {
		x[i] = 1.0f;
		y[i] = 2.0f;
	}

	//Copy
	cudaMemcpy(d_x,x, N*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(d_y,y, N*sizeof(float), cudaMemcpyHostToDevice);

	// Run kernel on 1M elements on the CPU
  	add<<<numBlocks,blockSize>>>(N, d_x, d_y);

	//Wait for GPU to finish before accessing on host
	//cudaDeviceSynchronize();

	cudaMemcpy(y,d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

  	// Check for errors (all values should be 3.0f)
  	float maxError = 0.0f;
  	for (int i = 0; i < N; i++)
    		maxError = fmax(maxError, fabs(y[i]-3.0f));
  	std::cout << "Max error: " << maxError << std::endl;

  	// Free memory
	cudaFree(d_x);
	cudaFree(d_y);
	free(x);
	free(y);

  	return 0;
}
