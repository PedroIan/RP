import numpy as np
#import seaborn as sns
from scipy.stats import norm
from matplotlib import pyplot as plt


from sklearn.neighbors import KernelDensity

origin = 0
var = 0.6 # Variancia da Distribuicao Normal

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

plt.plot(x1, y1, 'r.', x2, y2, 'b+') #  '( r | g | b )'  +  '( o | -- | ^ | . )'
plt.axis([0, 6, 0, 6])
plt.show()

base = np.linspace(0,6,100)

kde = KernelDensity(bandwidth=0.2).fit(X1, 2)
print(len(kde.sample()[0]))
plt.plot(np.transpose(base), kde.sample())
plt.show()

#sns.distplot(x1)