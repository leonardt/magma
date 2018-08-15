"""
Example usage:
$ MAGMA_LOG_LEVEL=DEBUG MAGMA_LOG_STREAM=stdout pytest
"""
from __future__ import absolute_import
from __future__ import print_function

import logging
import traceback
import inspect
import sys
import os


streams = {
    "stdout": sys.stdout
}

stream = os.getenv("MAGMA_LOG_STREAM", "stdout")
if stream in streams:
    logging.basicConfig(stream=streams[stream])
elif stream is not None:
    logging.warning(f"Unsupported value for MAGMA_LOG_STREAM: {stream}")
log = logging.getLogger("magma")

level = os.getenv("MAGMA_LOG_LEVEL", None)
if level in ["DEBUG", "WARN", "INFO"]:
    log.setLevel(getattr(logging, level))
elif level is not None:
    logging.warning(f"Unsupported value for MAGMA_LOG_LEVEL: {stream}")


def get_original_wire_call_stack_frame():
    for frame in inspect.stack():
        if sys.version_info < (3, 5):
            function = inspect.getframeinfo(frame[0]).function
        else:
            function = frame.function
        if function not in ["wire", "connect",
                            "get_original_wire_call_stack_frame",
                            "error", "warn"]:
            break
    if sys.version_info < (3, 5):
        return frame[0]
    else:
        return frame.frame


def print_wire_traceback(fn):
    def wrapped(*args, **kwargs):
        include_wire_traceback = kwargs.get("include_wire_traceback", False)
        if include_wire_traceback:
            sys.stderr.write("="*80 + "\n")
            stack_frame = get_original_wire_call_stack_frame()
            traceback.print_stack(f=stack_frame, limit=10, file=sys.stderr)
            del kwargs["include_wire_traceback"]
        res = fn(*args, **kwargs)
        if include_wire_traceback:
            sys.stderr.write("="*80 + "\n")
        return res
    return wrapped


@print_wire_traceback
def debug(message, *args, **kwargs):
    log.debug(message, *args, **kwargs)


@print_wire_traceback
def info(message, *args, **kwargs):
    log.info(message, *args, **kwargs)


@print_wire_traceback
def warning(message, *args, **kwargs):
    log.warning(message, *args, **kwargs)


@print_wire_traceback
def error(message, *args, **kwargs):
    log.error(message, *args, **kwargs)
