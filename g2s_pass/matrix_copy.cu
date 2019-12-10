#include <iostream>
#include <fstream>

using namespace std;


//Define TILE_DIM and BLOCK_ROWS
const int TILE_DIM = 32;
const int BLOCK_ROWS = 8;

__global__ void copy(float *odata, const float *idata)
{
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;
  int width = gridDim.x * TILE_DIM;

  for (int j = 0; j < TILE_DIM; j+= BLOCK_ROWS)
    odata[(y+j)*width + x] = idata[(y+j)*width + x];
}

int main(void)
{
	//Multiple of 32
	//int N = 1<<20; //1M elements
	int N = 100*32; 
	
	//Allocate Unified Memory -- accessible from CPU or GPU
	float *x, *y;
	cudaMallocManaged(&x, N*N*sizeof(float));
	cudaMallocManaged(&y, N*N*sizeof(float));
	
	//initialize x
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			x[i*N + j] = 1.0f *(i*N + j) ;
		}
	}

	ofstream outfile;
	outfile.open("copy_out.txt");

	outfile << "Input Matrix:" << endl;
  	// Output X Matrix
  	for (int i = 0; i < N; i++) {
  		for (int j = 0; j < N; j++) {
			outfile << x[i*N+j] << " ";
		}
		outfile << "\n";
	}
	dim3 numThreads(TILE_DIM,BLOCK_ROWS,1);
	dim3 numBlocks(N/(TILE_DIM),N/(TILE_DIM),1);
	printf("numBlocks: %d %d %d. numThreads: %d %d %d\n",numBlocks.x, numBlocks.y, numBlocks.z, numThreads.x, numThreads.y, numThreads.z);
	// Run kernel on 1M elements on the CPU
  	copy<<<numBlocks, numThreads>>>(y, x);

	//Wait for GPU to finish before accessing on host
	cudaDeviceSynchronize();


	outfile << "Output Matrix:" << endl;
  	// Output Matrix
  	for (int i = 0; i < N; i++) {
  		for (int j = 0; j < N; j++) {
			outfile << y[i*N+j] << " ";
		}
		outfile << "\n";
	}

  	// Free memory
	cudaFree(x);
	cudaFree(y);

	outfile.close();

  	return 0;
}
