; ModuleID = 'matrix_transpose.cu'
source_filename = "matrix_transpose.cu"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%struct.dim3 = type { i32, i32, i32 }
%struct.CUstream_st = type opaque
%"class.std::basic_ofstream" = type { %"class.std::basic_ostream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::basic_filebuf" = type { %"class.std::basic_streambuf", %union.pthread_mutex_t, %"class.std::__basic_file", i32, %struct.__mbstate_t, %struct.__mbstate_t, %struct.__mbstate_t, i8*, i64, i8, i8, i8, i8, i8*, i8*, i8, %"class.std::codecvt"*, i8*, i64, i8*, i8* }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%union.pthread_mutex_t = type { %"struct.(anonymous union)::__pthread_mutex_s" }
%"struct.(anonymous union)::__pthread_mutex_s" = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::__basic_file" = type <{ %struct._IO_FILE*, i8, [7 x i8] }>
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base.base", %struct.__locale_struct* }
%"class.std::__codecvt_abstract_base.base" = type { %"class.std::locale::facet.base" }
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }

$_ZStorSt13_Ios_OpenmodeS_ = comdat any

$_ZN4dim3C2Ejjj = comdat any

$__clang_call_terminate = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@.str = private unnamed_addr constant [18 x i8] c"transpose_out.txt\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"Input Matrix:\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [43 x i8] c"numBlocks: %d %d %d. numThreads: %d %d %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Output Matrix:\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_matrix_transpose.cu, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #2
  ret void
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) unnamed_addr #1

declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: noinline optnone uwtable
define dso_local void @_Z9transposePfPKf(float* %odata, float* %idata) #3 {
entry:
  %odata.addr = alloca float*, align 8
  %idata.addr = alloca float*, align 8
  %grid_dim = alloca %struct.dim3, align 8
  %block_dim = alloca %struct.dim3, align 8
  %shmem_size = alloca i64, align 8
  %stream = alloca i8*, align 8
  %grid_dim.coerce = alloca { i64, i32 }, align 8
  %block_dim.coerce = alloca { i64, i32 }, align 8
  store float* %odata, float** %odata.addr, align 8
  store float* %idata, float** %idata.addr, align 8
  %kernel_args = alloca i8*, i64 2, align 16
  %0 = bitcast float** %odata.addr to i8*
  %1 = getelementptr i8*, i8** %kernel_args, i32 0
  store i8* %0, i8** %1
  %2 = bitcast float** %idata.addr to i8*
  %3 = getelementptr i8*, i8** %kernel_args, i32 1
  store i8* %2, i8** %3
  %4 = call i32 @__cudaPopCallConfiguration(%struct.dim3* %grid_dim, %struct.dim3* %block_dim, i64* %shmem_size, i8** %stream)
  %5 = load i64, i64* %shmem_size, align 8
  %6 = load i8*, i8** %stream, align 8
  %7 = bitcast { i64, i32 }* %grid_dim.coerce to i8*
  %8 = bitcast %struct.dim3* %grid_dim to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %7, i8* align 8 %8, i64 12, i1 false)
  %9 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %grid_dim.coerce, i32 0, i32 0
  %10 = load i64, i64* %9, align 8
  %11 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %grid_dim.coerce, i32 0, i32 1
  %12 = load i32, i32* %11, align 8
  %13 = bitcast { i64, i32 }* %block_dim.coerce to i8*
  %14 = bitcast %struct.dim3* %block_dim to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %13, i8* align 8 %14, i64 12, i1 false)
  %15 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %block_dim.coerce, i32 0, i32 0
  %16 = load i64, i64* %15, align 8
  %17 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %block_dim.coerce, i32 0, i32 1
  %18 = load i32, i32* %17, align 8
  %19 = bitcast i8* %6 to %struct.CUstream_st*
  %call = call i32 @cudaLaunchKernel(i8* bitcast (void (float*, float*)* @_Z9transposePfPKf to i8*), i64 %10, i32 %12, i64 %16, i32 %18, i8** %kernel_args, i64 %5, %struct.CUstream_st* %19)
  br label %setup.end

