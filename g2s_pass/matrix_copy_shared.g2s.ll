; ModuleID = '<stdin>'
source_filename = "matrix_copy_shared.cu"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__cuda_builtin_blockIdx_t = type { i8 }
%struct.__cuda_builtin_threadIdx_t = type { i8 }
%struct.__cuda_builtin_gridDim_t = type { i8 }
%struct.cudaFuncAttributes = type { i64, i64, i64, i32, i32, i32, i32, i32, i32, i32 }

@blockIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_blockIdx_t, align 1
@threadIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_threadIdx_t, align 1
@gridDim = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_gridDim_t, align 1
@_ZZ4copyPfPKfE4tile = internal addrspace(3) global [1024 x float] undef, align 4

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaMalloc(i8** %p, i64 %s) #0 {
entry:
  %p.addr = alloca i8**, align 8
  %s.addr = alloca i64, align 8
  store i8** %p, i8*** %p.addr, align 8
  store i64 %s, i64* %s.addr, align 8
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaFuncGetAttributes(%struct.cudaFuncAttributes* %p, i8* %c) #0 {
entry:
  %p.addr = alloca %struct.cudaFuncAttributes*, align 8
  %c.addr = alloca i8*, align 8
  store %struct.cudaFuncAttributes* %p, %struct.cudaFuncAttributes** %p.addr, align 8
  store i8* %c, i8** %c.addr, align 8
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaDeviceGetAttribute(i32* %value, i32 %attr, i32 %device) #0 {
entry:
  %value.addr = alloca i32*, align 8
  %attr.addr = alloca i32, align 4
  %device.addr = alloca i32, align 4
  store i32* %value, i32** %value.addr, align 8
  store i32 %attr, i32* %attr.addr, align 4
  store i32 %device, i32* %device.addr, align 4
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaGetDevice(i32* %device) #0 {
entry:
  %device.addr = alloca i32*, align 8
  store i32* %device, i32** %device.addr, align 8
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaOccupancyMaxActiveBlocksPerMultiprocessor(i32* %numBlocks, i8* %func, i32 %blockSize, i64 %dynamicSmemSize) #0 {
entry:
  %numBlocks.addr = alloca i32*, align 8
  %func.addr = alloca i8*, align 8
  %blockSize.addr = alloca i32, align 4
  %dynamicSmemSize.addr = alloca i64, align 8
  store i32* %numBlocks, i32** %numBlocks.addr, align 8
  store i8* %func, i8** %func.addr, align 8
  store i32 %blockSize, i32* %blockSize.addr, align 4
  store i64 %dynamicSmemSize, i64* %dynamicSmemSize.addr, align 8
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(i32* %numBlocks, i8* %func, i32 %blockSize, i64 %dynamicSmemSize, i32 %flags) #0 {
entry:
  %numBlocks.addr = alloca i32*, align 8
  %func.addr = alloca i8*, align 8
  %blockSize.addr = alloca i32, align 4
  %dynamicSmemSize.addr = alloca i64, align 8
  %flags.addr = alloca i32, align 4
  store i32* %numBlocks, i32** %numBlocks.addr, align 8
  store i8* %func, i8** %func.addr, align 8
  store i32 %blockSize, i32* %blockSize.addr, align 4
  store i64 %dynamicSmemSize, i64* %dynamicSmemSize.addr, align 8
  store i32 %flags, i32* %flags.addr, align 4
  ret i32 999
}

