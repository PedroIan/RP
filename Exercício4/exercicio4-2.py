import numpy as np
from scipy.stats import norm
from scipy.stats import kde
from matplotlib import pyplot as plt
from scipy.interpolate import interp1d
from sklearn.naive_bayes import GaussianNB
from sklearn.model_selection import train_test_split
from sklearn import metrics
from matplotlib.colors import ListedColormap

origins = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
numClusters = len(origins)
varAmostra = [0.4, 0.4, 0.4, 0.4]
cluster = [0,1,0,1]
ax = plt.subplot()

# Vetores das posicoes das amostras 1 e 2
justX = []
Y = []
allX1 = []
allX2 = []


for i in range(numClusters):
    X1 = []
    X2 = []

    for j in range(200):
        justX += [[np.random.normal(origins[i][0], varAmostra[i]), np.random.normal(origins[i][1], varAmostra[i])]]
        X1 += [np.random.normal(origins[i][0], varAmostra[i])]
        allX1 += [np.random.normal(origins[i][0], varAmostra[i])]
        X2 += [np.random.normal(origins[i][1], varAmostra[i])]
        allX2 += [np.random.normal(origins[i][1], varAmostra[i])]
        Y += [cluster[i]]

h = .02
x_min, x_max = -3, 3
y_min, y_max = -3, 3
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                        np.arange(y_min, y_max, h))

model = GaussianNB()

X_train, X_test, y_train, y_test = train_test_split(
    justX, Y, test_size=0.1, random_state=1)

model.fit(X_train, y_train)

y_pred = model.predict(X_test)

Z = model.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 1]
Z = Z.reshape(xx.shape)

cm_bright = ListedColormap(['#FF0000', '#0000FF'])

plt.contourf(xx, yy, Z, cmap=plt.cm.RdBu, alpha=.8)
plt.scatter(allX1, allX2, c='#000000', cmap=cm_bright)
plt.show()
print("Accuracy:", metrics.accuracy_score(y_test, y_pred))