setup.end:                                        ; preds = %entry
  ret void
}

declare dso_local i32 @__cudaPopCallConfiguration(%struct.dim3*, %struct.dim3*, i64*, i8**)

declare dso_local i32 @cudaLaunchKernel(i8*, i64, i32, i64, i32, i8**, i64, %struct.CUstream_st*)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #4

; Function Attrs: noinline norecurse optnone uwtable
define dso_local i32 @main() #5 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %retval = alloca i32, align 4
  %N = alloca i32, align 4
  %x = alloca float*, align 8
  %y = alloca float*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %outfile = alloca %"class.std::basic_ofstream", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %i23 = alloca i32, align 4
  %j27 = alloca i32, align 4
  %numThreads = alloca %struct.dim3, align 4
  %numBlocks = alloca %struct.dim3, align 4
  %agg.tmp = alloca %struct.dim3, align 4
  %agg.tmp57 = alloca %struct.dim3, align 4
  %agg.tmp.coerce = alloca { i64, i32 }, align 4
  %agg.tmp57.coerce = alloca { i64, i32 }, align 4
  %i67 = alloca i32, align 4
  %j71 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 3200, i32* %N, align 4
  %0 = load i32, i32* %N, align 4
  %1 = load i32, i32* %N, align 4
  %mul = mul nsw i32 %0, %1
  %conv = sext i32 %mul to i64
  %mul1 = mul i64 %conv, 4
  %call = call i32 @_ZL17cudaMallocManagedIfE9cudaErrorPPT_mj(float** %x, i64 %mul1, i32 1)
  %2 = load i32, i32* %N, align 4
  %3 = load i32, i32* %N, align 4
  %mul2 = mul nsw i32 %2, %3
  %conv3 = sext i32 %mul2 to i64
  %mul4 = mul i64 %conv3, 4
  %call5 = call i32 @_ZL17cudaMallocManagedIfE9cudaErrorPPT_mj(float** %y, i64 %mul4, i32 1)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc14, %entry
  %4 = load i32, i32* %i, align 4
  %5 = load i32, i32* %N, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end16

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc, %for.body
  %6 = load i32, i32* %j, align 4
  %7 = load i32, i32* %N, align 4
  %cmp7 = icmp slt i32 %6, %7
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %8 = load i32, i32* %i, align 4
  %9 = load i32, i32* %N, align 4
  %mul9 = mul nsw i32 %8, %9
  %10 = load i32, i32* %j, align 4
  %add = add nsw i32 %mul9, %10
  %conv10 = sitofp i32 %add to float
  %mul11 = fmul contract float 1.000000e+00, %conv10
  %11 = load float*, float** %x, align 8
  %12 = load i32, i32* %i, align 4
  %13 = load i32, i32* %N, align 4
  %mul12 = mul nsw i32 %12, %13
  %14 = load i32, i32* %j, align 4
  %add13 = add nsw i32 %mul12, %14
  %idxprom = sext i32 %add13 to i64
  %arrayidx = getelementptr inbounds float, float* %11, i64 %idxprom
  store float %mul11, float* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %15 = load i32, i32* %j, align 4
  %inc = add nsw i32 %15, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond6

for.end:                                          ; preds = %for.cond6
  br label %for.inc14

for.inc14:                                        ; preds = %for.end
  %16 = load i32, i32* %i, align 4
  %inc15 = add nsw i32 %16, 1
  store i32 %inc15, i32* %i, align 4
  br label %for.cond

for.end16:                                        ; preds = %for.cond
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev(%"class.std::basic_ofstream"* %outfile)
  %call17 = invoke i32 @_ZStorSt13_Ios_OpenmodeS_(i32 16, i32 32)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %for.end16
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"* %outfile, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i64 0, i64 0), i32 %call17)
          to label %invoke.cont18 unwind label %lpad

