#!/usr/bin/env python3

import pandas as pd
import numpy as np
from scipy.stats import f

df = pd.read_csv('rpr-1305.csv')

A, B, Y = 'Sugar', 'Weight', 'Pressure'

I = df[A].nunique()
J = df[B].nunique()
K = df.groupby([A, B]).size().iloc[0]

print(f"{I=}, {J=}, {K=}")

x_bar = df[Y].mean()

A_bar = df.groupby(A)[Y].mean()
B_bar = df.groupby(B)[Y].mean()
AB_bar = df.groupby([A, B])[Y].mean()

SS_A = J * K * sum((A_bar - x_bar) ** 2) # Wplyw cukru
SS_B = I * K * sum((B_bar - x_bar) ** 2) # Wplyw wagi

SS_AB = K * sum( # interakcja
  (
    AB_bar.loc[a, b]
    - A_bar.loc[a]
    - B_bar.loc[b]
    + x_bar
  ) ** 2
  for a in A_bar.index
  for b in B_bar.index
)

SS_E = sum( # szum pomiarowy
  (
    row[Y]
    - AB_bar.loc[row[A], row[B]]
  ) ** 2
  for _, row in df.iterrows()
)

SS_Tot = sum((df[Y] - x_bar) ** 2)

assert abs(SS_Tot - (SS_A + SS_B + SS_AB + SS_E)) < 1e-9

print(A_bar)
print(B_bar)

# Używamy I wartości oraz jednej średniej
df_A = I - 1
# Uzywamy J wartości oraz jednej średniej
df_B = J - 1
df_AB = (I - 1) * (J - 1)
df_E = I * J * (K - 1)

df_Tot = I * J * K - 1

assert df_Tot == df_A + df_B + df_AB + df_E

MS_A = SS_A / df_A
MS_B = SS_B / df_B
MS_AB = SS_AB / df_AB
MS_E = SS_E / df_E

F_A = MS_A / MS_E
F_B = MS_B / MS_E
F_AB = MS_AB / MS_E

p_A = 1 - f.cdf(F_A, df_A, df_E)
p_B = 1 - f.cdf(F_B, df_B, df_E)
p_AB = 1 - f.cdf(F_AB, df_AB, df_E)

print(f"{SS_A=}")
print(f"{SS_B=}")
print(f"{SS_AB=}")
print(f"{SS_E=}")
print(f"{SS_Tot=}")

print(f"{F_A=}, {p_A=}")
print(f"{F_B=}, {p_B=}")
print(f"{F_AB=}, {p_AB=}")

alpha = 0.05

if p_A < alpha:
    print("Odrzucamy H0_A: cukier ma wpływ na ciśnienie")
else:
    print("Brak podstaw do odrzucenia H0_A")

if p_B < alpha:
    print("Odrzucamy H0_B: waga ma wpływ na ciśnienie")
else:
    print("Brak podstaw do odrzucenia H0_B")

if p_AB < alpha:
    print("Odrzucamy H0_AB: istnieje interakcja")
else:
    print("Brak podstaw do odrzucenia H0_AB")
