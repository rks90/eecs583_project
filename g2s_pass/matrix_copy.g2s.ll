; ModuleID = '<stdin>'
source_filename = "matrix_copy.cu"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__cuda_builtin_blockIdx_t = type { i8 }
%struct.__cuda_builtin_threadIdx_t = type { i8 }
%struct.__cuda_builtin_gridDim_t = type { i8 }
%struct.cudaFuncAttributes = type { i64, i64, i64, i32, i32, i32, i32, i32, i32, i32 }

@blockIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_blockIdx_t, align 1
@threadIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_threadIdx_t, align 1
@gridDim = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_gridDim_t, align 1

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
  store float* %odata, float** %odata.addr, align 8
  store float* %idata, float** %idata.addr, align 8
  %0 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2, !range !10
  %mul = mul i32 %0, 32
  %1 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2, !range !11
  %add = add i32 %mul, %1
  store i32 %add, i32* %x, align 4
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #2, !range !12
  %mul3 = mul i32 %2, 32
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.y() #2, !range !11
  %add5 = add i32 %mul3, %3
  store i32 %add5, i32* %y, align 4
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #2, !range !13
  %mul7 = mul i32 %4, 32
  store i32 %mul7, i32* %width, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond_clone:                                   ; preds = %for.inc_clone
  %5 = load i32, i32* %j, align 4
  %cmp_clone = icmp slt i32 %18, 32
  br i1 %cmp, label %for.body_clone, label %for.end_clone

for.body_clone:                                   ; preds = %for.cond_clone
  %6 = load float*, float** %idata.addr, align 8
  %7 = load i32, i32* %y, align 4
  %8 = load i32, i32* %j, align 4
  %add8_clone = add nsw i32 %20, %21
  %9 = load i32, i32* %width, align 4
  %mul9_clone = mul nsw i32 %add8, %22
  %10 = load i32, i32* %x, align 4
  %add10_clone = add nsw i32 %mul9, %23
  %idxprom_clone = sext i32 %add10 to i64
  %arrayidx_clone = getelementptr inbounds float, float* %19, i64 %idxprom
  %11 = load float, float* %arrayidx, align 4
  %12 = load float*, float** %odata.addr, align 8
  %13 = load i32, i32* %y, align 4
  %14 = load i32, i32* %j, align 4
  %add11_clone = add nsw i32 %26, %27
  %15 = load i32, i32* %width, align 4
  %mul12_clone = mul nsw i32 %add11, %28
  %16 = load i32, i32* %x, align 4
  %add13_clone = add nsw i32 %mul12, %29
  %idxprom14_clone = sext i32 %add13 to i64
  %arrayidx15_clone = getelementptr inbounds float, float* %25, i64 %idxprom14
  store float %24, float* %arrayidx15, align 4
  br label %for.inc_clone

for.inc_clone:                                    ; preds = %for.body_clone
  %17 = load i32, i32* %j, align 4
  %add16_clone = add nsw i32 %30, 8
  store i32 %add16, i32* %j, align 4
  br label %for.cond_clone

for.end_clone:                                    ; preds = %for.cond_clone
  br label %for.cond

for.cond:                                         ; preds = %for.end_clone, %for.inc, %entry
  %18 = load i32, i32* %j, align 4
  %cmp = icmp slt i32 %18, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %19 = load float*, float** %idata.addr, align 8
  %20 = load i32, i32* %y, align 4
  %21 = load i32, i32* %j, align 4
  %add8 = add nsw i32 %20, %21
  %22 = load i32, i32* %width, align 4
  %mul9 = mul nsw i32 %add8, %22
  %23 = load i32, i32* %x, align 4
  %add10 = add nsw i32 %mul9, %23
  %idxprom = sext i32 %add10 to i64
  %arrayidx = getelementptr inbounds float, float* %19, i64 %idxprom
  %24 = load float, float* %arrayidx, align 4
  %25 = load float*, float** %odata.addr, align 8
  %26 = load i32, i32* %y, align 4
  %27 = load i32, i32* %j, align 4
  %add11 = add nsw i32 %26, %27
  %28 = load i32, i32* %width, align 4
  %mul12 = mul nsw i32 %add11, %28
  %29 = load i32, i32* %x, align 4
  %add13 = add nsw i32 %mul12, %29
  %idxprom14 = sext i32 %add13 to i64
  %arrayidx15 = getelementptr inbounds float, float* %25, i64 %idxprom14
  store float %24, float* %arrayidx15, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %30 = load i32, i32* %j, align 4
  %add16 = add nsw i32 %30, 8
  store i32 %add16, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.y() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #1

attributes #0 = { convergent noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_70" "target-features"="+ptx64,+sm_70" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

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
