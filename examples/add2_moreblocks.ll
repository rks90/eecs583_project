; ModuleID = 'add2_moreblocks.cu'
source_filename = "add2_moreblocks.cu"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%struct.dim3 = type { i32, i32, i32 }
%struct.CUstream_st = type opaque

$_ZN4dim3C2Ejjj = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZSt4cout = external dso_local global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [12 x i8] c"Max error: \00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_add2_moreblocks.cu, i8* null }]

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
define dso_local void @_Z3addiPfS_(i32 %n, float* %x, float* %y) #3 {
entry:
  %n.addr = alloca i32, align 4
  %x.addr = alloca float*, align 8
  %y.addr = alloca float*, align 8
  store i32 %n, i32* %n.addr, align 4
  store float* %x, float** %x.addr, align 8
  store float* %y, float** %y.addr, align 8
  %0 = bitcast i32* %n.addr to i8*
  %1 = call i32 @cudaSetupArgument(i8* %0, i64 4, i64 0)
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %setup.next, label %setup.end

setup.next:                                       ; preds = %entry
  %3 = bitcast float** %x.addr to i8*
  %4 = call i32 @cudaSetupArgument(i8* %3, i64 8, i64 8)
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %setup.next1, label %setup.end

setup.next1:                                      ; preds = %setup.next
  %6 = bitcast float** %y.addr to i8*
  %7 = call i32 @cudaSetupArgument(i8* %6, i64 8, i64 16)
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %setup.next2, label %setup.end

setup.next2:                                      ; preds = %setup.next1
  %9 = call i32 @cudaLaunch(i8* bitcast (void (i32, float*, float*)* @_Z3addiPfS_ to i8*))
  br label %setup.end

setup.end:                                        ; preds = %setup.next2, %setup.next1, %setup.next, %entry
  ret void
}

declare dso_local i32 @cudaSetupArgument(i8*, i64, i64)

declare dso_local i32 @cudaLaunch(i8*)

