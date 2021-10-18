from typing import Union

import magma as m

from magma_common import value_or_type_to_string


class MagmaArrayGetOp(m.Generator2):
    def __init__(self, T: m.ArrayMeta):
        assert isinstance(T, m.ArrayMeta)
        T = T.undirected_t
        self.name = f"magma_array_get_op_{value_or_type_to_string(T)}"
        self.primitive = True

        T_out = T.T
        self.io = m.IO(I=m.In(T), O=m.Out(T_out))

        self.T = T


class MagmaArraySliceOp(m.Generator2):
    def __init__(self, T: m.ArrayMeta, lo: int, hi: int):
        assert isinstance(T, m.ArrayMeta)
        T = T.undirected_t
        type_string = value_or_type_to_string(T)
        self.name = f"magma_array_slice_op_{type_string}_{lo}_{hi}"
        self.primitive = True

        T_out = T.unsized_t[hi - lo]
        self.io = m.IO(I=m.In(T), O=m.Out(T_out))

        self.T = T
        self.lo = lo
        self.hi = hi


class MagmaArrayCreateOp(m.Generator2):
    def __init__(self, T: m.ArrayMeta):
        assert isinstance(T, m.ArrayMeta)
        T = T.undirected_t
        self.name = f"magma_array_create_op_{value_or_type_to_string(T)}"
        self.primitive = True

        self.io = (m.IO(**{f"I{i}": m.In(T.T) for i in range(T.N)}) +
                   m.IO(O=m.Out(T)))
        self.T = T


class MagmaProductGetOp(m.Generator2):
    def __init__(self, T: m.ProductMeta, index: Union[int, str]):
        assert isinstance(T, m.ProductMeta)
        T = T.undirected_t
        self.name = f"magma_product_get_op_{value_or_type_to_string(T)}_{index}"
        self.primitive = True

        T_out = T.field_dict[index]
        self.io = m.IO(I=m.In(T), O=m.Out(T_out))

        self.T = T
        self.index = index


class MagmaProductCreateOp(m.Generator2):
    def __init__(self, T: m.ProductMeta):
        assert isinstance(T, m.ProductMeta)
        T = T.undirected_t
        self.name = f"magma_tuple_create_op_{value_or_type_to_string(T)}"
        self.primitive = True

        fields = T.field_dict
        self.io = (m.IO(**{f"I{k}": m.In(t) for k, t in fields.items()}) +
                   m.IO(O=m.Out(T)))


class MagmaBitConstantOp(m.Generator2):
    def __init__(self, T: m.DigitalMeta, value: bool):
        assert isinstance(T, m.DigitalMeta)
        T = T.undirected_t
        self.name = f"magma_bit_constant_op_{value_or_type_to_string(T)}"
        self.primitive = True

        self.io = m.IO(O=m.Out(T))

        self.value = value


class MagmaBitsConstantOp(m.Generator2):
    def __init__(self, T: m.BitsMeta, value: int):
        assert isinstance(T, m.BitsMeta)
        T = T.undirected_t
        self.name = f"magma_bits_constant_op_{value_or_type_to_string(T)}"
        self.primitive = True

        self.io = m.IO(O=m.Out(T))

        self.value = value
