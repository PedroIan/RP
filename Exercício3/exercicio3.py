import numpy as np
import seaborn as sns
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt
from scipy.interpolate import interp1d


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

xAxesBases = []
yAxesBases = []

for i in X:
    xAxesBases += [np.linspace(min(i), max(i), 100)]
for i in Y:
    yAxesBases += [np.linspace(min(i), max(i), 100)]

mediasX = []
for i in X:
    mediasX += [media(i)]

desviosX = []
for i in X:
    desviosX += [desvioPadrao(i)]

mediasY = []
for i in Y:
    mediasY += [media(i)]

desviosY = []
for i in Y:
    desviosY += [desvioPadrao(i)]


distribuicoesX = []
for i in range(len(X)):
    temp = []
    for j in X[i]:
        temp += [pdfUnivariada(desviosX[i], mediasX[i], j)]
    distribuicoesX += [temp]

distribuicoesY = []
for i in range(len(Y)):
    temp = []
    for j in Y[i]:
        temp += [pdfUnivariada(desviosY[i], mediasY[i], j)]
    distribuicoesY += [temp]

interpolacoesX = []
interpolacoesY = []
for i in range(numClusters):
    interpolacoesX += [interp1d(X[i], distribuicoesX[i], kind=5, fill_value='extrapolate')]
    interpolacoesY += [interp1d(Y[i], distribuicoesY[i], kind=5, fill_value='extrapolate')]

fig = plt.figure()
ax = fig.gca(projection='3d')

xMesh = []
yMesh = []

for i in range(len(xAxesBases)):
    tempX, tempY = np.meshgrid(xAxesBases[i], yAxesBases[i])
    xMesh += [tempX]
    yMesh += [tempY]

print(xMesh[0])
print(interpolacoesY[0](yMesh[0]))

Z = []
for i in range(numClusters):
    Z += [interpolacoesX[i](xMesh[i]) + interpolacoesY[i](yMesh[i])]
    ax.plot_surface(xMesh[i], yMesh[i], Z[i])

plt.show()





# p = interp1d(x1, distribuicaoX1, kind=5, fill_value='extrapolate')

# for i in X:
#     p += [interp1d(i)]
# pY = interp1d(y1, distribuicaoY1, kind=5, fill_value='extrapolate')


# Z = p(xMesh) + pY(yMesh)
# ax.plot_surface(xMesh, yMesh, np.asarray(Z))
# plt.show()
# plt.plot(xAxesBase, p(xAxesBase))
# plt.show()


print(desviosX)

# plt.scatter(X[0], Y[0])
# plt.scatter(X[1], Y[1])
# plt.scatter(X[2], Y[2])
# plt.scatter(X[3], Y[3])

# plt.show()


