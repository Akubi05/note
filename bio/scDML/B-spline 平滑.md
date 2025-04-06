![1](/bio/scDML/pictures/3fed11b4-0751-480d-b29b-e797765e1ba3.png)
上图直观展示了 **三次 B-spline 平滑曲线** 是如何从一组带有噪声的原始数据点中提取整体趋势的：

- ⚫ 黑色圆点表示原始数据点，带有一定的随机噪声。
- 🔵 蓝色平滑曲线是通过 **三次 B 样条（degree=3）** 得到的拟合结果，它比简单连线或高次多项式拟合更自然、平滑。
- 🔵 蓝色阴影区域表示一个模拟的误差带（±0.3），在实际科研图中，它可以是 **95%置信区间** 的估计范围。

如果你正在处理时间序列、实验测量数据，或可视化聚类评价指标变化趋势，这种平滑方式特别常用。

要不要我用你的数据来演示一遍 B-spline 平滑？或者你想看看它和其他方法（比如移动平均、低阶多项式拟合）的对比图？

当然可以！以下是你刚才看到图的完整 Python 示例代码，使用了 `scipy` 的 `make_interp_spline` 来进行 **三次 B-spline 平滑**，并绘制原始数据点、平滑曲线和误差带：

---

### ✅ 示例：三次 B-spline 平滑与误差带可视化

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import make_interp_spline

# 模拟一组带噪声的数据点
np.random.seed(0)
x = np.linspace(0, 10, 15)
y = np.sin(x) + np.random.normal(scale=0.3, size=x.shape)

# 构造 B-spline 平滑曲线（degree=3）
x_smooth = np.linspace(x.min(), x.max(), 300)  # 更密的x，用于绘图
spline = make_interp_spline(x, y, k=3)         # k=3 表示三次 B 样条
y_smooth = spline(x_smooth)

# 绘制图像
plt.figure(figsize=(10, 6))
plt.plot(x, y, 'o', label='原始数据点', color='black')
plt.plot(x_smooth, y_smooth, label='三次 B-spline 平滑曲线', color='blue', linewidth=2)

# 模拟误差带 ±0.3，可根据实际置信区间计算
plt.fill_between(x_smooth, y_smooth - 0.3, y_smooth + 0.3, 
                 color='blue', alpha=0.2, label='误差带（±0.3）')

# 设置标题和标签
plt.title("三次 B-spline 平滑曲线与误差带")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
```

---

### 📦 依赖项（如未安装）：
你可能需要先安装以下库：

```bash
pip install numpy matplotlib scipy
```

---

### 📌 可选改进：
- 把 `±0.3` 替换成真实的标准误差或置信区间估计；
- 将 `make_interp_spline` 替换成更适合大型数据的 `UnivariateSpline`；
- 如果你的数据是时间序列，还可以加时间坐标轴格式。

---

需要我给你展示 **置信区间的真实计算方式** 或把它和 **移动平均/多项式拟合** 做对比也没问题，直接说一声就行。