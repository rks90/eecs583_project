; ModuleID = 'add2_moreblocks.cu'
source_filename = "add2_moreblocks.cu"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.__cuda_builtin_blockIdx_t = type { i8 }
%struct.__cuda_builtin_blockDim_t = type { i8 }
%struct.__cuda_builtin_threadIdx_t = type { i8 }
%struct.__cuda_builtin_gridDim_t = type { i8 }
%struct.cudaFuncAttributes = type { i64, i64, i64, i32, i32, i32, i32, i32, i32, i32 }

@blockIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_blockIdx_t, align 1
@blockDim = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_blockDim_t, align 1
@threadIdx = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_threadIdx_t, align 1
@gridDim = extern_weak dso_local addrspace(1) global %struct.__cuda_builtin_gridDim_t, align 1

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaMalloc(i8** %p, i64 %s) #0 {
entry:
  %p.addr = alloca i8**, align 8
  %s.addr = alloca i64, align 8
  store i8** %p, i8*** %p.addr, align 8
  store i64 %s, i64* %s.addr, align 8
  ret i32 30
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaFuncGetAttributes(%struct.cudaFuncAttributes* %p, i8* %c) #0 {
entry:
  %p.addr = alloca %struct.cudaFuncAttributes*, align 8
  %c.addr = alloca i8*, align 8
  store %struct.cudaFuncAttributes* %p, %struct.cudaFuncAttributes** %p.addr, align 8
  store i8* %c, i8** %c.addr, align 8
  ret i32 30
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
  ret i32 30
}

; Function Attrs: convergent noinline nounwind optnone
define weak dso_local i32 @cudaGetDevice(i32* %device) #0 {
entry:
  %device.addr = alloca i32*, align 8
  store i32* %device, i32** %device.addr, align 8
  ret i32 30
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
  ret i32 30
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
  ret i32 30
}

; Function Attrs: convergent noinline nounwind optnone
define dso_local void @_Z3addiPfS_(i32 %n, float* %x, float* %y) #0 {
entry:
  %n.addr = alloca i32, align 4
  %x.addr = alloca float*, align 8
  %y.addr = alloca float*, align 8
  %index = alloca i32, align 4
  %stride = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  store float* %x, float** %x.addr, align 8
  store float* %y, float** %y.addr, align 8
  %0 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2, !range !10
  %1 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2, !range !11
  %mul = mul i32 %0, %1
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2, !range !12
  %add = add i32 %mul, %2
  store i32 %add, i32* %index, align 4
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #2, !range !11
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #2, !range !13
  %mul5 = mul i32 %3, %4
  store i32 %mul5, i32* %stride, align 4
  %5 = load i32, i32* %index, align 4
  store i32 %5, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %6 = load i32, i32* %i, align 4
  %7 = load i32, i32* %n.addr, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load float*, float** %x.addr, align 8
  %9 = load i32, i32* %i, align 4
  %idxprom = sext i32 %9 to i64
  %arrayidx = getelementptr inbounds float, float* %8, i64 %idxprom
  %10 = load float, float* %arrayidx, align 4
  %11 = load float*, float** %y.addr, align 8
  ;Rohit: load y[i]
  %12 = load i32, i32* %i, align 4
  %idxprom6 = sext i32 %12 to i64
  %arrayidx7 = getelementptr inbounds float, float* %11, i64 %idxprom6
  %13 = load float, float* %arrayidx7, align 4
  ;Rohit: Here is add x[i] + y[i]
  %add8 = fadd contract float %10, %13
  %14 = load float*, float** %y.addr, align 8
  %15 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %15 to i64
  %arrayidx10 = getelementptr inbounds float, float* %14, i64 %idxprom9
  
  store float %add8, float* %arrayidx10, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %16 = load i32, i32* %stride, align 4
  %17 = load i32, i32* %i, align 4
  %add11 = add nsw i32 %17, %16
  store i32 %add11, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.ntid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.nctaid.x() #1

attributes #0 = { convergent noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_70" "target-features"="+ptx61,+sm_70" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!nvvm.annotations = !{!3, !4, !5, !4, !6, !6, !6, !6, !7, !7, !6}
!llvm.ident = !{!8}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 9, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{void (i32, float*, float*)* @_Z3addiPfS_, !"kernel", i32 1}
!4 = !{null, !"align", i32 8}
!5 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!6 = !{null, !"align", i32 16}
!7 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}
!8 = !{!"clang version 9.0.0 (/home/rohitkan/eecs583/project/llvm/llvm-9.0.0.src/tools/cfe-9.0.0.src 5c8484f0e205ce27cdc1c53371f150aa6bc5519b)"}
!9 = !{i32 1, i32 2}
!10 = !{i32 0, i32 2147483647}
!11 = !{i32 1, i32 1025}
!12 = !{i32 0, i32 1024}
!13 = !{i32 1, i32 -2147483648}
