from typing import Union

from magma.array import ArrayMeta
from magma.backend.mlir.magma_common import (
    InstanceWrapper, value_or_type_to_string)
from magma.bits import BitsMeta
from magma.digital import DigitalMeta
from magma.generator import Generator2
from magma.interface import IO
from magma.t import In, Out
from magma.tuple import TupleMeta, ProductMeta


def _get_tuple_field_type(T: TupleMeta, index: Union[int, str]):
    if isinstance(T, ProductMeta):
        return T.field_dict[index]
    index = int(index)
    return T.field_dict[index]


def MagmaArrayGetOp(T: ArrayMeta, index: str):
    assert isinstance(T, ArrayMeta)
    T = T.undirected_t
    name = f"magma_array_get_op_{value_or_type_to_string(T)}"
    T_out = T.T
    ports = dict(I=In(T), O=Out(T_out))
    attrs = dict(T=T, index=index)
    return InstanceWrapper(name, ports, attrs)


class MagmaArraySliceOp(Generator2):
    def __init__(self, T: ArrayMeta, lo: int, hi: int):
        assert isinstance(T, ArrayMeta)
        T = T.undirected_t
        type_string = value_or_type_to_string(T)
        self.name = f"magma_array_slice_op_{type_string}_{lo}_{hi}"
        self.primitive = True

        T_out = T.unsized_t[hi - lo]
        self.io = IO(I=In(T), O=Out(T_out))

        self.T = T
        self.lo = lo
        self.hi = hi


def MagmaArrayCreateOp(T: ArrayMeta):
    assert isinstance(T, ArrayMeta)
    T = T.undirected_t
    name = f"magma_array_create_op_{value_or_type_to_string(T)}"
    ports = dict(**{f"I{i}": In(T.T) for i in range(T.N)})
    ports.update(dict(O=Out(T)))
    attrs = dict(T=T)
    return InstanceWrapper(name, ports, attrs)


def MagmaTupleGetOp(T: TupleMeta, index: Union[int, str]):
    assert isinstance(T, TupleMeta)
    T = T.undirected_t
    name = f"magma_tuple_get_op_{value_or_type_to_string(T)}_{index}"
    T_out = _get_tuple_field_type(T, index)
    ports = dict(I=In(T), O=Out(T_out))
    attrs = dict(T=T, index=index)
    return InstanceWrapper(name, ports, attrs)


def MagmaTupleCreateOp(T: TupleMeta):
    assert isinstance(T, TupleMeta)
    T = T.undirected_t
    name = f"magma_tuple_create_op_{value_or_type_to_string(T)}"
    fields = T.field_dict
    ports = dict(**{f"I{k}": In(t) for k, t in fields.items()})
    ports.update(dict(O=Out(T)))
    return InstanceWrapper(name, ports, {})


def MagmaBitConstantOp(T: DigitalMeta, value: bool):
    assert isinstance(T, DigitalMeta)
    T = T.undirected_t
    name = f"magma_bit_constant_op_{value_or_type_to_string(T)}"
    ports = dict(O=Out(T))
    attrs = dict(value=value)
    return InstanceWrapper(name, ports, attrs)


def MagmaBitsConstantOp(T: BitsMeta, value: int):
    assert isinstance(T, BitsMeta)
    T = T.undirected_t
    name = f"magma_bits_constant_op_{value_or_type_to_string(T)}"
    ports = dict(O=Out(T))
    attrs = dict(value=value)
    return InstanceWrapper(name, ports, attrs)
