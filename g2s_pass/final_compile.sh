module load gcc/9.2.0
PATH2LIB=/home/rohitkan/eecs583/project/build_rohit/LLVMPJT.so
PASS=-g2s
clang++ -S -emit-llvm $1.cu --cuda-gpu-arch=sm_70 -pthread
opt -S -o ${1}.opt.ll -load ${PATH2LIB} ${PASS} < ${1}-cuda-nvptx64-nvidia-cuda-sm_70.ll
#llc -mcpu=sm_70 ${1}-cuda-nvptx64-nvidia-cuda-sm_70.ll -o ${1}.ptx
llc -mcpu=sm_70 ${1}.opt.ll -o ${1}.ptx
_SPACE_= 
_CUDART_=cudart
_HERE_=/sw/arcts/centos7/cuda/10.1.243/bin
_THERE_=/sw/arcts/centos7/cuda/10.1.243/bin
_TARGET_SIZE_=
_TARGET_DIR_=
_TARGET_DIR_=targets/x86_64-linux
TOP=/sw/arcts/centos7/cuda/10.1.243/bin/..
NVVMIR_LIBRARY_DIR=/sw/arcts/centos7/cuda/10.1.243/bin/../nvvm/libdevice
LD_LIBRARY_PATH=/sw/arcts/centos7/cuda/10.1.243/bin/../lib:/sw/arcts/centos7/cuda/10.1.243/bin/../lib:/sw/arcts/centos7/gcc/8.2.0/lib64:/sw/arcts/centos7/cuda/10.1.243/bin/../lib:/sw/arcts/centos7/gcc/9.2.0/lib64:/sw/arcts/centos7/cuda/10.1.243/lib64:/opt/slurm/lib64::/home/rohitkan/eecs583/project/llvm/local/zlib/lib:/home/rohitkan/eecs583/project/llvm/local/z3/lib
PATH=/sw/arcts/centos7/cuda/10.1.243/bin/../nvvm/bin:/sw/arcts/centos7/cuda/10.1.243/bin:/sw/arcts/centos7/cuda/10.1.243/bin/../nvvm/bin:/sw/arcts/centos7/cuda/10.1.243/bin:/sw/arcts/centos7/gcc/8.2.0/bin:/sw/arcts/centos7/cuda/10.1.243/bin/../nvvm/bin:/sw/arcts/centos7/cuda/10.1.243/bin:/sw/arcts/centos7/gcc/9.2.0/bin:/home/rohitkan/eecs583/project/llvm/llvm/llvm-9.0.0.src/build/bin:/sw/arcts/centos7/cmake/3.13.2/bin:/opt/TurboVNC/bin:/opt/slurm/bin:/opt/slurm/sbin:/usr/lib64/qt-3.3/bin:/sw/arcts/centos7/usertools/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/lpp/mmfs/bin:/opt/ibutils/bin:/opt/ddn/ime/bin:/home/rohitkan/eecs583/project/llvm/bin:/home/rohitkan/eecs583/project/llvm/local/z3/bin:/home/rohitkan/eecs583/project/llvm/local/z3/lib:/home/rohitkan/.local/bin:/home/rohitkan/bin
INCLUDES="-I/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/include"  
LIBRARIES=  "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib/stubs" "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib"
CUDAFE_FLAGS=
PTXAS_FLAGS=
rm ${1}_dlink.reg.c
gcc -D__CUDA_ARCH__=700 -E -x c++  -DCUDA_DOUBLE_MATH_FUNCTIONS -D__CUDACC__ -D__NVCC__  "-I/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=10 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=243 -include "cuda_runtime.h" -m64 "${1}.cu" > "${1}.cpp1.ii" 
cicc --c++14 --gnu_version=80200 --allow_managed   -arch compute_70 -m64 -ftz=0 -prec_div=1 -prec_sqrt=1 -fmad=1 --include_file_name "${1}.fatbin.c" -tused -nvvmir-library "/sw/arcts/centos7/cuda/10.1.243/bin/../nvvm/libdevice/libdevice.10.bc" --gen_module_id_file --module_id_file_name "${1}.module_id" --orig_src_file_name "${1}.cu" --gen_c_file_name "${1}.cudafe1.c" --stub_file_name "${1}.cudafe1.stub.c" --gen_device_file_name "${1}.cudafe1.gpu"  "${1}.cpp1.ii" -o "${1}.unused.ptx"
ptxas -arch=sm_70 -m64  "${1}.ptx"  -o "${1}.sm_70.cubin" 
fatbinary --create="${1}.fatbin" -64 "--image=profile=sm_70,file=${1}.sm_70.cubin" "--image=profile=compute_70,file=${1}.ptx" --embedded-fatbin="${1}.fatbin.c" 
gcc -E -x c++ -D__CUDACC__ -D__NVCC__  "-I/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=10 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=243 -include "cuda_runtime.h" -m64 "${1}.cu" > "${1}.cpp4.ii" 
cudafe++ --c++14 --gnu_version=80200 --allow_managed  --m64 --parse_templates --gen_c_file_name "${1}.cudafe1.cpp" --stub_file_name "${1}.cudafe1.stub.c" --module_id_file_name "${1}.module_id" "${1}.cpp4.ii" 
gcc -D__CUDA_ARCH__=700 -c -x c++  -DCUDA_DOUBLE_MATH_FUNCTIONS "-I/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/include"   -m64 -o "${1}.o" "${1}.cudafe1.cpp" 
nvlink --arch=sm_70 --register-link-binaries="${1}_dlink.reg.c"  -m64   "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib/stubs" "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib" -cpu-arch=X86_64 "${1}.o"  -lcudadevrt  -o "${1}_dlink.sm_70.cubin"
fatbinary --create="${1}_dlink.fatbin" -64 -link "--image=profile=sm_70,file=${1}_dlink.sm_70.cubin" --embedded-fatbin="${1}_dlink.fatbin.c" 
gcc -c -x c++ -DFATBINFILE="\"${1}_dlink.fatbin.c\"" -DREGISTERLINKBINARYFILE="\"${1}_dlink.reg.c\"" -I. -D__NV_EXTRA_INITIALIZATION= -D__NV_EXTRA_FINALIZATION= -D__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__  "-I/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/include"    -D__CUDACC_VER_MAJOR__=10 -D__CUDACC_VER_MINOR__=1 -D__CUDACC_VER_BUILD__=243 -m64 -o "${1}_dlink.o" "/sw/arcts/centos7/cuda/10.1.243/bin/crt/link.stub" 
g++ -m64 -o "${1}" -Wl,--start-group "${1}_dlink.o" "${1}.o"   "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib/stubs" "-L/sw/arcts/centos7/cuda/10.1.243/bin/../targets/x86_64-linux/lib" -lcudadevrt  -lcudart_static  -lrt -lpthread  -ldl  -Wl,--end-group 
module load gcc/9.2.0
