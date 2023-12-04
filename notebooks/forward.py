import numpy as np
import matplotlib.pyplot as plt
import math


def ves_forward(params, vectorABHalf):
    """VESForward: 1D DC resistivity forward modeling"""
    parameter_length = len(params)
    if parameter_length % 2 == 1:
        r = params[0: int((parameter_length + 1) / 2)]          # resistivities
        t = params[int((parameter_length + 1) / 2):]            # depths
        s = vectorABHalf                                        # half electrode spacing

        # AB-Half electrode postion
        ls = len(s)
        u = np.zeros((ls, 1))
        rho_semu = np.zeros((ls, 1))

        for j in range(ls):
            q = 13
            f = 10
            m = 4.438
            x = 0
            e = math.exp(math.log(10) / (2 * m))  # 1.2961741677274485
            h = 2 * q - 2
            u[j] = s[j] * math.exp(-f * math.log(10) / (m - x))
            l = len(r) - 1
            n = 1

            li = n + h
            a = np.zeros(li)
            for i in range(li):
                w = l
                T = r[l]
                while w > 0:
                    w = w - 1
                    aa = math.tanh(t[w] / u[j])
                    T = (T + r[w] * aa) / (1 + T * aa / r[w])
                a[i] = T
                u[j] = u[j] * e

            i = 0

            rho_a = 105 * a[i] - 262 * a[i + 2] + 416 * a[i + 4] - 746 * a[i + 6] + 1605 * a[i + 8]
            rho_a = rho_a - 4390 * a[i + 10] + 13396 * a[i + 12] - 27841 * a[i + 14]
            rho_a = rho_a + 16448 * a[i + 16] + 8183 * a[i + 18] + 2525 * a[i + 20]
            rho_a = (rho_a + 336 * a[i + 22] + 225 * a[i + 24]) / 10000
            rho_semu[j] = rho_a

        return rho_semu








