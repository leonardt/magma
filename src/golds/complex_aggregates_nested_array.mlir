hw.module @complex_aggregates_nested_array(%a: !hw.array<2x!hw.array<3xi4>>) -> (%y: !hw.array<2x!hw.array<3xi4>>) {
    %1 = hw.constant 0 : i1
    %0 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %3 = hw.constant 0 : i2
    %2 = hw.array_get %0[%3] : !hw.array<3xi4>
    %4 = comb.extract %2 from 0 : (i4) -> i1
    %6 = hw.constant 1 : i1
    %5 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %8 = hw.constant 2 : i2
    %7 = hw.array_get %5[%8] : !hw.array<3xi4>
    %9 = comb.extract %7 from 3 : (i4) -> i1
    %10 = comb.or %4, %9 : i1
    %11 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %12 = hw.array_get %11[%3] : !hw.array<3xi4>
    %13 = comb.extract %12 from 1 : (i4) -> i1
    %14 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %15 = hw.array_get %14[%8] : !hw.array<3xi4>
    %16 = comb.extract %15 from 2 : (i4) -> i1
    %17 = comb.or %13, %16 : i1
    %18 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %19 = hw.array_get %18[%3] : !hw.array<3xi4>
    %20 = comb.extract %19 from 2 : (i4) -> i1
    %21 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %22 = hw.array_get %21[%8] : !hw.array<3xi4>
    %23 = comb.extract %22 from 1 : (i4) -> i1
    %24 = comb.or %20, %23 : i1
    %25 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %26 = hw.array_get %25[%3] : !hw.array<3xi4>
    %27 = comb.extract %26 from 3 : (i4) -> i1
    %28 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %29 = hw.array_get %28[%8] : !hw.array<3xi4>
    %30 = comb.extract %29 from 0 : (i4) -> i1
    %31 = comb.or %27, %30 : i1
    %32 = comb.concat %31, %24, %17, %10 : (i1, i1, i1, i1) -> (i4)
    %33 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %35 = hw.constant 1 : i2
    %34 = hw.array_get %33[%35] : !hw.array<3xi4>
    %36 = comb.extract %34 from 0 : (i4) -> i1
    %37 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %38 = hw.array_get %37[%35] : !hw.array<3xi4>
    %39 = comb.extract %38 from 3 : (i4) -> i1
    %40 = comb.or %36, %39 : i1
    %41 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %42 = hw.array_get %41[%35] : !hw.array<3xi4>
    %43 = comb.extract %42 from 1 : (i4) -> i1
    %44 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %45 = hw.array_get %44[%35] : !hw.array<3xi4>
    %46 = comb.extract %45 from 2 : (i4) -> i1
    %47 = comb.or %43, %46 : i1
    %48 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %49 = hw.array_get %48[%35] : !hw.array<3xi4>
    %50 = comb.extract %49 from 2 : (i4) -> i1
    %51 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %52 = hw.array_get %51[%35] : !hw.array<3xi4>
    %53 = comb.extract %52 from 1 : (i4) -> i1
    %54 = comb.or %50, %53 : i1
    %55 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %56 = hw.array_get %55[%35] : !hw.array<3xi4>
    %57 = comb.extract %56 from 3 : (i4) -> i1
    %58 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %59 = hw.array_get %58[%35] : !hw.array<3xi4>
    %60 = comb.extract %59 from 0 : (i4) -> i1
    %61 = comb.or %57, %60 : i1
    %62 = comb.concat %61, %54, %47, %40 : (i1, i1, i1, i1) -> (i4)
    %63 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %64 = hw.array_get %63[%8] : !hw.array<3xi4>
    %65 = comb.extract %64 from 0 : (i4) -> i1
    %66 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %67 = hw.array_get %66[%3] : !hw.array<3xi4>
    %68 = comb.extract %67 from 3 : (i4) -> i1
    %69 = comb.or %65, %68 : i1
    %70 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %71 = hw.array_get %70[%8] : !hw.array<3xi4>
    %72 = comb.extract %71 from 1 : (i4) -> i1
    %73 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %74 = hw.array_get %73[%3] : !hw.array<3xi4>
    %75 = comb.extract %74 from 2 : (i4) -> i1
    %76 = comb.or %72, %75 : i1
    %77 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %78 = hw.array_get %77[%8] : !hw.array<3xi4>
    %79 = comb.extract %78 from 2 : (i4) -> i1
    %80 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %81 = hw.array_get %80[%3] : !hw.array<3xi4>
    %82 = comb.extract %81 from 1 : (i4) -> i1
    %83 = comb.or %79, %82 : i1
    %84 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %85 = hw.array_get %84[%8] : !hw.array<3xi4>
    %86 = comb.extract %85 from 3 : (i4) -> i1
    %87 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %88 = hw.array_get %87[%3] : !hw.array<3xi4>
    %89 = comb.extract %88 from 0 : (i4) -> i1
    %90 = comb.or %86, %89 : i1
    %91 = comb.concat %90, %83, %76, %69 : (i1, i1, i1, i1) -> (i4)
    %92 = hw.array_create %91, %62, %32 : i4
    %93 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %94 = hw.array_get %93[%3] : !hw.array<3xi4>
    %95 = comb.extract %94 from 0 : (i4) -> i1
    %96 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %97 = hw.array_get %96[%8] : !hw.array<3xi4>
    %98 = comb.extract %97 from 3 : (i4) -> i1
    %99 = comb.or %95, %98 : i1
    %100 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %101 = hw.array_get %100[%3] : !hw.array<3xi4>
    %102 = comb.extract %101 from 1 : (i4) -> i1
    %103 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %104 = hw.array_get %103[%8] : !hw.array<3xi4>
    %105 = comb.extract %104 from 2 : (i4) -> i1
    %106 = comb.or %102, %105 : i1
    %107 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %108 = hw.array_get %107[%3] : !hw.array<3xi4>
    %109 = comb.extract %108 from 2 : (i4) -> i1
    %110 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %111 = hw.array_get %110[%8] : !hw.array<3xi4>
    %112 = comb.extract %111 from 1 : (i4) -> i1
    %113 = comb.or %109, %112 : i1
    %114 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %115 = hw.array_get %114[%3] : !hw.array<3xi4>
    %116 = comb.extract %115 from 3 : (i4) -> i1
    %117 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %118 = hw.array_get %117[%8] : !hw.array<3xi4>
    %119 = comb.extract %118 from 0 : (i4) -> i1
    %120 = comb.or %116, %119 : i1
    %121 = comb.concat %120, %113, %106, %99 : (i1, i1, i1, i1) -> (i4)
    %122 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %123 = hw.array_get %122[%35] : !hw.array<3xi4>
    %124 = comb.extract %123 from 0 : (i4) -> i1
    %125 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %126 = hw.array_get %125[%35] : !hw.array<3xi4>
    %127 = comb.extract %126 from 3 : (i4) -> i1
    %128 = comb.or %124, %127 : i1
    %129 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %130 = hw.array_get %129[%35] : !hw.array<3xi4>
    %131 = comb.extract %130 from 1 : (i4) -> i1
    %132 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %133 = hw.array_get %132[%35] : !hw.array<3xi4>
    %134 = comb.extract %133 from 2 : (i4) -> i1
    %135 = comb.or %131, %134 : i1
    %136 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %137 = hw.array_get %136[%35] : !hw.array<3xi4>
    %138 = comb.extract %137 from 2 : (i4) -> i1
    %139 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %140 = hw.array_get %139[%35] : !hw.array<3xi4>
    %141 = comb.extract %140 from 1 : (i4) -> i1
    %142 = comb.or %138, %141 : i1
    %143 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %144 = hw.array_get %143[%35] : !hw.array<3xi4>
    %145 = comb.extract %144 from 3 : (i4) -> i1
    %146 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %147 = hw.array_get %146[%35] : !hw.array<3xi4>
    %148 = comb.extract %147 from 0 : (i4) -> i1
    %149 = comb.or %145, %148 : i1
    %150 = comb.concat %149, %142, %135, %128 : (i1, i1, i1, i1) -> (i4)
    %151 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %152 = hw.array_get %151[%8] : !hw.array<3xi4>
    %153 = comb.extract %152 from 0 : (i4) -> i1
    %154 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %155 = hw.array_get %154[%3] : !hw.array<3xi4>
    %156 = comb.extract %155 from 3 : (i4) -> i1
    %157 = comb.or %153, %156 : i1
    %158 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %159 = hw.array_get %158[%8] : !hw.array<3xi4>
    %160 = comb.extract %159 from 1 : (i4) -> i1
    %161 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %162 = hw.array_get %161[%3] : !hw.array<3xi4>
    %163 = comb.extract %162 from 2 : (i4) -> i1
    %164 = comb.or %160, %163 : i1
    %165 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %166 = hw.array_get %165[%8] : !hw.array<3xi4>
    %167 = comb.extract %166 from 2 : (i4) -> i1
    %168 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %169 = hw.array_get %168[%3] : !hw.array<3xi4>
    %170 = comb.extract %169 from 1 : (i4) -> i1
    %171 = comb.or %167, %170 : i1
    %172 = hw.array_get %a[%6] : !hw.array<2x!hw.array<3xi4>>
    %173 = hw.array_get %172[%8] : !hw.array<3xi4>
    %174 = comb.extract %173 from 3 : (i4) -> i1
    %175 = hw.array_get %a[%1] : !hw.array<2x!hw.array<3xi4>>
    %176 = hw.array_get %175[%3] : !hw.array<3xi4>
    %177 = comb.extract %176 from 0 : (i4) -> i1
    %178 = comb.or %174, %177 : i1
    %179 = comb.concat %178, %171, %164, %157 : (i1, i1, i1, i1) -> (i4)
    %180 = hw.array_create %179, %150, %121 : i4
    %181 = hw.array_create %180, %92 : !hw.array<3xi4>
    hw.output %181 : !hw.array<2x!hw.array<3xi4>>
}
