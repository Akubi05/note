# 1.

你问的这句话：

> “高维空间中相近样本在低维空间中的失真。”

可以拆开理解。这个意思是：

在**高维空间**里，一些样本点之间**本来距离很近**（也就是它们本来很相似、很接近），但是当t-SNE把这些点映射到**低维空间（通常是2维或3维可视化）**之后，**它们在低维空间中却没有保持原本的“近距离”，变得远了或者位置关系发生了偏移**，这就是所谓的“失真”。

### 为什么会失真？

t-SNE通过最小化高维和低维之间的**概率分布差异（用KL散度衡量）**来进行嵌入，但它为了增强局部结构，使用了：

- 高维空间：用**高斯分布**建模相似性；
- 低维空间：用**t分布（自由度较小，尾部更长）**建模相似性。

t分布在低维空间里会把中远距离拉得更开，从而让**局部邻近结构更紧凑**、更清晰，但**在映射的过程中不是每对点都能完美还原高维结构**，这就可能导致：

- 某些在高维空间中相近的点，**没有被很好地“投影”在一起**；
- 或者因为整体结构不受约束，被“拉扯”开了。

### 举个形象的例子：

假设你有两个细胞类型，它们在基因表达（高维）上差不多，很近，但是t-SNE映射后，其中一个细胞类型被“拉”到了一个角落去了，两个细胞簇在图上距离变远，看起来不像原来那么相近了——这就是“高维中相近样本在低维中的失真”。

### 总结这句话的意思：

尽管t-SNE对“局部结构”的保留能力很强，但它为了实现这种效果，会牺牲一些“全局一致性”，比如让一些高维空间中本来很近的样本对在低维中被放大了距离、变得不再靠近，导致结构失真。

需要更深入解释或对比UMAP之类的算法吗？

# 2. SNE分别采用高斯分布和t分布对高维与低维空间进行建模
你提到这句话：

> **t-SNE分别采用高斯分布和t分布对高维与低维空间进行建模**，

这句话是 t-SNE 核心思想的关键点，我们来详细说一说这背后的逻辑：

---

## 🧠 一、t-SNE 的基本目标
t-SNE 的目标是：  
**将高维空间中的数据点映射到低维空间中，同时尽可能保留“相对距离关系”——特别是“谁离谁近”这种局部结构。**

它的做法是：  
- 在高维空间中，定义一个“相似性”概率分布 \( P_{ij} \)：表示点 \( i \) 与点 \( j \) 是邻居的概率；
- 在低维空间中，定义另一个概率分布 \( Q_{ij} \)：表示低维中点 \( i \) 与点 \( j \) 是邻居的概率；
- 然后用 **KL散度**来衡量 \( P \) 和 \( Q \) 的差异，让它越小越好。

---

## 📐 二、为什么分别用高斯分布和 t 分布？
t-SNE 的两个空间，建模方式是不同的：

### 🔹 1. 高维空间（输入空间） —— 使用高斯分布（Gaussian）

我们计算数据点 \( x_i \) 到其他所有点 \( x_j \) 的距离，用高斯核（即正态分布）转成概率：

\[
p_{j|i} = \frac{\exp(-\|x_i - x_j\|^2 / 2\sigma_i^2)}{\sum_{k \ne i} \exp(-\|x_i - x_k\|^2 / 2\sigma_i^2)}
\]

这表示在高维空间中，\( x_j \) 是 \( x_i \) 的邻居的“相似概率”。

再对称一下得到 \( p_{ij} \)：  
\[
p_{ij} = \frac{p_{j|i} + p_{i|j}}{2n}
\]

> 为什么用高斯？因为高维空间中点之间的“局部关系”适合用高斯核表示，且高斯核局部敏感，远处的点影响会快速衰减，这有助于凸显近邻结构。

---

### 🔹 2. 低维空间（嵌入空间） —— 使用 t 分布（自由度 1）

