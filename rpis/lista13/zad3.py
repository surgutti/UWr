#!/usr/bin/env python3

'''
Obliczyć przediały ufności dla mu_X, mu_Y (alpha = 0.05)
Wiadomo, że sigma_X^2 = 4, sigma_Y^2 = 9
'''

alpha = 0.05

import pandas as pd
import numpy as np
from scipy.stats import norm

df = pd.read_csv('rpr-1301.csv', header=None)

x = df.iloc[:, 0].to_numpy()
y = df.iloc[:, 1].to_numpy()

# print(len(x), len(y))
# print(f"{x=}")
# print(f"{y=}")

nx = len(x)
ny = len(y)

sigma_x = 2
sigma_y = 3

x_bar = np.mean(x)
y_bar = np.mean(y)

z = norm.ppf(1 - alpha/2)

left_x = x_bar - z * sigma_x / np.sqrt(nx)
right_x = x_bar + z * sigma_x / np.sqrt(nx)

left_y = y_bar - z * sigma_y / np.sqrt(ny)
right_y = y_bar + z * sigma_y / np.sqrt(ny)

print(f"{left_x=} {right_x=}")
print(f"{left_y=} {right_y=}")


'''
Z = (X_bar - mu_X) / (sigma_X / sqrt(n_x)) ~ N(0, 1)

Z musi być w centralnych słupku z sumarycznym prawdopodobienstwem 1 - alpha.
P(-z_{1-alpha/2} <= Z <= +z_{1-alpha/2}) = 1 - alpha

X_bar - z_{1-alpha/2} * (sigma_X / sqrt(n_x)) <= mu_X
'''