; Function Attrs: noinline norecurse optnone uwtable
define dso_local i32 @main() #4 {
entry:
  %retval = alloca i32, align 4
  %N = alloca i32, align 4
  %blockSize = alloca i32, align 4
  %numBlocks = alloca i32, align 4
  %x = alloca float*, align 8
  %y = alloca float*, align 8
  %d_x = alloca float*, align 8
  %d_y = alloca float*, align 8
  %i = alloca i32, align 4
  %agg.tmp = alloca %struct.dim3, align 4
  %agg.tmp18 = alloca %struct.dim3, align 4
  %agg.tmp.coerce = alloca { i64, i32 }, align 4
  %agg.tmp18.coerce = alloca { i64, i32 }, align 4
  %maxError = alloca float, align 4
  %i23 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 1048576, i32* %N, align 4
  store i32 256, i32* %blockSize, align 4
  %0 = load i32, i32* %N, align 4
  %1 = load i32, i32* %blockSize, align 4
  %add = add nsw i32 %0, %1
  %sub = sub nsw i32 %add, 1
  %2 = load i32, i32* %blockSize, align 4
  %div = sdiv i32 %sub, %2
  store i32 %div, i32* %numBlocks, align 4
  %3 = load i32, i32* %N, align 4
  %conv = sext i32 %3 to i64
  %mul = mul i64 %conv, 4
  %call = call noalias i8* @malloc(i64 %mul) #2
  %4 = bitcast i8* %call to float*
  store float* %4, float** %x, align 8
  %5 = load i32, i32* %N, align 4
  %conv1 = sext i32 %5 to i64
  %mul2 = mul i64 %conv1, 4
  %call3 = call noalias i8* @malloc(i64 %mul2) #2
  %6 = bitcast i8* %call3 to float*
  store float* %6, float** %y, align 8
  %7 = load i32, i32* %N, align 4
  %conv4 = sext i32 %7 to i64
  %mul5 = mul i64 %conv4, 4
  %call6 = call i32 @_ZL10cudaMallocIfE9cudaErrorPPT_m(float** %d_x, i64 %mul5)
  %8 = load i32, i32* %N, align 4
  %conv7 = sext i32 %8 to i64
  %mul8 = mul i64 %conv7, 4
  %call9 = call i32 @_ZL10cudaMallocIfE9cudaErrorPPT_m(float** %d_y, i64 %mul8)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %9 = load i32, i32* %i, align 4
  %10 = load i32, i32* %N, align 4
  %cmp = icmp slt i32 %9, %10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %11 = load float*, float** %x, align 8
  %12 = load i32, i32* %i, align 4
  %idxprom = sext i32 %12 to i64
  %arrayidx = getelementptr inbounds float, float* %11, i64 %idxprom
  store float 1.000000e+00, float* %arrayidx, align 4
  %13 = load float*, float** %y, align 8
  %14 = load i32, i32* %i, align 4
  %idxprom10 = sext i32 %14 to i64
  %arrayidx11 = getelementptr inbounds float, float* %13, i64 %idxprom10
  store float 2.000000e+00, float* %arrayidx11, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %15 = load i32, i32* %i, align 4
  %inc = add nsw i32 %15, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %16 = load float*, float** %d_x, align 8
  %17 = bitcast float* %16 to i8*
  %18 = load float*, float** %x, align 8
  %19 = bitcast float* %18 to i8*
  %20 = load i32, i32* %N, align 4
  %conv12 = sext i32 %20 to i64
  %mul13 = mul i64 %conv12, 4
  %call14 = call i32 @cudaMemcpy(i8* %17, i8* %19, i64 %mul13, i32 1)
  %21 = load float*, float** %d_y, align 8
  %22 = bitcast float* %21 to i8*
  %23 = load float*, float** %y, align 8
  %24 = bitcast float* %23 to i8*
  %25 = load i32, i32* %N, align 4
  %conv15 = sext i32 %25 to i64
  %mul16 = mul i64 %conv15, 4
  %call17 = call i32 @cudaMemcpy(i8* %22, i8* %24, i64 %mul16, i32 1)
  %26 = load i32, i32* %numBlocks, align 4
  call void @_ZN4dim3C2Ejjj(%struct.dim3* %agg.tmp, i32 %26, i32 1, i32 1)
  %27 = load i32, i32* %blockSize, align 4
  call void @_ZN4dim3C2Ejjj(%struct.dim3* %agg.tmp18, i32 %27, i32 1, i32 1)
  %28 = bitcast { i64, i32 }* %agg.tmp.coerce to i8*
  %29 = bitcast %struct.dim3* %agg.tmp to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %28, i8* align 4 %29, i64 12, i1 false)
  %30 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp.coerce, i32 0, i32 0
  %31 = load i64, i64* %30, align 4
  %32 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp.coerce, i32 0, i32 1
  %33 = load i32, i32* %32, align 4
  %34 = bitcast { i64, i32 }* %agg.tmp18.coerce to i8*
  %35 = bitcast %struct.dim3* %agg.tmp18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %34, i8* align 4 %35, i64 12, i1 false)
  %36 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp18.coerce, i32 0, i32 0
  %37 = load i64, i64* %36, align 4
  %38 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %agg.tmp18.coerce, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  %call19 = call i32 @cudaConfigureCall(i64 %31, i32 %33, i64 %37, i32 %39, i64 0, %struct.CUstream_st* null)
  %tobool = icmp ne i32 %call19, 0
  br i1 %tobool, label %kcall.end, label %kcall.configok

kcall.configok:                                   ; preds = %for.end
  %40 = load i32, i32* %N, align 4
  %41 = load float*, float** %d_x, align 8
  %42 = load float*, float** %d_y, align 8
  call void @_Z3addiPfS_(i32 %40, float* %41, float* %42)
  br label %kcall.end

