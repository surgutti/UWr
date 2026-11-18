#!/usr/bin/env python3

'''
Robimy analizę wariancji - ANOVA
'''

import pandas as pd
import numpy as np
from scipy.stats import f

df = pd.read_csv('rpr-1304.csv', header=None, names=["value", "group"])

x = np.array([
  group["value"].to_numpy()
  for _, group in df.groupby("group")
])

# print(x)
# print(f"{x.shape=}")

# n = sum(len(g) for g in x)
I, J = x.shape

x_bar = np.mean(x)
xi_dot = np.mean(x, axis=1)

SS_Tot = np.sum((x - x_bar)**2)

SS_A = J * np.sum((xi_dot - x_bar)**2)
SS_E = np.sum([
  np.sum((xi - np.mean(xi))**2)
  for xi in x
])

# print(f"{SS_Tot=}")
# print(f"{SS_A=}")
# print(f"{SS_E=}")
# print(f"{xi_dot=}")

assert abs(SS_Tot - (SS_A + SS_E)) < 1e-9

MS_A = SS_A / (I - 1)
MS_E = SS_E / (I * J - I)

F_stat = MS_A / MS_E

p_value = 1 - f.cdf(F_stat, I - 1, I * J - I)

print(f"{p_value=}")

# p_value=np.float64(0.0016977684112495783)
# Odrzucamy Hipotezę
