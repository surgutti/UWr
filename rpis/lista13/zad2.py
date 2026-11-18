#!/usr/bin/env python3

'''
Testujemy hipotezę: H_0: mi_X = mi_Y
Wiadomo, że sigma_X = sigma_Y
'''

import numpy as np
import pandas as pd
from scipy.stats import t

df = pd.read_csv('rpr-1302.csv', header=None)

x = df.iloc[:, 0].to_numpy()
y = df.iloc[:, 1].to_numpy()

n_x = len(x)
n_y = len(y)

x_hat = np.mean(x)
y_hat = np.mean(y)

S_x2 = np.var(x, ddof=0)
S_y2 = np.var(y, ddof=0)

t_ = (x_hat - y_hat) / ((n_x * S_x2 + n_y * S_y2)*(1/n_x+1/n_y))**0.5 * (n_x + n_y - 2)**0.5

Ft = t.cdf(t_, df=(n_x + n_y - 2))

p_value = 2 * min(Ft, 1 - Ft)

print(f"{t_=} {Ft=} {p_value=}")
