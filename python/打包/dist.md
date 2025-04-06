# 1. dist文件夹是什么

`dist/` 是 Python 项目中用于**存放打包后产物**的目录，常见于你使用 `setuptools`、`wheel`、`build` 等工具打包项目时自动生成的。

---

## 🧾 一句话解释：

> `dist/` 是 **distribution**（分发）的缩写，用来保存你准备发布到 PyPI 或供别人安装的 `.whl`、`.tar.gz` 等安装包。

---

## 🎁 它里面都放了什么？

当你在一个 Python 项目中执行：

```bash
python setup.py sdist bdist_wheel
```

或：

```bash
python -m build
```

就会在当前目录下生成一个 `dist/` 文件夹，里面一般包含：

| 文件类型 | 描述 |
|----------|------|
| `.whl`   | Wheel 安装包（推荐方式） |
| `.tar.gz` | 源代码打包文件（Source Distribution） |

示例：

```
dist/
├── myproject-0.1.0-py3-none-any.whl
└── myproject-0.1.0.tar.gz
```

---

## 🚀 举个例子：

你有一个项目：

```
myproject/
├── myproject/
│   └── __init__.py
├── setup.py
```

当你运行：

```bash
python setup.py sdist bdist_wheel
```

就会生成：

```
dist/
├── myproject-0.1.0-py3-none-any.whl
└── myproject-0.1.0.tar.gz
```

你就可以：

- 本地安装：
  ```bash
  pip install dist/myproject-0.1.0-py3-none-any.whl
  ```

- 发布到 PyPI：
  ```bash
  twine upload dist/*
  ```

---

## 💡 什么时候用到？

- ✅ 想发布自己的包到 PyPI
- ✅ 在多个项目/服务器之间分发包
- ✅ 提供可安装的版本给别人

---

## 🧹 可以删除吗？

是的，`dist/` 是**构建产物目录**，随时可以删掉重新构建：

```bash
rm -rf dist/
```

---

## ✅ 总结

| 项 | 内容 |
|----|------|
| 📁 dist/ | 存放 Python 项目打包后的安装文件 |
| 📦 内容 | `.whl`、`.tar.gz` |
| 🚀 用途 | 发布到 PyPI、本地安装、分发安装包 |
| 🗑️ 可删 | 可以删掉，不影响项目源代码 |

---

如果你想尝试自己构建一个带 `dist/` 的项目，我可以一步步带你从 `setup.py` 写起，直到生成 `.whl` 并用 pip 安装它，要不要？🚀