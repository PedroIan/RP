import numpy as np
from scipy.stats import norm
from matplotlib import pyplot as plt

loc = 0
var = 1
amostra = range(50)
domain = np.linspace(-2, -2, 1000)
# plt.plot(domain, norm.pdf(domain, 0, 0.6))
# plt.show()

x = []
y = []
for i in domain:
    x += [np.random.normal(loc, var)]
    y += [np.random.normal(loc, var)]

plt.plot(x, y, 'b') #  '( r | g | b )'  +  '( o | -- | ^ | . )'
plt.axis([-4, 4, -4, 4])
plt.show()
