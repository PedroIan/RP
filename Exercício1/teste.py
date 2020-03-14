# # libraries
# import matplotlib.pyplot as plt
# import numpy as np
# from scipy.stats import kde

# # create data
# x = np.random.normal(size=500)
# y = x * 3 + np.random.normal(size=500)

# # Evaluate a gaussian kde on a regular grid of nbins x nbins over data extents
# nbins = 300
# k = kde.gaussian_kde([x, y])
# xi, yi = np.mgrid[x.min():x.max():nbins*1j, y.min():y.max():nbins*1j]
# zi = k(np.vstack([xi.flatten(), yi.flatten()]))

# plt.scatter(x, y)
# plt.show()

# # Make the plot
# plt.pcolormesh(xi, yi, zi.reshape(xi.shape))
# plt.show()

# # Change color palette
# # plt.pcolormesh(xi, yi, zi.reshape(xi.shape), cmap=plt.cm.Greens_r)
# # plt.show()


 
# # library & dataset
# import seaborn as sns
# from matplotlib import pyplot as plt
# df = sns.load_dataset('iris')
 
# # Basic 2D density plot
# sns.set_style("white")
# sns.kdeplot(df.sepal_width, df.sepal_length)
# plt.show()
 
# # Custom it with the same argument as 1D density plot
# sns.kdeplot(df.sepal_width, df.sepal_length, cmap="Reds", shade=True, bw=.15)
 
# # Some features are characteristic of 2D: color palette and wether or not color the lowest range
# sns.kdeplot(df.sepal_width, df.sepal_length, cmap="Blues", shade=True, shade_lowest=True, )
# plt.show()

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np


fig = plt.figure()
ax = fig.gca(projection='3d')

# Make data.
X = np.arange(-5, 5, 0.25)
Y = np.arange(-5, 5, 0.25)
X, Y = np.meshgrid(X, Y)
R = np.sqrt(X**2 + Y**2)
Z = np.sin(R)
print(Z)

# Plot the surface.
surf = ax.plot_surface(X, Y, Z,
                       linewidth=0, antialiased=False)

# Customize the z axis.
ax.set_zlim(-1.01, 1.01)
ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

# Add a color bar which maps values to colors.
fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()
