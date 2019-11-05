import magma as m
import magma.testing
import os
import pytest


def check_port(definition, port, type, direction):
    assert hasattr(definition, port)
    port = getattr(definition, port)
    assert isinstance(port._value, type)
    if direction == "input":
        assert port.is_output()
    elif direction == "output":
        assert port.is_input()
    else:
        raise NotImplementedError(direction)

def check_rxmod(RXMOD):
    check_port(RXMOD, "RX", m.Bit, "input")
    check_port(RXMOD, "CLK", m.Bit, "input")
    check_port(RXMOD, "data", m.Array, "output")
    check_port(RXMOD, "valid", m.Bit, "output")

    m.compile("build/test_rxmod", RXMOD, output="verilog")
    assert m.testing.check_files_equal(__file__, "build/test_rxmod.v",
            "gold/test_rxmod.v")


def test_basic():
    file_path = os.path.dirname(__file__)
    RXMOD = m.DefineFromVerilogFile(os.path.join(file_path, "rxmod.v"))[0]

    check_rxmod(RXMOD)


def test_target_modules_arg():
    file_path = os.path.dirname(__file__)
    circuits = m.DefineFromVerilogFile(os.path.join(file_path, "rxmod.v"), ["RXMOD"])
    assert len(circuits) == 1
    assert circuits[0].name == "RXMOD"

    check_rxmod(circuits[0])


def test_coreir_compilation():
    file_path = os.path.dirname(__file__)
    RXMOD = m.DefineFromVerilogFile(os.path.join(file_path, "rxmod.v"))[0]

    top = m.DefineCircuit("top",
                          "RX", m.In(m.Bit),
                          "CLK", m.In(m.Bit),
                          "data", m.Out(m.Bits[8]),
                          "valid", m.Out(m.Bit))
    RXMOD_inst = RXMOD()
    m.wire(top.RX, RXMOD_inst.RX)
    m.wire(top.CLK, RXMOD_inst.CLK)
    m.wire(top.data, RXMOD_inst.data)
    m.wire(top.valid, RXMOD_inst.valid)
    m.EndCircuit()

    m.compile("build/test_rxmod_top", top, output="coreir")

    assert m.testing.check_files_equal(
        __file__, "build/test_rxmod_top.json", "gold/test_rxmod_top.json")


def test_decl_list():
    file_path = os.path.dirname(__file__)
    type_map = {"clk_in"    : m.In(m.Clock),
                "reset"     : m.In(m.AsyncReset),
                "config_en" : m.In(m.Enable),
                "clk_en"    : m.In(m.Enable)}
    memory_core = m.DefineFromVerilogFile(
        os.path.join(file_path, "decl_list.v"), target_modules=["memory_core"],
        type_map=type_map)[0]
    assert str(memory_core) == "memory_core(clk_in: In(Clock), clk_en: In(Enable), reset: In(AsyncReset), config_addr: In(Bits[32]), config_data: In(Bits[32]), config_read: In(Bit), config_write: In(Bit), config_en: In(Enable), config_en_sram: In(Bits[4]), config_en_linebuf: In(Bit), data_in: In(Bits[16]), data_out: Out(Bits[16]), wen_in: In(Bit), ren_in: In(Bit), valid_out: Out(Bit), chain_in: In(Bits[16]), chain_out: Out(Bits[16]), chain_wen_in: In(Bit), chain_valid_out: Out(Bit), almost_full: Out(Bit), almost_empty: Out(Bit), addr_in: In(Bits[16]), read_data: Out(Bits[32]), read_data_sram: Out(Bits[32]), read_data_linebuf: Out(Bits[32]), flush: In(Bit))"


def test_from_sv():
    file_path = os.path.dirname(__file__)
    test_pe = m.DefineFromVerilogFile(os.path.join(file_path, "test_pe.sv"), shallow=True)[0]


    if os.path.exists("build/test_pe.sv"):
       os.remove("build/test_pe.sv")
    m.compile("build/test_pe", test_pe, output="verilog")

    # Remove last line from generated file since magma adds an extra newline
    with open("tests/test_verilog/build/test_pe.sv", 'r') as f:
        lines = f.readlines()
        lines = lines[:-1]
    with open("tests/test_verilog/build/test_pe.sv", 'w') as f:
        f.write("".join(lines))

    assert m.testing.check_files_equal(__file__, "build/test_pe.sv",
                                       "test_pe.sv")