invoke.cont18:                                    ; preds = %invoke.cont
  %17 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %call20 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %17, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0))
          to label %invoke.cont19 unwind label %lpad

invoke.cont19:                                    ; preds = %invoke.cont18
  %call22 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* %call20, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
          to label %invoke.cont21 unwind label %lpad

invoke.cont21:                                    ; preds = %invoke.cont19
  store i32 0, i32* %i23, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc44, %invoke.cont21
  %18 = load i32, i32* %i23, align 4
  %19 = load i32, i32* %N, align 4
  %cmp25 = icmp slt i32 %18, %19
  br i1 %cmp25, label %for.body26, label %for.end46

for.body26:                                       ; preds = %for.cond24
  store i32 0, i32* %j27, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc39, %for.body26
  %20 = load i32, i32* %j27, align 4
  %21 = load i32, i32* %N, align 4
  %cmp29 = icmp slt i32 %20, %21
  br i1 %cmp29, label %for.body30, label %for.end41

for.body30:                                       ; preds = %for.cond28
  %22 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %23 = load float*, float** %x, align 8
  %24 = load i32, i32* %i23, align 4
  %25 = load i32, i32* %N, align 4
  %mul31 = mul nsw i32 %24, %25
  %26 = load i32, i32* %j27, align 4
  %add32 = add nsw i32 %mul31, %26
  %idxprom33 = sext i32 %add32 to i64
  %arrayidx34 = getelementptr inbounds float, float* %23, i64 %idxprom33
  %27 = load float, float* %arrayidx34, align 4
  %call36 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"* %22, float %27)
          to label %invoke.cont35 unwind label %lpad

invoke.cont35:                                    ; preds = %for.body30
  %call38 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %call36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
          to label %invoke.cont37 unwind label %lpad

invoke.cont37:                                    ; preds = %invoke.cont35
  br label %for.inc39

for.inc39:                                        ; preds = %invoke.cont37
  %28 = load i32, i32* %j27, align 4
  %inc40 = add nsw i32 %28, 1
  store i32 %inc40, i32* %j27, align 4
  br label %for.cond28

lpad:                                             ; preds = %invoke.cont93, %invoke.cont91, %for.end90, %for.end85, %invoke.cont79, %for.body74, %invoke.cont63, %invoke.cont61, %kcall.end, %kcall.configok, %invoke.cont55, %invoke.cont49, %invoke.cont47, %for.end46, %for.end41, %invoke.cont35, %for.body30, %invoke.cont19, %invoke.cont18, %invoke.cont, %for.end16
  %29 = landingpad { i8*, i32 }
          cleanup
  %30 = extractvalue { i8*, i32 } %29, 0
  store i8* %30, i8** %exn.slot, align 8
  %31 = extractvalue { i8*, i32 } %29, 1
  store i32 %31, i32* %ehselector.slot, align 4
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* %outfile)
          to label %invoke.cont96 unwind label %terminate.lpad

for.end41:                                        ; preds = %for.cond28
  %32 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %call43 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %32, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
          to label %invoke.cont42 unwind label %lpad

invoke.cont42:                                    ; preds = %for.end41
  br label %for.inc44

for.inc44:                                        ; preds = %invoke.cont42
  %33 = load i32, i32* %i23, align 4
  %inc45 = add nsw i32 %33, 1
  store i32 %inc45, i32* %i23, align 4
  br label %for.cond24

for.end46:                                        ; preds = %for.cond24
  invoke void @_ZN4dim3C2Ejjj(%struct.dim3* %numThreads, i32 32, i32 8, i32 1)
          to label %invoke.cont47 unwind label %lpad

invoke.cont47:                                    ; preds = %for.end46
  %34 = load i32, i32* %N, align 4
  %div = sdiv i32 %34, 32
  %35 = load i32, i32* %N, align 4
  %div48 = sdiv i32 %35, 32
  invoke void @_ZN4dim3C2Ejjj(%struct.dim3* %numBlocks, i32 %div, i32 %div48, i32 1)
          to label %invoke.cont49 unwind label %lpad

