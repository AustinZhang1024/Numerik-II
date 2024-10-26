```py
from fractions import Fraction

import numpy as np
from matplotlib import pyplot as plt


def y(x_k, y_k, h_k):
    """Calculate $y_{k+1}$"""
    return y_k + h_k * ((Fraction(1, 1 + x_k)) ** 2 - y_k * Fraction(1, 1 + x_k))


def y_ans(x_k, y_k, h_k):
    """Calculate $y_k$ and return a list of $y_k$ values"""
    ls = [1]
    for _ in range(int(1 / h_k)):
        x_k = x_k + h_k
        y_k = y(x_k, y_k, h_k)
        ls.append(y_k)
    return y_k, ls


def y_real(x):
    """Calculate the real value of $y$"""
    return (np.log(x + 1) + 1) / (x + 1)


def main():
    x_k = Fraction(0)
    y_k = Fraction(1)
    h_1 = Fraction(1, 5)
    h_2 = Fraction(1, 10)

    y_1, ls_1 = y_ans(x_k, y_k, h_1)
    y_2, ls_2 = y_ans(x_k, y_k, h_2)

    print(np.round([float(i) for i in ls_1], 4))
    print(np.round([float(i) for i in ls_2], 4))

    print(f"h_k = {float(h_1)}: {float(y_1)}")
    print(f"h_k = {float(h_2)}: {float(y_2)}")

    plt.plot(np.linspace(0, 1, len(ls_1)), ls_1, label="h = 0.2")
    plt.plot(np.linspace(0, 1, len(ls_2)), ls_2, label="h = 0.1")
    plt.plot(np.linspace(0, 1, 1000), y_real(np.linspace(0, 1, 1000)), label="y_real")

    plt.legend()
    # plt.show()
    plt.savefig("1a.png")


if __name__ == "__main__":
    main()
```