def test_from_pad_inout():
    file_path = os.path.dirname(__file__)
    Pad = m.DeclareFromVerilogFile(os.path.join(file_path, "pad.v"))[0]

    class Top(m.Circuit):
        IO = ["pad", m.InOut(m.Bit)]
        @classmethod
        def definition(io):
            pad = Pad()
            m.wire(io.pad, pad.PAD)
            for port in ["DS0", "DS1", "DS2", "I", "IE", "OEN", "PU", "PD", "ST", "SL", "RTE"]:
                m.wire(0, getattr(pad, port))


    m.compile("build/test_pad", Top, output="coreir-verilog")
    assert m.testing.check_files_equal(__file__, "build/test_pad.v",
                                       "gold/test_pad.v")


def test_verilog_dependency():
    [foo, bar] = m.DefineFromVerilog("""
module foo(input I, output O);
    assign O = I;
endmodule

module bar(input I, output O);
    foo foo_inst(I, O);
endmodule""")
    top = m.DefineCircuit("top", "I", m.In(m.Bit), "O", m.Out(m.Bit))
    bar_inst = bar()
    m.wire(top.I, bar_inst.I)
    m.wire(bar_inst.O, top.O)
    m.EndDefine()
    FILENAME = "test_verilog_dependency_top"
    m.compile(f"build/{FILENAME}", top, output="coreir")
    assert m.testing.check_files_equal(__file__, f"build/{FILENAME}.json",
                                       f"gold/{FILENAME}.json")


def test_verilog_dependency_out_of_order():
    [foo, bar] = m.DefineFromVerilog("""
module bar(input I, output O);
    foo foo_inst(I, O);
endmodule

module foo(input I, output O);
    assign O = I;
endmodule""")
    top = m.DefineCircuit("top", "I", m.In(m.Bit), "O", m.Out(m.Bit))
    bar_inst = bar()
    m.wire(top.I, bar_inst.I)
    m.wire(bar_inst.O, top.O)
    m.EndDefine()
    FILENAME = "test_verilog_dependency_top"
    m.compile(f"build/{FILENAME}", top, output="coreir")
    assert m.testing.check_files_equal(__file__, f"build/{FILENAME}.json",
                                       f"gold/{FILENAME}.json")


def test_from_verilog_external_modules():
    [foo] = m.DefineFromVerilog("""
module foo(input I, output O);
    assign O = I;
endmodule""")
    [bar] = m.DefineFromVerilog("""
module bar(input I, output O);
    foo foo_inst(I, O);
endmodule""", external_modules={"foo": foo})
    top = m.DefineCircuit("top", "I", m.In(m.Bit), "O", m.Out(m.Bit))
    bar_inst = bar()
    m.wire(top.I, bar_inst.I)
    m.wire(bar_inst.O, top.O)
    m.EndDefine()
    FILENAME = "test_verilog_dependency_top"
    m.compile(f"build/{FILENAME}", top, output="coreir")
    assert m.testing.check_files_equal(__file__, f"build/{FILENAME}.json",
                                       f"gold/{FILENAME}.json")


def test_from_verilog_external_modules_missing():
    with pytest.raises(Exception) as pytest_e:
        m.DefineFromVerilog("""
module bar(input I, output O);
    foo foo_inst(I, O);
endmodule""")
        assert False
    assert pytest_e.type is KeyError
    assert pytest_e.value.args == ("foo",)


def test_from_verilog_external_modules_duplicate():
    with pytest.raises(Exception) as pytest_e:
        [foo] = m.DefineFromVerilog("""
module foo(input I, output O);
    assign O = I;
endmodule""")
        [bar] = m.DefineFromVerilog("""
module foo(input I, output O);
    assign O = I;
endmodule

module bar(input I, output O);
    foo foo_inst(I, O);
endmodule""", external_modules={"foo": foo})
        assert False
    assert pytest_e.type is Exception
    assert pytest_e.value.args == \
        ("Modules defined in both external_modules and in parsed verilog: {'foo'}",)  # nopep8


def _test_nd_array_port(verilog):
    [top] = m.DefineFromVerilog(verilog)
    assert len(top.interface.ports) == 1
    assert "inp" in top.interface.ports

    assert top.inp.type_ is m.Out(m.Array[4, m.Array[2, m.Bits[8]]])


def test_nd_array_port_list():
    verilog = """
    module top (input [7:0] inp [3:0][1:0]);
    endmodule"""
    _test_nd_array_port(verilog)


def test_nd_array_decl():
    verilog = """
    module top (inp);
      input [7:0] inp [3:0][1:0];
    endmodule"""
    _test_nd_array_port(verilog)
