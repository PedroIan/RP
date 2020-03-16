import numpy as np
import seaborn as sns
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt


def pdfUnivariada(sigma, media, inputX):
    expoente = - np.square(inputX - media)/(2 * np.square(sigma))
    return np.e ** expoente / (sigma * (np.sqrt(2 * np.pi)))


def calculoVerossimilhanca(sigma1, sigma2, media1, media2, inputX, inputY, coeficienteCorrelacao=0):
    expoente = -(np.square((inputX - media1)/sigma1) + np.square((inputY - media2)/sigma2) - 2*coeficienteCorrelacao *
                 ((inputX - media1)/sigma1)*((inputY - media2)/sigma2))/(2*(1 - np.square(coeficienteCorrelacao)))
    return (np.e**expoente)/(2*np.pi*sigma1*sigma2*np.sqrt(1 - np.square(coeficienteCorrelacao)))


def media(input):
    return sum(input)/len(input)


def desvioPadrao(input):
    med = media(input)
    somatorio = 0
    for i in input:
        somatorio += np.square(i - med)
    return np.sqrt(somatorio/len(input))


origins = [[2, 2], [4, 4], [2, 4], [4, 2]]
numClusters = len(origins)
varAmostra = [0.6, 0.8, 0.2, 1]

# Vetores das posicoes das amostras 1 e 2
X = []
Y = []

for i in range(numClusters):
    tempX = []
    tempY = []
    for j in range(100):
        tempX += [np.random.normal(origins[i][0], varAmostra[i])]
        tempY += [np.random.normal(origins[i][1], varAmostra[i])]
    X += [tempX]
    Y += [tempY]

print(X)

# plt.scatter(X[0], Y[0])
# plt.scatter(X[1], Y[1])
# plt.scatter(X[2], Y[2])
# plt.scatter(X[3], Y[3])

# plt.show()


