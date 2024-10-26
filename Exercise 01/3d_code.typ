```py
import numpy as np


def gen_A(n):
    """generate the matrix A of the linear system of equations Au=p"""
    n = n - 1
    A = np.zeros((n, n))
    for i in range(n):
        A[i, i] = -2
        if i > 0:
            A[i, i - 1] = 1
        if i < n - 1:
            A[i, i + 1] = 1
    return A


def gen_p(n, h, f, a, b):
    """generate the vector p of the linear system of equations Au=p"""
    p = np.zeros((n - 1, 1))
    p[0] = -(h**2) * f[0] - a
    for i in range(1, n - 2):
        p[i] = -(h**2) * f[i]
    p[n - 2] = -(h**2) * f[n - 2] - b
    return p


def gen_matrix(n, h, f, a, b):
    """
    generate the matrix A and the vector p of the linear system of equations Au=p
    Parameters:
    n: number of intervals
    h: step size
    f: list [$f_1$, $f_2$, ..., $f_{n-1}$] of the right-hand side of the equation
    a: u(0)
    b: u(1)
    """
    A = gen_A(n)
    p = gen_p(n, h, f, a, b)
    return A, p
```