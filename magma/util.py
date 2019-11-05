import magma as m


def BitOrBits(width):
    if width is None:
        return m.Bit
    if not isinstance(width, int):
        raise ValueError(f"Expected width to be None or int, got {width}")
    return m.Bits[width]


def pretty_str(t):
    if issubclass(t, m.Tuple):
        args = []
        for key, value in t.field_dict.items():
            val_str = pretty_str(value)
            indent = " " * 4
            val_str = f"\n{indent}".join(val_str.splitlines())
            args.append(f"{key} = {val_str}")
        # Pretty print by using newlines + indent
        joiner = ",\n    "
        result = joiner.join(args)
        # Insert first newline + indent and last newline
        result = "\n    " + result + "\n"
        s = f"Tuple({result})"
    elif issubclass(t, m.Bits):
        s = str(t)
    elif issubclass(t, m.Array):
        s = f"Array[{t.N}, {pretty_str(t.T)}]"
    else:
        s = str(t)
    return s


def pretty_print_type(t):
    print(pretty_str(t))
