UMAP
https://blog.csdn.net/deephub/article/details/121302082

t-SNE 
【科研干货｜t-SNE一个视频get！生信必备知识】 https://www.bilibili.com/video/BV1pPBdYAEW2/?share_source=copy_web&vd_source=9d6e13bf85154299c6c9914751e93280

【潜在空间可视化：PCA、t-SNE、UMAP】 https://www.bilibili.com/video/BV1oH4y1c7ZR/?share_source=copy_web&vd_source=9d6e13bf85154299c6c9914751e93280

![batch effcet](/bio/pictures/batch_effect.png "batch effect!")
https://www.10xgenomics.com/cn/analysis-guides/introduction-batch-effect-correction

https://blog.csdn.net/hx2024/article/details/140808272



【动画解释自编码器如是如何工作的及其应用】 https://www.bilibili.com/video/BV1kw4m1r783/?share_source=copy_web&vd_source=9d6e13bf85154299c6c9914751e93280


自编码器的局限性：
1. 当我们期望选两个点时，其中点解码之后是这两个点解码之后的中点，比如手写数字识别，在潜在空间中a代表0，b代表6，我们希望ab的中点c代表3，但实际上ab的中点是没有任何意义的
2. 抗抵抗力低，输入添加噪点，自编码器根本无法成功解码。
3. 潜在空间是无组织，不规则的

故现代自编码器会规范潜在空间。Variational Auto_Encoders

【变分自编码器可视化解释】 https://www.bilibili.com/video/BV1D54reZE2g/?share_source=copy_web&vd_source=9d6e13bf85154299c6c9914751e93280
generativa AI与traditional ai不同，它不是处理数据，而是从头创建新数据。其根源是VAE

VAE优点：
1. 潜在空间连续，故可以从一个图片无缝转换到另外一个图片

缺点：
1. 重构图像模糊，这是由于潜在空间的正则化项导致的，而不是模型架构导致的
   ![VAE1](/bio/pictures/VAE1.png)
2. 在VAE原始工作中，我们并不能真正生成特定图像。幸运的是，许多研究论文已经尝试解决这些挑战，导致高级VAE模型。cVAE允许特定变量类别的图像生成，b-VAE引入一个可调参数，来控制重构质量与解耦之间的权衡。VQVAE为更清晰的重构提供离散的潜在空间
3. 原始VAE不如GANs的图像清晰，也不如如今的diffussion

ELBO，全称是 **Evidence Lower Bound**，中文常翻译为“**证据下界**”，是**变分推断（Variational Inference）**中非常核心的概念。它主要用于近似难以计算的后验分布，广泛应用于变分自编码器（VAE）等模型中。

---

## 📌 一句话总结：

> **ELBO 是一个优化目标，它是对对数边际似然（log marginal likelihood）的下界。最大化 ELBO 就是在做近似推断和学习模型参数。**

---

## 1. 背景：为什么需要 ELBO？

我们通常想估计后验分布 \( p(z|x) \)，但这个后验分布往往是不可解析的（因为包含难算的积分）：

\[
p(z|x) = \frac{p(x,z)}{p(x)} \quad \text{其中} \quad p(x) = \int p(x,z)\,dz
\]

所以我们引入一个**可计算的近似分布** \( q(z|x) \)，来代替真实的后验。

---

## 2. 定义：ELBO 的数学表达

从 KL 散度出发，真实后验 \( p(z|x) \) 和近似后验 \( q(z|x) \) 之间的 KL 散度为：

\[
\text{KL}(q(z|x) \| p(z|x)) = \log p(x) - \mathcal{L}(x)
\]

其中：

\[
\mathcal{L}(x) = \mathbb{E}_{q(z|x)}[\log p(x,z) - \log q(z|x)]
\]

这个 \( \mathcal{L}(x) \) 就是 **ELBO**。因此我们有：

\[
\log p(x) = \text{ELBO} + \text{KL}(q(z|x) \| p(z|x))
\]

因为 KL 散度永远非负，所以：

\[
\text{ELBO} \leq \log p(x)
\]

这就是“**证据下界**”这个名字的来源。

---

## 3. 变形：ELBO 的常见写法

ELBO 也常写作：

\[
\mathcal{L}(x) = \mathbb{E}_{q(z|x)}[\log p(x|z)] - \text{KL}(q(z|x) \| p(z))
\]

这个形式更有“意义”：
- 第一项：重构误差（生成数据的能力）
- 第二项：正则项（让近似后验接近先验）

---

## 4. 在变分自编码器（VAE）中的应用

在 VAE 中，我们想最大化数据的边际似然 \(\log p(x)\)，但它难以计算，于是我们最大化 ELBO：

\[
\text{最大化 ELBO } \Rightarrow \text{同时优化编码器（q）和解码器（p）}
\]

---

## ✅ 小结

| 名称 | 含义 |
|------|------|
| ELBO | 对数边际似然的下界，用于变分推断中的优化目标 |
| 数学形式 | \(\mathbb{E}_{q(z|x)}[\log p(x|z)] - \text{KL}(q(z|x)\|p(z))\) |
| 目标 | 最大化 ELBO ≈ 同时学习模型参数与近似后验 |
| 应用 | VAE、Bayesian Neural Net、变分推断等 |

---

如果你想深入推导 ELBO 或看一个例子（比如 VAE 中的具体推导），我可以继续补充～

# 2. 【去噪自动编码器背后的基础知识】
【去噪自动编码器背后的基础知识】 https://www.bilibili.com/video/BV1hnqpYEE6r/?share_source=copy_web&vd_source=9d6e13bf85154299c6c9914751e93280 

在众多噪声建模方法中，最常用的两种是高斯噪声和柏松噪声。特别是高斯噪声，在传统图像处理和机器学习中得到了广泛的研究。

高斯噪声的好特性，加性：无论图像内容是什么，我们都可以把他均匀添加到图像中

为了训练去噪自动编码器，我们需要成对数据，包括干净图像及其相应的噪声版本，训练目标是最小化自动编码器的输出和干净图像之间的欧几里德距离

去噪自动编码器学习到的变换本质：**这是假设**上是将噪杂图像投影回流行的映射，通过这种方式，模型不仅可以消除噪音，还可以学习流形本身的结构，换句话说，它可以识别定义有意义图像的模式和特征，例如数字的形状和结构

MMSE估计器， 近似于是后验分布的平均值，它与该概率分布的得分有关

向干净图像的数据集添加高斯噪声相当于用高斯滤波器对数据分布的密度进行卷积

Tweedie公式 将后验均值与噪声数据分布的得分联系起来。
故可以验证流形假设是正确的