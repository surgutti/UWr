#!/usr/bin/env python3

'''
Testujemy hipotezę: H_0: mi_X = mi_Y
Wiadomo, że sigma_X^2 = 4, sigma_Y^2 = 9
'''

import numpy as np
import pandas as pd
from scipy.stats import norm

df = pd.read_csv('rpr-1301.csv', header=None)

x = df.iloc[:, 0].to_numpy()
y = df.iloc[:, 1].to_numpy()

x_hat = x.mean()
y_hat = y.mean()

'''
X_hat - Y_hat ~ N(0, sigma_x^2/n_x + sigma_y^2/n_y)
'''

sigma_X = 2
sigma_Y = 3

z = (x_hat - y_hat) / (sigma_X**2 / len(x) + sigma_Y**2 / len(y)) ** 0.5
Fz = norm.cdf(z)
p_value = 2 * min(Fz, 1 - Fz)

print(f"{z=}, {Fz=}, {p_value}")
