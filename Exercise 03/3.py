import numpy as np
import multiprocessing as mp


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
        alpha_ls[i] = np.log(error_ls[i + 1] / error_ls[i]) / np.log(
            h_ls[i + 1] / h_ls[i]
        )
    return alpha_ls


def gen_spectral_cond_ls(n_ls, h_ls, a, b):
    """calculate the spectral condition numbers of the matrices A"""
    cond_ls = [np.linalg.cond(gen_matrix(n, h, a, b)[0]) for n, h in zip(n_ls, h_ls)]

    return np.array(cond_ls)


def method(A, B, a, omega, h, tol, max_iter, method_name):
    n = B.size + 1
    x = np.zeros(n - 1)
    D = np.diag(np.diag(A))
    L = np.tril(A, -1)
    f_ls = gen_val(n, h, a, f)

    D_inv = np.linalg.inv(D)
    D_SOR_inv = np.linalg.inv(D / omega + L)

    print(f"calculating: n: {n}, omega: {omega}, h: {h}")

    for i in range(max_iter):
        # print(i)
        if method_name == "damped_jacobi":
            x = x + omega * np.dot(D_inv, (B - np.dot(A, x)))
        elif method_name == "SOR":
            x = x + np.dot(D_SOR_inv, (B - np.dot(A, x)))

        if True in np.isnan(x):
            return x, i, omega, h, True

        norm = np.linalg.norm(np.dot(A, x) - f_ls)
        if norm < tol:
            return x, i, omega, h, False
    else:
        return x, i, omega, h, False


def gen_methods_ls(n_ls, h_ls, a, b, omega_ls, tol, max_iter, method_name):
    """generate the numerical solutions of the differential equation"""
    result_ls = []
    pool = mp.Pool(4)
    args = []
    for n, h in zip(n_ls, h_ls):
        A, B = gen_matrix(n, h, a, b)
        for omega in omega_ls:
            args.append((A, B, a, omega, h, tol, max_iter, method_name))
    result_ls = pool.starmap(method, args)
    return result_ls


if __name__ == "__main__":
    n_ls = [8, 16, 32, 64, 128, 256]
    h_ls = np.array([1 / i for i in n_ls])
    a = 0
    b = 0

    # calculate spectral condition number
    # spectral_cond_ls = gen_spectral_cond_ls(n_ls, h_ls, a, b)
    # print(f"spectral condition number: {spectral_cond_ls}")

    # implement damped Jacobi method
    omega_ls = np.array([i / 10 for i in range(1, 12)])
    result_ls = gen_methods_ls(
        n_ls, h_ls, a, b, omega_ls, np.float64(1e-10), 100000, "damped_jacobi"
    )

    for x, i, omega, h, nan in result_ls:
        print(f"omega: {omega}, h: {h}, iteration: {i}, nan: {nan}")

    # implement SOR method
    omega_ls = np.array([i / 10 for i in range(1, 21)])
    result_ls = gen_methods_ls(n_ls, h_ls, a, b, omega_ls, 1e-10, 10000, "SOR")

    for x, i, omega, h, nan in result_ls:
        print(f"omega: {omega}, h: {h}, iteration: {i}, nan: {nan}")

    # print(A, b)