invoke.cont49:                                    ; preds = %invoke.cont47
  %x50 = getelementptr inbounds %struct.dim3, %struct.dim3* %numBlocks, i32 0, i32 0
  %36 = load i32, i32* %x50, align 4
  %y51 = getelementptr inbounds %struct.dim3, %struct.dim3* %numBlocks, i32 0, i32 1
  %37 = load i32, i32* %y51, align 4
  %z = getelementptr inbounds %struct.dim3, %struct.dim3* %numBlocks, i32 0, i32 2
  %38 = load i32, i32* %z, align 4
  %x52 = getelementptr inbounds %struct.dim3, %struct.dim3* %numThreads, i32 0, i32 0
  %39 = load i32, i32* %x52, align 4
  %y53 = getelementptr inbounds %struct.dim3, %struct.dim3* %numThreads, i32 0, i32 1
  %40 = load i32, i32* %y53, align 4
  %z54 = getelementptr inbounds %struct.dim3, %struct.dim3* %numThreads, i32 0, i32 2
  %41 = load i32, i32* %z54, align 4
  %call56 = invoke i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.4, i64 0, i64 0), i32 %36, i32 %37, i32 %38, i32 %39, i32 %40, i32 %41)
          to label %invoke.cont55 unwind label %lpad

invoke.cont55:                                    ; preds = %invoke.cont49
  %42 = bitcast %struct.dim3* %agg.tmp to i8*
  %43 = bitcast %struct.dim3* %numBlocks to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %42, i8* align 4 %43, i64 12, i1 false)
  %44 = bitcast %struct.dim3* %agg.tmp57 to i8*
  %45 = bitcast %struct.dim3* %numThreads to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %44, i8* align 4 %45, i64 12, i1 false)
  %46 = bitcast { i64, i32 }* %agg.tmp.coerce to i8*
  %47 = bitcast %struct.dim3* %agg.tmp to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %46, i8* align 4 %47, i64 12, i1 false)
  %48 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp.coerce, i32 0, i32 0
  %49 = load i64, i64* %48, align 4
  %50 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp.coerce, i32 0, i32 1
  %51 = load i32, i32* %50, align 4
  %52 = bitcast { i64, i32 }* %agg.tmp57.coerce to i8*
  %53 = bitcast %struct.dim3* %agg.tmp57 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %52, i8* align 4 %53, i64 12, i1 false)
  %54 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp57.coerce, i32 0, i32 0
  %55 = load i64, i64* %54, align 4
  %56 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp57.coerce, i32 0, i32 1
  %57 = load i32, i32* %56, align 4
  %call59 = invoke i32 @__cudaPushCallConfiguration(i64 %49, i32 %51, i64 %55, i32 %57, i64 0, i8* null)
          to label %invoke.cont58 unwind label %lpad

invoke.cont58:                                    ; preds = %invoke.cont55
  %tobool = icmp ne i32 %call59, 0
  br i1 %tobool, label %kcall.end, label %kcall.configok

kcall.configok:                                   ; preds = %invoke.cont58
  %58 = load float*, float** %y, align 8
  %59 = load float*, float** %x, align 8
  invoke void @_Z9transposePfPKf(float* %58, float* %59)
          to label %invoke.cont60 unwind label %lpad

invoke.cont60:                                    ; preds = %kcall.configok
  br label %kcall.end

kcall.end:                                        ; preds = %invoke.cont60, %invoke.cont58
  %call62 = invoke i32 @cudaDeviceSynchronize()
          to label %invoke.cont61 unwind label %lpad

invoke.cont61:                                    ; preds = %kcall.end
  %60 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %call64 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %60, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.5, i64 0, i64 0))
          to label %invoke.cont63 unwind label %lpad

invoke.cont63:                                    ; preds = %invoke.cont61
  %call66 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* %call64, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
          to label %invoke.cont65 unwind label %lpad

