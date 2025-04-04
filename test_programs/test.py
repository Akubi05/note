import numpy as np
import umap.umap_ as umap
import matplotlib.pyplot as plt
from sklearn.datasets import load_digits
 
# 加载手写数字数据集
digits = load_digits()
X = digits.data
y = digits.target
 
# 使用UMAP降维
reducer = umap.UMAP(n_neighbors=15, min_dist=0.1)
embedding = reducer.fit_transform(X)
 
# 可视化降维结果
plt.scatter(embedding[:, 0], embedding[:, 1], c=y, cmap='Spectral', s=5)
plt.colorbar(boundaries=np.arange(11)-0.5).set_ticks(np.arange(10))
plt.title('UMAP projection of the Digits dataset')
plt.show()