import numpy as np
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt
from scipy.interpolate import interp1d

origins = [[2, 2], [4, 4]]
numClusters = len(origins)
varAmostra = [0.8, 0.4]

# Vetores das posicoes das amostras 1 e 2
X = []
Y = []

for i in range(numClusters):
    tempX = []
    tempY = []
    for j in range(200):
        tempX += [np.random.normal(origins[i][0], varAmostra[i])]
        tempY += [np.random.normal(origins[i][1], varAmostra[i])]
    X += [tempX]
    Y += [tempY]

xAxesBases = []
yAxesBases = []

for i in range(numClusters):
    plt.scatter(X[i], Y[i])

plt.show()