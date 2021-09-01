from typing import Type
import control
from typing import Type
from control import TransferFunction
import numpy as np

tf = control.TransferFunction


def zpk(
    zeros: list[float], poles: list[float], gain: float = 1
) -> control.TransferFunction:
    """
    Creates a TransferFunction from zeros, poles and gain
    """
    from control import TransferFunction

    s = TransferFunction.s

    num = 1
    for z in zeros:
        num *= s - z
    den = 1
    for p in poles:
        den *= s - p
    return gain * num / den


def zeros2coeffs(zeros):
    for i in range(len(zeros)):
        pass
    pass