; Function Attrs: convergent noinline nounwind optnone
define dso_local void @_Z4copyPfPKf(float* %odata, float* %idata) #0 {
entry:
  %odata.addr = alloca float*, align 8
  %idata.addr = alloca float*, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %width = alloca i32, align 4
  %j = alloca i32, align 4
  %j19 = alloca i32, align 4
  store float* %odata, float** %odata.addr, align 8
  store float* %idata, float** %idata.addr, align 8
  %0 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #3, !range !10
  %mul = mul i32 %0, 32
  %1 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3, !range !11
  %add = add i32 %mul, %1
  store i32 %add, i32* %x, align 4
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #3, !range !12
  %mul3 = mul i32 %2, 32
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y() #3, !range !11
  %add5 = add i32 %mul3, %3
  store i32 %add5, i32* %y, align 4
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #3, !range !13
  %mul7 = mul i32 %4, 32
  store i32 %mul7, i32* %width, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32, i32* %j, align 4
  %cmp = icmp slt i32 %5, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load float*, float** %idata.addr, align 8
  %7 = load i32, i32* %y, align 4
  %8 = load i32, i32* %j, align 4
  %add8 = add nsw i32 %7, %8
  %9 = load i32, i32* %width, align 4
  %mul9 = mul nsw i32 %add8, %9
  %10 = load i32, i32* %x, align 4
  %add10 = add nsw i32 %mul9, %10
  %idxprom = sext i32 %add10 to i64
  %arrayidx = getelementptr inbounds float, float* %6, i64 %idxprom
  %11 = load float, float* %arrayidx, align 4
  %12 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y() #3, !range !11
  %13 = load i32, i32* %j, align 4
  %add12 = add i32 %12, %13
  %mul13 = mul i32 %add12, 32
  %14 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3, !range !11
  %add15 = add i32 %mul13, %14
  %idxprom16 = zext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZ4copyPfPKfE4tile to [1024 x float]*), i64 0, i64 %idxprom16
  store float %11, float* %arrayidx17, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %15 = load i32, i32* %j, align 4
  %add18 = add nsw i32 %15, 8
  store i32 %add18, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  call void @llvm.nvvm.barrier0()
  store i32 0, i32* %j19, align 4
  br label %for.cond20

for.cond20:                                       ; preds = %for.inc35, %for.end
  %16 = load i32, i32* %j19, align 4
  %cmp21 = icmp slt i32 %16, 32
  br i1 %cmp21, label %for.body22, label %for.end37

for.body22:                                       ; preds = %for.cond20
  %17 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y() #3, !range !11
  %18 = load i32, i32* %j19, align 4
  %add24 = add i32 %17, %18
  %mul25 = mul i32 %add24, 32
  %19 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #3, !range !11
  %add27 = add i32 %mul25, %19
  %idxprom28 = zext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds [1024 x float], [1024 x float]* addrspacecast ([1024 x float] addrspace(3)* @_ZZ4copyPfPKfE4tile to [1024 x float]*), i64 0, i64 %idxprom28
  %20 = load float, float* %arrayidx29, align 4
  %21 = load float*, float** %odata.addr, align 8
  %22 = load i32, i32* %y, align 4
  %23 = load i32, i32* %j19, align 4
  %add30 = add nsw i32 %22, %23
  %24 = load i32, i32* %width, align 4
  %mul31 = mul nsw i32 %add30, %24
  %25 = load i32, i32* %x, align 4
  %add32 = add nsw i32 %mul31, %25
  %idxprom33 = sext i32 %add32 to i64
  %arrayidx34 = getelementptr inbounds float, float* %21, i64 %idxprom33
  store float %20, float* %arrayidx34, align 4
  br label %for.inc35

for.inc35:                                        ; preds = %for.body22
  %26 = load i32, i32* %j19, align 4
  %add36 = add nsw i32 %26, 8
  store i32 %add36, i32* %j19, align 4
  br label %for.cond20

for.end37:                                        ; preds = %for.cond20
  ret void
}

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.y() #2

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #2

attributes #0 = { convergent noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_70" "target-features"="+ptx64,+sm_70" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!nvvm.annotations = !{!3, !4, !5, !4, !6, !6, !6, !6, !7, !7, !6}
!llvm.ident = !{!8}
!nvvmir.version = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{void (float*, float*)* @_Z4copyPfPKf, !"kernel", i32 1}
!4 = !{null, !"align", i32 8}
!5 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!6 = !{null, !"align", i32 16}
!7 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}
!8 = !{!"clang version 9.0.0 (/home/rohitkan/eecs583/project/llvm/llvm/llvm-9.0.0.src/tools/cfe-9.0.0.src aee663923236c29a1978c306960ac5cbe972b4dd)"}
!9 = !{i32 1, i32 4}
!10 = !{i32 0, i32 2147483647}
!11 = !{i32 0, i32 1024}
!12 = !{i32 0, i32 65535}
!13 = !{i32 1, i32 -2147483648}