在低维空间中，我们用学生 t 分布（自由度 1，即 Cauchy 分布）来计算相似概率：

\[
q_{ij} = \frac{(1 + \|y_i - y_j\|^2)^{-1}}{\sum_{k \ne l}(1 + \|y_k - y_l\|^2)^{-1}}
\]

> 为什么用 t 分布？因为它比高斯分布有“更长的尾巴”——也就是说，距离稍远的点也能产生较大的 \( q_{ij} \)，这有助于防止**“聚团效应”**，即所有点都被挤在一起。

---

## 🔍 三、这种分布搭配的效果

### ✅ 优点
- 使用 **高斯** 来处理高维空间中的邻近关系，确保局部结构识别得准确；
- 使用 **t 分布** 来建模低维空间，有助于把原本在高维中不相近的点“推开”，形成清晰分散的聚类结构；
- 这样就能在二维图上形成“一个个孤立的簇”，便于观察和解释。

### ⚠️ 缺点
- t 分布让远距离的吸引力变小，有利于分簇，但会牺牲“全局结构”；
- 因为只注重近邻，远处的信息被“淡化”，可能造成整体分布结构被扭曲（比如环状结构会被拉成一条链等）；
- 而且由于 t 分布有更强的 repelling 力量，有时候会把本来比较近的簇也拉得很远，导致“结构失真”。

---

## 🎯 总结一句话：
> t-SNE 通过在高维空间用高斯核建模近邻概率、在低维空间用 t 分布建模相似性，并用 KL 散度作为优化目标，从而保留局部结构、形成清晰的簇，但会牺牲部分全局关系。

---

如果你愿意，我还可以配张图来可视化一下高斯分布 vs t 分布对距离的影响，要吗？

# 3.KL散度是什么
KL 散度（Kullback–Leibler divergence，库尔贝克–莱布勒散度），是一个用来衡量两个**概率分布之间差异**的数学工具。

---

## 📘 简单解释

KL 散度不是对称的“距离”，它衡量的是：

> **如果你以概率分布 Q 来近似真实分布 P，你会“损失”多少信息？**

通俗点说：

- **P 是“真实的分布”**
- **Q 是你“假设/模拟的分布”**
- 那 KL 散度 \( D_{KL}(P \| Q) \) 表示：
  > 用 Q 来逼近 P，带来的“不准确”有多严重。

---

## 🧮 数学公式

对于离散型分布，KL散度的定义如下：

\[
D_{KL}(P \| Q) = \sum_{i} P(i) \log \frac{P(i)}{Q(i)}
\]

对于连续型分布（比如在 t-SNE 中）：

\[
D_{KL}(P \| Q) = \int P(x) \log \frac{P(x)}{Q(x)} \, dx
\]

---

## 🎯 直观理解

- 当 \( P = Q \)，KL 散度为 0，说明两个分布完全一致；
- 当 Q 偏离 P 越多，KL 散度越大，说明你用 Q 来“替代” P 的代价越高；
- KL 散度是**非对称**的，也就是说：

\[
D_{KL}(P \| Q) \ne D_{KL}(Q \| P)
\]

这一点在 t-SNE 中非常关键。

---

## 🔍 在 t-SNE 中的应用

在 t-SNE 中：

- \( P_{ij} \)：高维空间中的相似性（“真实分布”）
- \( Q_{ij} \)：低维空间中的相似性（“近似分布”）

目标就是：

\[
\min D_{KL}(P \| Q) = \sum_{i \ne j} P_{ij} \log \frac{P_{ij}}{Q_{ij}}
\]

即，让低维空间的相似性分布 \( Q \) 尽可能地“逼近”高维空间的相似性分布 \( P \)。

这就是 t-SNE 所优化的目标函数。

---

## 📎 举个形象的例子：

假设你用地图描述一个城市（比如 P 是真实地图），然后你画了一张简化版地图（Q 是你画的），KL散度就告诉你：

> 你画的地图到底**离真实的差了多少**？你是不是把远的画近了、把近的画远了？

