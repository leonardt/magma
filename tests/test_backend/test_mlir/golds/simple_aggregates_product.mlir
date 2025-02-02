hw.module @simple_aggregates_product(%a: !hw.struct<x: i8, y: i8>) -> (y: !hw.struct<x: i8, y: i8>) {
    %0 = hw.struct_extract %a["x"] : !hw.struct<x: i8, y: i8>
    %2 = hw.constant -1 : i8
    %1 = comb.xor %2, %0 : i8
    %3 = hw.struct_extract %a["y"] : !hw.struct<x: i8, y: i8>
    %4 = comb.xor %2, %3 : i8
    %5 = hw.struct_create (%1, %4) : !hw.struct<x: i8, y: i8>
    hw.output %5 : !hw.struct<x: i8, y: i8>
}