kcall.end:                                        ; preds = %kcall.configok, %for.end
  %43 = load float*, float** %y, align 8
  %44 = bitcast float* %43 to i8*
  %45 = load float*, float** %d_y, align 8
  %46 = bitcast float* %45 to i8*
  %47 = load i32, i32* %N, align 4
  %conv20 = sext i32 %47 to i64
  %mul21 = mul i64 %conv20, 4
  %call22 = call i32 @cudaMemcpy(i8* %44, i8* %46, i64 %mul21, i32 2)
  store float 0.000000e+00, float* %maxError, align 4
  store i32 0, i32* %i23, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc33, %kcall.end
  %48 = load i32, i32* %i23, align 4
  %49 = load i32, i32* %N, align 4
  %cmp25 = icmp slt i32 %48, %49
  br i1 %cmp25, label %for.body26, label %for.end35

for.body26:                                       ; preds = %for.cond24
  %50 = load float, float* %maxError, align 4
  %conv27 = fpext float %50 to double
  %51 = load float*, float** %y, align 8
  %52 = load i32, i32* %i23, align 4
  %idxprom28 = sext i32 %52 to i64
  %arrayidx29 = getelementptr inbounds float, float* %51, i64 %idxprom28
  %53 = load float, float* %arrayidx29, align 4
  %sub30 = fsub contract float %53, 3.000000e+00
  %conv31 = fpext float %sub30 to double
  %54 = call double @llvm.fabs.f64(double %conv31)
  %55 = call double @llvm.maxnum.f64(double %conv27, double %54)
  %conv32 = fptrunc double %55 to float
  store float %conv32, float* %maxError, align 4
  br label %for.inc33

for.inc33:                                        ; preds = %for.body26
  %56 = load i32, i32* %i23, align 4
  %inc34 = add nsw i32 %56, 1
  store i32 %inc34, i32* %i23, align 4
  br label %for.cond24

for.end35:                                        ; preds = %for.cond24
  %call36 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) @_ZSt4cout, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0))
  %57 = load float, float* %maxError, align 4
  %call37 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"* %call36, float %57)
  %call38 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* %call37, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
  %58 = load float*, float** %d_x, align 8
  %59 = bitcast float* %58 to i8*
  %call39 = call i32 @cudaFree(i8* %59)
  %60 = load float*, float** %d_y, align 8
  %61 = bitcast float* %60 to i8*
  %call40 = call i32 @cudaFree(i8* %61)
  %62 = load float*, float** %x, align 8
  %63 = bitcast float* %62 to i8*
  call void @free(i8* %63) #2
  %64 = load float*, float** %y, align 8
  %65 = bitcast float* %64 to i8*
  call void @free(i8* %65) #2
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #5

; Function Attrs: noinline optnone uwtable
define internal i32 @_ZL10cudaMallocIfE9cudaErrorPPT_m(float** %devPtr, i64 %size) #3 {
entry:
  %devPtr.addr = alloca float**, align 8
  %size.addr = alloca i64, align 8
  store float** %devPtr, float*** %devPtr.addr, align 8
  store i64 %size, i64* %size.addr, align 8
  %0 = load float**, float*** %devPtr.addr, align 8
  %1 = bitcast float** %0 to i8*
  %2 = bitcast i8* %1 to i8**
  %3 = load i64, i64* %size.addr, align 8
  %call = call i32 @cudaMalloc(i8** %2, i64 %3)
  ret i32 %call
}

declare dso_local i32 @cudaMemcpy(i8*, i8*, i64, i32) #1

declare dso_local i32 @cudaConfigureCall(i64, i32, i64, i32, i64, %struct.CUstream_st*) #1

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

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nounwind readnone speculatable
declare double @llvm.fabs.f64(double) #8

; Function Attrs: nounwind readnone speculatable
declare double @llvm.maxnum.f64(double, double) #8

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272), i8*) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEf(%"class.std::basic_ostream"*, float) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"*, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)*) #1

declare dso_local dereferenceable(272) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* dereferenceable(272)) #1

declare dso_local i32 @cudaFree(i8*) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #5

declare dso_local i32 @cudaMalloc(i8**, i64) #1

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_add2_moreblocks.cu() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline norecurse optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { argmemonly nounwind }
attributes #8 = { nounwind readnone speculatable }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 9, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 9.0.0 (/home/rohitkan/eecs583/project/llvm/llvm-9.0.0.src/tools/cfe-9.0.0.src 5c8484f0e205ce27cdc1c53371f150aa6bc5519b)"}
