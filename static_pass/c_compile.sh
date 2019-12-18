module load gcc/9.2.0
PATH2LIB=../../build/mypass_brycehm/LLVMPJT.so
PASS=-CTMemPass

../../llvm/llvm/llvm-9.0.0.src/build/bin/clang++ -S -emit-llvm $1.cu --cuda-gpu-arch=sm_70 -pthread

../../llvm/llvm/llvm-9.0.0.src/build/bin/opt -S -o ${1}.opt.ll -load ${PATH2LIB} ${PASS} < ${1}-cuda-nvptx64-nvidia-cuda-sm_70.ll

./cu_edit < ${1}.cu > ${1}_pass.cu
cp ${1}.cu ${1}_orig.cu
cp ${1}_pass.cu ${1}.cu

../../llvm/llvm/llvm-9.0.0.src/build/bin/clang++ $1.cu -o $1 --cuda-gpu-arch=sm_70 -L$CUDA_ROOT/lib64 -lcudart_static -ldl -lrt -pthread

cp ${1}_orig.cu ${1}.cu

