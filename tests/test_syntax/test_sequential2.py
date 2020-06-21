import tempfile
import os
import inspect

import ast_tools

import magma as m
from test_sequential import Register, DualClockRAM
from magma.testing import check_files_equal


def test_sequential2_basic():
    @m.sequential2()
    class Basic:
        def __init__(self):
            self.x = Register(4)
            self.y = Register(4)

        def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
            return self.y(self.x(I))

    m.compile("build/TestSequential2Basic", Basic)
    assert check_files_equal(__file__, f"build/TestSequential2Basic.v",
                             f"gold/TestSequential2Basic.v")


def test_sequential2_assign():
    @m.sequential2()
    class Basic:
        def __init__(self):
            self.x = Register(4)
            self.y = Register(4)

        def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
            O = self.y
            self.y = self.x
            self.x = I
            return O

    m.compile("build/TestSequential2Assign", Basic)
    assert check_files_equal(__file__, f"build/TestSequential2Assign.v",
                             f"gold/TestSequential2Assign.v")

    # should be the same as basic
    assert check_files_equal(__file__, f"build/TestSequential2Assign.v",
                             f"gold/TestSequential2Basic.v")


def test_sequential2_hierarchy():
    @m.sequential2()
    class Foo:
        def __init__(self):
            self.x = Register(4)
            self.y = Register(4)

        def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
            return self.y(self.x(I))


    @m.sequential2()
    class Bar:
        def __init__(self):
            self.x = Foo()
            self.y = Foo()

        def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
            return self.y(self.x(I))

    m.compile("build/TestSequential2Hierarchy", Bar)
    assert check_files_equal(__file__, f"build/TestSequential2Hierarchy.v",
                             f"gold/TestSequential2Hierarchy.v")


def test_sequential2_pre_unroll(capsys):
    with tempfile.TemporaryDirectory() as tmpdir:
        l0 = inspect.currentframe().f_lineno + 1

        @m.sequential2(pre_passes=[ast_tools.passes.loop_unroll()],
                       post_passes=[
                           ast_tools.passes.debug(dump_source_filename=True,
                                                  dump_source_lines=True)],
                       env=locals().update(y=2),
                       debug=True, path=tmpdir, file_name="foo.py")
        class LoopUnroll:
            def __init__(self):
                self.regs = [[Register(4) for _ in range(3)] for _ in range(2)]

            def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
                O = self.regs[1][-1]
                for i in ast_tools.macros.unroll(range(y)):
                    for j in ast_tools.macros.unroll(range(2)):
                        self.regs[1 - i][2 - j] = self.regs[1 - i][1 - j]
                    self.regs[1 - i][0] = self.regs[i][-1] if m.Bit(i == 0) else I
                return O

        with open(os.path.join(tmpdir, "foo.py"), "r") as output:
            assert output.read() == """\
def __call__(self, I: m.Bits[4]) ->m.Bits[4]:
    O0 = self.regs[1][-1]
    self.regs[1 - 0][2 - 0] = self.regs[1 - 0][1 - 0]
    self.regs[1 - 0][2 - 1] = self.regs[1 - 0][1 - 1]
    self.regs[1 - 0][0] = __phi(m.Bit(0 == 0), self.regs[0][-1], I)
    self.regs[1 - 1][2 - 0] = self.regs[1 - 1][1 - 0]
    self.regs[1 - 1][2 - 1] = self.regs[1 - 1][1 - 1]
    self.regs[1 - 1][0] = __phi(m.Bit(1 == 0), self.regs[1][-1], I)
    __return_value0 = O0
    return __return_value0
"""

    assert capsys.readouterr().out == f"""\
BEGIN SOURCE_FILENAME
{os.path.abspath(__file__)}
END SOURCE_FILENAME

BEGIN SOURCE_LINES
{l0+11}:            def __call__(self, I: m.Bits[4]) -> m.Bits[4]:
{l0+12}:                O = self.regs[1][-1]
{l0+13}:                for i in ast_tools.macros.unroll(range(y)):
{l0+14}:                    for j in ast_tools.macros.unroll(range(2)):
{l0+15}:                        self.regs[1 - i][2 - j] = self.regs[1 - i][1 - j]
{l0+16}:                    self.regs[1 - i][0] = self.regs[i][-1] if m.Bit(i == 0) else I
{l0+17}:                return O
END SOURCE_LINES

"""

    m.compile("build/TestSequential2NestedLoopUnroll", LoopUnroll)
    assert check_files_equal(__file__, f"build/TestSequential2NestedLoopUnroll.v",
                             f"gold/TestSequential2NestedLoopUnroll.v")


def test_dual_clock_ram():
    @m.sequential2()
    class DefaultClock:
        def __call__(self) -> m.Bits[8]:
            rdata = DualClockRAM()(
                RADDR=m.bits(0, 8),
                WADDR=m.bits(0, 8),
                WDATA=m.bits(0, 8),
                WE=m.bit(0),
                # Default CLK will be wired up implicitly
                # RCLK=CLK
                # WCLK=CLK
            )
            return rdata

    m.compile("build/TestSequential2DefaultClock", DefaultClock)
    assert check_files_equal(__file__,
                             f"build/TestSequential2DefaultClock.v",
                             f"gold/TestSequential2DefaultClock.v")

    @m.sequential2()
    class ImplicitClock:
        def __call__(self, WCLK: m.Clock, RCLK: m.Clock) -> m.Bits[8]:
            rdata = DualClockRAM()(
                RADDR=m.bits(0, 8),
                WADDR=m.bits(0, 8),
                WDATA=m.bits(0, 8),
                WE=m.bit(0),
                # Always the first Clock argument will be wired up implicitly
                # RCLK=WCLK
                # WCLK=WCLK
            )
            return rdata

    m.compile("build/TestSequential2ImplicitClock", ImplicitClock)
    assert check_files_equal(__file__,
                             f"build/TestSequential2ImplicitClock.v",
                             f"gold/TestSequential2ImplicitClock.v")

    @m.sequential2()
    class ExplicitClock:
        def __call__(self, WCLK: m.Clock, RCLK: m.Clock) -> m.Bits[8]:
            rdata = DualClockRAM()(
                RADDR=m.bits(0, 8),
                WADDR=m.bits(0, 8),
                WDATA=m.bits(0, 8),
                WE=m.bit(0),
                # Wiring clocks explicitly
                RCLK=RCLK,
                WCLK=WCLK
            )
            return rdata

    m.compile("build/TestSequential2ExplicitClock", ExplicitClock)
    assert check_files_equal(__file__,
                             f"build/TestSequential2ExplicitClock.v",
                             f"gold/TestSequential2ExplicitClock.v")