invoke.cont65:                                    ; preds = %invoke.cont63
  store i32 0, i32* %i67, align 4
  br label %for.cond68

for.cond68:                                       ; preds = %for.inc88, %invoke.cont65
  %61 = load i32, i32* %i67, align 4
  %62 = load i32, i32* %N, align 4
  %cmp69 = icmp slt i32 %61, %62
  br i1 %cmp69, label %for.body70, label %for.end90

for.body70:                                       ; preds = %for.cond68
  store i32 0, i32* %j71, align 4
  br label %for.cond72

for.cond72:                                       ; preds = %for.inc83, %for.body70
  %63 = load i32, i32* %j71, align 4
  %64 = load i32, i32* %N, align 4
  %cmp73 = icmp slt i32 %63, %64
  br i1 %cmp73, label %for.body74, label %for.end85

for.body74:                                       ; preds = %for.cond72
  %65 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %66 = load float*, float** %y, align 8
  %67 = load i32, i32* %i67, align 4
  %68 = load i32, i32* %N, align 4
  %mul75 = mul nsw i32 %67, %68
  %69 = load i32, i32* %j71, align 4
  %add76 = add nsw i32 %mul75, %69
  %idxprom77 = sext i32 %add76 to i64
  %arrayidx78 = getelementptr inbounds float, float* %66, i64 %idxprom77
  %70 = load float, float* %arrayidx78, align 4
  %call80 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"* %65, float %70)
          to label %invoke.cont79 unwind label %lpad

invoke.cont79:                                    ; preds = %for.body74
  %call82 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %call80, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
          to label %invoke.cont81 unwind label %lpad

invoke.cont81:                                    ; preds = %invoke.cont79
  br label %for.inc83

for.inc83:                                        ; preds = %invoke.cont81
  %71 = load i32, i32* %j71, align 4
  %inc84 = add nsw i32 %71, 1
  store i32 %inc84, i32* %j71, align 4
  br label %for.cond72

for.end85:                                        ; preds = %for.cond72
  %72 = bitcast %"class.std::basic_ofstream"* %outfile to %"class.std::basic_ostream"*
  %call87 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) %72, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
          to label %invoke.cont86 unwind label %lpad

invoke.cont86:                                    ; preds = %for.end85
  br label %for.inc88

for.inc88:                                        ; preds = %invoke.cont86
  %73 = load i32, i32* %i67, align 4
  %inc89 = add nsw i32 %73, 1
  store i32 %inc89, i32* %i67, align 4
  br label %for.cond68

for.end90:                                        ; preds = %for.cond68
  %74 = load float*, float** %x, align 8
  %75 = bitcast float* %74 to i8*
  %call92 = invoke i32 @cudaFree(i8* %75)
          to label %invoke.cont91 unwind label %lpad

invoke.cont91:                                    ; preds = %for.end90
  %76 = load float*, float** %y, align 8
  %77 = bitcast float* %76 to i8*
  %call94 = invoke i32 @cudaFree(i8* %77)
          to label %invoke.cont93 unwind label %lpad

invoke.cont93:                                    ; preds = %invoke.cont91
  invoke void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv(%"class.std::basic_ofstream"* %outfile)
          to label %invoke.cont95 unwind label %lpad

invoke.cont95:                                    ; preds = %invoke.cont93
  store i32 0, i32* %retval, align 4
  call void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"* %outfile)
  %78 = load i32, i32* %retval, align 4
  ret i32 %78

invoke.cont96:                                    ; preds = %lpad
  br label %eh.resume

eh.resume:                                        ; preds = %invoke.cont96
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val97 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val97

terminate.lpad:                                   ; preds = %lpad
  %79 = landingpad { i8*, i32 }
          catch i8* null
  %80 = extractvalue { i8*, i32 } %79, 0
  call void @__clang_call_terminate(i8* %80) #8
  unreachable
}

