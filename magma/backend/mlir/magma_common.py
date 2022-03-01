import dataclasses
from typing import Any, Callable, Mapping, Union

from magma.array import Array, ArrayMeta
from magma.backend.mlir.common import make_unique_name, replace_all
from magma.circuit import Circuit, DefineCircuitKind
from magma.ref import Ref, ArrayRef, TupleRef
from magma.t import Kind, Type
from magma.tuple import TupleMeta, Tuple as m_Tuple


ModuleLike = Union[DefineCircuitKind, Circuit]


_VALUE_OR_TYPE_TO_STRING_REPLACEMENTS = {
    "(": "_",
    ")": "",
    "[": "_",
    "]": "",
    " ": "",
    ",": "_",
    "=": "_",
    ".": "_",
}


def value_or_type_to_string(value_or_type: Union[Type, Kind]):
    if isinstance(value_or_type, Type):
        s = value_or_type.name.qualifiedname("_")
    else:
        s = str(value_or_type)
    return replace_all(s, _VALUE_OR_TYPE_TO_STRING_REPLACEMENTS)


def visit_value_by_direction(
        value: Type,
        input_visitor: Callable[[Type], Any],
        output_visitor: Callable[[Type], Any]):
    if value.is_input():
        return input_visitor(value)
    if value.is_output():
        return output_visitor(value)
    if value.is_mixed():
        if isinstance(value, m_Tuple):
            for field in value.values():
                visit_value_by_direction(field, input_visitor, output_visitor)
            return
        if isinstance(value, Array):
            for item in value:
                visit_value_by_direction(item, input_visitor, output_visitor)
            return
    raise TypeError(value)


@dataclasses.dataclass(frozen=True)
class ValueWrapper:
    id: str = dataclasses.field(default_factory=make_unique_name, init=False)
    name: str
    T: Kind


def visit_value_wrapper_by_direction(
        value_wrapper: ValueWrapper,
        input_visitor: Callable[[ValueWrapper], Any],
        output_visitor: Callable[[ValueWrapper], Any]):
    T = value_wrapper.T
    if T.is_input():
        return input_visitor(value_wrapper)
    if T.is_output():
        return output_visitor(value_wrapper)
    if T.is_mixed():
        if isinstance(T, TupleMeta):
            for key, TT in T.field_dict.items():
                field = ValueWrapper(f"{value_wrapper.name}_{key}", TT)
                visit_value_wrapper_by_direction(
                    field, input_visitor, output_visitor)
            return
        if isinstance(T, ArrayMeta):
            for index in range(T.N):
                item = ValueWrapper(f"{value_wrapper.name}[{key}]", T.T)
                visit_value_wrapper_by_direction(
                    item, input_visitor, output_visitor)
            return
    raise TypeError(value)


class InstanceWrapper:
    def __init__(
            self,
            name: str,
            ports: Mapping[str, Kind],
            attrs: Mapping[str, Any]):
        self._name = name
        self._ports = {name: ValueWrapper(name, T) for name, T in ports.items()}
        self._attrs = attrs
        for name, value in self._ports.items():
            setattr(self, name, value)

    def __repr__(self) -> str:
        return f"InstanceWrapper({self.name})"

    @property
    def name(self) -> str:
        return self._name

    @property
    def ports(self) -> Mapping[str, Kind]:
        return self._ports.copy()

    @property
    def attrs(self) -> Mapping[str, Any]:
        return self._attrs.copy()


def safe_root(ref: Ref) -> Ref:
    """Returns the root ref of @ref."""
    # TODO(rsetaluri): This should be able to return `ref.root()`, but depends
    # on #990.
    parent = ref
    if isinstance(ref, ArrayRef):
        parent = ref.array.name
    elif isinstance(ref, TupleRef):
        parent = ref.tuple.name
    if parent is ref:
        return ref
    return safe_root(parent)
