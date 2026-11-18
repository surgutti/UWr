#!/usr/bin/env python3

from scipy.stats import norm

X_bar = 12
sigma = 7
alpha = 0.05

for n in [10, 20, 40]:
  z_alpha_half = norm.ppf(1 - alpha / 2)

  mu_left = X_bar - z_alpha_half * sigma / n ** 0.5
  mu_right = X_bar + z_alpha_half * sigma / n ** 0.5

  print(f"{n=}")
  print(f"{mu_left=} {mu_right=}")