; Function Attrs: noinline optnone uwtable
define internal i32 @_ZL17cudaMallocManagedIfE9cudaErrorPPT_mj(float** %devPtr, i64 %size, i32 %flags) #3 {
entry:
  %devPtr.addr = alloca float**, align 8
  %size.addr = alloca i64, align 8
  %flags.addr = alloca i32, align 4
  store float** %devPtr, float*** %devPtr.addr, align 8
  store i64 %size, i64* %size.addr, align 8
  store i32 %flags, i32* %flags.addr, align 4
  %0 = load float**, float*** %devPtr.addr, align 8
  %1 = bitcast float** %0 to i8*
  %2 = bitcast i8* %1 to i8**
  %3 = load i64, i64* %size.addr, align 8
  %4 = load i32, i32* %flags.addr, align 4
  %call = call i32 @cudaMallocManaged(i8** %2, i64 %3, i32 %4)
  ret i32 %call
}

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev(%"class.std::basic_ofstream"*) unnamed_addr #1

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_ofstream"*, i8*, i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_ZStorSt13_Ios_OpenmodeS_(i32 %__a, i32 %__b) #6 comdat {
entry:
  %__a.addr = alloca i32, align 4
  %__b.addr = alloca i32, align 4
  store i32 %__a, i32* %__a.addr, align 4
  store i32 %__b, i32* %__b.addr, align 4
  %0 = load i32, i32* %__a.addr, align 4
  %1 = load i32, i32* %__b.addr, align 4
  %or = or i32 %0, %1
  ret i32 %or
}

declare dso_local i32 @__gxx_personality_v0(...)

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272), i8*) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"*, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)*) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* dereferenceable(272)) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"*, float) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local void @_ZN4dim3C2Ejjj(%struct.dim3* %this, i32 %vx, i32 %vy, i32 %vz) unnamed_addr #6 comdat align 2 {
entry:
  %this.addr = alloca %struct.dim3*, align 8
  %vx.addr = alloca i32, align 4
  %vy.addr = alloca i32, align 4
  %vz.addr = alloca i32, align 4
  store %struct.dim3* %this, %struct.dim3** %this.addr, align 8
  store i32 %vx, i32* %vx.addr, align 4
  store i32 %vy, i32* %vy.addr, align 4
  store i32 %vz, i32* %vz.addr, align 4
  %this1 = load %struct.dim3*, %struct.dim3** %this.addr, align 8
  %x = getelementptr inbounds %struct.dim3, %struct.dim3* %this1, i32 0, i32 0
  %0 = load i32, i32* %vx.addr, align 4
  store i32 %0, i32* %x, align 4
  %y = getelementptr inbounds %struct.dim3, %struct.dim3* %this1, i32 0, i32 1
  %1 = load i32, i32* %vy.addr, align 4
  store i32 %1, i32* %y, align 4
  %z = getelementptr inbounds %struct.dim3, %struct.dim3* %this1, i32 0, i32 2
  %2 = load i32, i32* %vz.addr, align 4
  store i32 %2, i32* %z, align 4
  ret void
}

declare dso_local i32 @printf(i8*, ...) #1

declare dso_local i32 @__cudaPushCallConfiguration(i64, i32, i64, i32, i64, i8*) #1

declare dso_local i32 @cudaDeviceSynchronize() #1

declare dso_local i32 @cudaFree(i8*) #1

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv(%"class.std::basic_ofstream"*) #1

declare dso_local void @_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev(%"class.std::basic_ofstream"*) unnamed_addr #1

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #7 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #2
  call void @_ZSt9terminatev() #8
  unreachable
}

declare dso_local i8* @__cxa_begin_catch(i8*)

declare dso_local void @_ZSt9terminatev()

declare dso_local i32 @cudaMallocManaged(i8**, i64, i32) #1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_matrix_transpose.cu() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { noinline norecurse optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noinline noreturn nounwind }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 9.0.0 (/home/rohitkan/eecs583/project/llvm/llvm/llvm-9.0.0.src/tools/cfe-9.0.0.src aee663923236c29a1978c306960ac5cbe972b4dd)"}
