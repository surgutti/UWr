from pathlib import Path
from math import erf, sqrt, gamma, pi


def plik(nazwa):
    p = Path(nazwa)
    if p.exists():
        return p
    for q in Path(".").rglob(nazwa):
        return q
    raise FileNotFoundError(nazwa)


def wczytaj_float(nazwa):
    return [float(w.strip().replace(",", ".")) for w in plik(nazwa).read_text().splitlines() if w.strip()]


def srednia(x):
    return sum(x) / len(x)


def wariancja_s2(x):
    m = srednia(x)
    return sum((a - m) ** 2 for a in x) / (len(x))

def phi(z):
    return 0.5 * (1 + erf(z / sqrt(2)))


def gestosc_t(u, k):
    return gamma((k + 1) / 2) / (sqrt(k * pi) * gamma(k / 2)) * (1 + u * u / k) ** (-(k + 1) / 2)


def simpson(f, a, b, n):
    if n % 2:
        n += 1
    h = (b - a) / n
    s = f(a) + f(b)
    for i in range(1, n):
        s += (4 if i % 2 else 2) * f(a + i * h)
    return s * h / 3


def student_cdf(t, k):
    if t == 0:
        return 0.5
    znak = 1 if t > 0 else -1
    pole = simpson(lambda u: gestosc_t(u, k), 0, abs(t), 20000)
    return 0.5 + znak * pole


def fmt(x):
    return f"{x:.10f}".rstrip("0").rstrip(".")


x0901 = wczytaj_float("z0901.csv")
x0905 = wczytaj_float("z0905.csv")
x0909 = wczytaj_float("z0909.csv")

n = len(x0901)
xbar = srednia(x0901)
s2 = wariancja_s2(x0901)
s = sqrt(s2)

print("1")
"""
Wyliczamy jeden stopień swobody,
więc dzielimy przez $n-1$, a nie $n$.
"""
print("Xbar =", fmt(xbar))
print("S2 =", fmt(s2))
print()

print("2")
for mu0 in [1.5, 1.75]:
    z = (xbar - mu0) / (sqrt(8) / sqrt(n))
    print("mu0 =", fmt(mu0), "z =", fmt(z), "Phi(z) =", fmt(phi(z)))
print()

"""
print("3")
k = n - 1
for mu0 in [1.5, 1.75]:
    t = (xbar - mu0) / (s / sqrt(n))
    print("mu0 =", fmt(mu0), "k =", k, "t =", fmt(t), "F_t(t) =", fmt(student_cdf(t, k)))
print()
"""

print("4")
"""
P(X=x) = e^{-\lambda} \lambda^x / x!
L(\lambda) = PI P(X=x)
L(\lambda) ~ e^{-n\lambda} \lambda^sum(x)
logarytmujemy
l(\lambda) = -n\lambda + (sum(x))ln(\lambda)
l'(\lambda) = -n + (sum(x))/(\lambda)
-n + (sum(x)) / lambda = 0
\hat(lambda) = sum(x) / n = \hat(X)
"""
print("lambda_hat = sum(x_i) / n = Xbar")
print()

print("5")
print("lambda_hat =", fmt(srednia(x0905)))
print()

print("6a")
"""
Jeżeli thete znamy, to wszystkie obserwacje musza lezec z przediale:
theta - d/2 <= x_i <= theta + d/2
czyli |x_i - theta| <= d/2
czyli d >= 2|x_i - theta|,
\hat(d) = 2 max|x_i - theta|
"""
print("d_hat = 2 * max_i |x_i - theta|")
print()

print("6b")
"""
Tutah gestosc wynosi 1/d
wiec n obsercacji daje
L(d, theta) = 1/d^n co maksymalizuje sie
dla jak najwiekszego d. Najmniejsze d to takie
ktore zawiera wszystkie obsercaje,czyli
\hat{d} = (max x[i] - min x[i]) / 2
theta = (max_x[i] + min x[i]) / 2
"""
print("d_hat = max_i x_i - min_i x_i")
print("theta_hat = (max_i x_i + min_i x_i) / 2")
print()

print("7")
"""
Niezalezne zmienne losowe X_1, ..., X_n
maja rozklad N(mi, sigma^2). Wyznaczyc E(S^2), V(S^2).

nS^2 / sigma^2 ~ chi^2(n-1)

E(chi^2(n-1)) = n-1
V(chi^2(n-1)) = 2*(n-1)

E(S^2) = (n-1)*sigma^2/n
V(S^2) = 2*(n-1)*sigma^4/n^2
"""
print("E(S^2) = sigma^2")
print("V(S^2) = 2 * sigma^4 / (n - 1)")
print()

print("10")
"""
D = X_{n+1} - \hat{X}
Ponieważ, X_{n+1}, jest niezależne od
X_1, ... X_n, to jest też niezależne od \hat{X}
Różnica rozkładów normalnych też jest rozkłądem
normalnym.

X ~ N(mi, sigma^2)
Wiec E(D) = E(X_{n+1}) - E(\hat{X}) = mi - mi = 0
A    V(D) = V(X_{n+1}) + V(\hat{X}) = sigma^2 + sigma^2/n
"""
print("D ~ N(0, sigma^2 * (1 + 1/n))")
