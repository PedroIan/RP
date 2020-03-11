import numpy as np
from scipy.stats import norm
from matplotlib import pyplot as plt

origin = 0
var = 0.6 # Variância da Distribuição Normal

# Vetores das posições das amostras 1 e 2
x1 = []
y1 = []

x2 = []
y2 = []

for i in range(100):
    x1 += [np.random.normal(origin, var) + 2]
    y1 += [np.random.normal(origin, var) + 2]
    x2 += [np.random.normal(origin, var) + 4]
    y2 += [np.random.normal(origin, var) + 4]

plt.plot(x1, y1, 'r.', x2, y2, 'b+') #  '( r | g | b )'  +  '( o | -- | ^ | . )'
plt.axis([0, 6, 0, 6])
plt.show()
