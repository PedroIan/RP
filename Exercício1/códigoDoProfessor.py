import numpy as np
import seaborn as sns
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt

from sklearn.neighbors import KernelDensity

origin = 0
var = 0.36  # Variancia da Distribuicao Normal

# Vetores das posicoes das amostras 1 e 2
x1 = []
y1 = []
X1 = []

x2 = []
y2 = []
X2 = []

for i in range(100):
    x1 += [np.random.normal(origin, var) + 2]
    y1 += [np.random.normal(origin, var) + 2]
    X1 += [x1, y1]
    x2 += [np.random.normal(origin, var) + 4]
    y2 += [np.random.normal(origin, var) + 4]
    X2 += [x2, y2]

something = sns.kdeplot(x1)
something2 = sns.kdeplot(y1)
print(something)
plt.show()

sns.jointplot(x="something", y="something2", kind="kde")
plt.show

# nbins = 100
# k = kde.gaussian_kde([x1, y1])
# xi, yi = np.mgrid[0:6:nbins*1j, 0:6:nbins*1j]
# zi = k(np.vstack([xi.flatten(), yi.flatten()]))

# plt.contour(x1, y1, zi)

# k2 = kde.gaussian_kde([x2, y2])
# zii = k2(np.vstack([xi.flatten(), yi.flatten()]))

# plt.pcolormesh(xi, yi, zi.reshape(xi.shape))
# plt.pcolormesh(xi, yi, zii.reshape(xi.shape))
# plt.show()

# # '( r | g | b )'  +  '( o | -- | ^ | . )'
# plt.plot(x1, y1, 'r.', x2, y2, 'b+')
# plt.axis([0, 6, 0, 6])
# plt.show()

# # base = np.linspace(0, 6, 100)
# # z = kde(X1)(X1)
# # plt.plot(z)

# # kde = KernelDensity(bandwidth=0.2).fit(X1, 2)
# # print(len(kde.sample()[0]))
# # plt.plot(np.transpose(base), kde.sample())
# # plt.show()

# # sns.distplot(x1)
