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


def gen_matrix(n, h, a, b):
    """
    generate the matrix A and the vector p of the linear system of equations Au=p
    Parameters:
    n: number of intervals
    h: step size
    a: u(0)
    b: u(1)
    """
    A = gen_A(n)
    f_ls = gen_val(n, h, a, f)
    p = gen_p(n, h, f_ls, a, b)
    return A, p


def u(x):
    """the exact solution of the differential equation"""
    return x * np.sin(3 * np.pi * x)


def f(x):
    """the right-hand side of the differential equation"""
    return 6 * np.pi * np.cos(3 * np.pi * x) - 9 * (np.pi**2) * x * np.sin(
        3 * np.pi * x
    )


def gen_val(n, h, a, y):
    """generate the values of the function y at the points x_i"""
    y = np.zeros(n - 1)
    for i in range(n - 1):
        y[i] = -u(a + (i + 1) * h) * (h**2)
    return y


def gen_error(n, h, a, b):
    """generate the error of the numerical solution"""
    A, p = gen_matrix(n, h, a, b)
    u_ls = np.linalg.solve(A, p)
    error = np.sqrt(1 / (n - 1) * np.sum((gen_val(n, h, a, u) - u_ls) ** 2))
    return error


def gen_error_ls(n_ls, h_ls, a, b):
    """generate the errors of the numerical solutions"""
    error_ls = [gen_error(n, h, a, b) for n, h in zip(n_ls, h_ls)]
    return np.array(error_ls)


def calc_alpha_ls(n_ls, h_ls, error_ls):
    """calculate the order of convergence"""
    alpha_ls = np.zeros(len(n_ls) - 1)
    for i in range(len(n_ls) - 1):
        alpha_ls[i] = np.log(error_ls[i + 1] / error_ls[i]) / np.log(h_ls[i + 1] / h_ls[i])
    return alpha_ls


if __name__ == "__main__":
    n_ls = [8, 16, 32, 64, 128, 256]
    h_ls = np.array([1 / i for i in n_ls])
    a = 0
    b = 0
    error_ls = gen_error_ls(n_ls, h_ls, a, b)

    for h, error in zip(h_ls, error_ls):
        print(f"h = {h} \t error = {error}")

    alpha_ls = calc_alpha_ls(n_ls, h_ls, error_ls)

    print(f"alpha = {alpha_ls[-1]}")
    