---

## ✅ 总结一句话：

> KL 散度是衡量两个概率分布差异的指标，用于评估一个分布（Q）对另一个分布（P）的近似程度。在 t-SNE 中，它是核心的损失函数，用于保持高维数据的局部结构。

---

需要我用图像或者代码来演示 KL 散度的实际效果吗？比如画两个分布，算一下它们的 KL 散度？

# 4.为什么用t分布，有这个效果
好，我们来**详细拆解一下 t-SNE 中为什么要用 t 分布来建模低维空间的相似性**，以及这个“长尾”到底起了什么作用。

---

## 🎯 背景：t-SNE 的目的

t-SNE 要在**低维空间中**（比如二维图）尽可能地还原**高维空间中“谁和谁接近”**的结构。它的关键是：

- 让高维中相近的点，在低维中也尽量靠近（**吸引力**）；
- 避免所有点在低维中聚成一团（**排斥力**）。

而这个“相似性”的建模，就是通过概率分布（高斯 or t 分布）来定义的。

---

## 📐 高斯分布 vs t 分布

### 🔹 高斯分布（normal distribution）

- 分布集中，尾巴短（即距离远了，概率就几乎是 0）；
- 适合在高维空间中建模**局部相似性**；
- 缺点：如果在低维中也用高斯，会导致“**远的点互相吸引不够，近的点之间拉力过强**”，从而使得**所有点都被拉到一起形成“聚团”**现象。

### 🔹 t 分布（Student t-distribution，自由度 1）

- 分布比高斯“胖”很多，**尾巴很长**（也就是说，即使两个点在低维中距离很远，它们的相似性 \( q_{ij} \) 也不为 0）；
- 这让低维中的**远距离样本对**也保留一定影响力；
- **这样一来，就能有效避免“所有点都堆在一起”**的情况，也就是说能更好地区分出不同的簇。

---

## 🔍 举个非常形象的例子

### 🧠 设想：
我们有三个点：A、B、C。

- 在高维空间中，A 和 B 很接近，C 离它们都很远。
- 我们希望在低维空间中，A 和 B 要在一起，而 C 要远离它们。

### 如果我们在低维也用高斯分布：

- A 和 B 会很好地靠在一起；
- 但由于高斯尾部太短，C 和 A/B 的排斥太弱；
- 所以 C 可能也被“拉”到了 A/B 附近，**导致聚在一起**。

### 如果用 t 分布（自由度小）：

- A 和 B 还是靠在一起；
- C 即使在低维中离 A/B 很远，**也能有足够的排斥力**，不被“拉进来”；
- 这样不同的点簇可以更明显地区分开，避免混在一起。

---

## 📈 数学直觉：t 分布和排斥力

t-SNE 中的低维相似度是这样定义的：

\[
q_{ij} = \frac{(1 + \|y_i - y_j\|^2)^{-1}}{\sum_{k \ne l} (1 + \|y_k - y_l\|^2)^{-1}}
\]

- 注意这里是 \( (1 + d^2)^{-1} \)，不像高斯那样是 \( \exp(-d^2) \)；
- 对于大距离 \( d \) 来说，\( (1 + d^2)^{-1} \) 下降得慢于 \( \exp(-d^2) \)，所以仍有一定“影响力”；
- 这就是**“尾巴长”的意思**。

也就是说：  
高斯在 \( d = 3 \) 时几乎为 0，t 分布在 \( d = 3 \) 时还保持 0.1 左右——这是很大的差别。

---

## 🧠 小结一句话：

> t-SNE 用 t 分布来建模低维空间，是为了给“远距离样本对”提供足够的排斥力，防止所有点聚成一团。这是通过 t 分布比高斯“尾巴更长”来实现的，从而使不同簇之间的间距更明显，**提升可视化的效果**。

---

要不要我画一张图来对比高斯 vs t 分布在不同距离上的“相似度值”？一眼就能看出尾巴长短的差异。 