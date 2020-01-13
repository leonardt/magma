import magma as m


class TestType(m.Product):
    V1 = m.UInt[32]
    V2 = m.UInt[32]
    V3 = m.UInt[32]
    V4 = m.UInt[32]
    V5 = m.UInt[32]
    V6 = m.UInt[32]
    V7 = m.UInt[32]


@m.circuit.sequential(async_reset=False)
class TestLogic:
    def __init__(self):
        self.V1: m.UInt[32] = 0
        self.V2: m.UInt[32] = 0
        self.V3: m.UInt[32] = 0
        self.V4: m.UInt[32] = 0
        self.V5: m.UInt[32] = 0
        self.V6: m.UInt[32] = 0
        self.V7: m.UInt[32] = 0

    def __call__(self, I: TestType, SEL: m.Bit) -> TestType:
        t = m.namedtuple(
            V1=self.V1,
            V2=self.V2,
            V3=self.V3,
            V4=self.V4,
            V5=self.V5,
            V6=self.V6,
            V7=self.V7,
        )
        if SEL:
            new_t = I
        else:
            new_t = t

        self.V1 = new_t.V1
        self.V2 = new_t.V2
        self.V3 = new_t.V3
        self.V4 = new_t.V4
        self.V5 = new_t.V5
        self.V6 = new_t.V6
        self.V7 = new_t.V7
        return new_t


def test_tuple_perf():
    # for https://github.com/phanrahan/magma/issues/528#issuecomment-573510435
    m.compile("build/top", TestLogic, output="coreir-verilog")
