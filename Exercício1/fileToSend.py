import numpy as np
import seaborn as sns
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt

origin = 0
var = 0.36  # Variancia da Distribuicao Normal
var2 = 0.6

# Vetores das posicoes das amostras 1 e 2
x1 = []
y1 = []
X1 = []

x2 = []
y2 = []
X2 = []

for i in range(100):
    x1 += [np.random.normal(origin, var2) + 2]
    y1 += [np.random.normal(origin, var2) + 2]
    x2 += [np.random.normal(origin, var) + 4]
    y2 += [np.random.normal(origin, var) + 4]

something = sns.kdeplot(x1, y1)
something2 = sns.kdeplot(x2, y2)
plt.show()