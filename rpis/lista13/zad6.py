#!/usr/bin/env python3

from scipy.stats import norm

X_bar = 12
sigma = 7

for mi in [9.0, 10.0, 11.0]:
  for n in [10, 20, 40]:

    z = (X_bar - mi) / (sigma / n ** 0.5)

    p = float(round(2 * (1 - norm.cdf(z)), 3))

    print(f"{mi=} {n=}: {p=}")
