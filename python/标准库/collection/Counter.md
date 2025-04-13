当然可以！`collections.Counter` 是 Python 标准库 `collections` 中的一个非常常用的**计数器工具类**，专门用来统计**可迭代对象中每个元素出现的次数**。

---

## 🔍 基本用法

```python
from collections import Counter

# 例子1：统计列表中每个元素的出现次数
words = ['apple', 'banana', 'apple', 'orange', 'banana', 'apple']
counter = Counter(words)
print(counter)
```

### 输出：

```
Counter({'apple': 3, 'banana': 2, 'orange': 1})
```

这表示 `'apple'` 出现了 3 次，`'banana'` 出现了 2 次，`'orange'` 出现了 1 次。

---

## 🔧 常用功能一览

### ✅ 1. `.most_common(n)`
返回出现频率最高的前 n 个元素（默认所有）：

```python
counter.most_common(2)
# 输出：[('apple', 3), ('banana', 2)]
```

---

### ✅ 2. 直接像字典一样访问：

```python
print(counter['apple'])  # 输出：3
print(counter['grape'])  # 输出：0（即使没出现也不会报错）
```

---

### ✅ 3. 加减法操作（支持多个 Counter 合并、相减）：

```python
c1 = Counter({'a': 3, 'b': 1})
c2 = Counter({'a': 1, 'b': 2})
print(c1 + c2)  # Counter({'a': 4, 'b': 3})
print(c1 - c2)  # Counter({'a': 2})
```

---

## 🔁 在你刚才的例子中：

```python
n = collections.Counter(labels.values()).most_common()[-1][1]
```

这是在做什么？

- `labels.values()`：得到所有的标签（字符串）
- `Counter(...)`：统计每个标签出现的次数
- `.most_common()`：按出现频率排序
- `[-1][1]`：取出现**最少**的类别的样本数量

🚩 这段代码的目的：找出数据集中最稀有类别的样本数。

---

## ✅ 总结：`Counter` 是什么？

| 特点 | 说明 |
|------|------|
| 本质 | 是一个字典子类 |
| 功能 | 统计、排序、加减法等 |
| 使用场景 | 词频统计、标签计数、数据分析等 |

---

如果你希望我帮你结合一个项目或者任务用 `Counter` 举例，我也可以详细写一下～