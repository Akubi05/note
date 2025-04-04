# 如何查看当前python代码的工作路径

你可以使用 `os` 模块来查看当前 Python 代码的工作路径。具体方法如下：

```python
import os

# 获取当前工作路径
current_path = os.getcwd()
print("当前工作路径:", current_path)
```

`os.getcwd()` 会返回当前的工作目录路径，也就是你运行脚本的目录。

如果你想获取 Python 脚本文件本身的路径，可以使用：

```python
import os

# 获取脚本文件的路径
script_path = os.path.dirname(os.path.abspath(__file__))
print("脚本文件路径:", script_path)
```

这个方法返回的是脚本所在的完整路径，而不是工作目录。


---

这两个有什么区别

这两个方法的区别在于获取的路径类型不同：

1. **`os.getcwd()`** — 获取当前工作目录路径：
   - 该方法返回的是 **当前工作目录** 的路径。
   - 当前工作目录是指你运行 Python 脚本时所在的目录（如果你是在命令行中执行脚本，则是命令行所在的目录；如果你是在某个 IDE 中运行脚本，则是 IDE 配置的工作目录）。
   - 工作目录可以通过命令行的 `cd` 命令或代码修改（`os.chdir()`）来改变，因此它不一定是脚本所在的目录。

2. **`os.path.dirname(os.path.abspath(__file__))`** — 获取脚本文件的路径：
   - 该方法返回的是 Python 脚本本身所在的 **目录路径**。
   - 这个路径是固定的，不会随着工作目录的变化而改变。它表示的是 Python 脚本文件的实际存储位置。
   - 即使你在不同的目录下执行这个脚本，返回的路径始终是该脚本所在的目录。

### 举个例子：
假设你的脚本 `test.py` 位于 `/home/user/scripts/` 目录，而你在 `/home/user/` 目录下运行这个脚本。

- `os.getcwd()` 会返回 `/home/user/`，因为你在该目录下执行了脚本。
- `os.path.dirname(os.path.abspath(__file__))` 会返回 `/home/user/scripts/`，因为这是脚本文件 `test.py` 所在的目录。

### 总结：
- **`os.getcwd()`** 是运行时的工作目录路径，和脚本位置无关。
- **`os.path.dirname(os.path.abspath(__file__))`** 是脚本所在的目录路径，和当前工作目录无关。

---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
Cell In[4], line 4
      1 import os
      3 # 获取脚本文件的路径
----> 4 script_path = os.path.dirname(os.path.abspath(__file__))
      5 print("脚本文件路径:", script_path)

NameError: name '__file__' is not defined


在 Jupyter Notebook 中，`__file__` 并没有定义，因为 Jupyter Notebook 中并不是通过文件执行代码，而是通过交互式单元执行代码。因此，`__file__` 在这种环境下无法使用。

要解决这个问题，可以通过其他方式获取当前工作目录路径。例如，使用 `os.getcwd()` 获取当前工作路径：

```python
import os

# 获取当前工作目录路径
current_path = os.getcwd()
print("当前工作目录路径:", current_path)
```

如果你想获取脚本所在的路径，且是在 Jupyter Notebook 中运行代码，可以手动设置路径，或者通过如下方式获取当前 Notebook 的路径（如果你希望更具体的路径）：

```python
import os

# 获取当前 Notebook 所在路径（当前工作目录）
notebook_path = os.path.dirname(os.path.abspath(''))
print("Notebook所在路径:", notebook_path)
```

对于读取文件时遇到的 `FileNotFoundError`，错误提示 `No such file or directory` 表示文件路径不正确，或者文件确实不存在。你可以检查路径 `/tutorial_data/Muraro_raw.h5ad` 是否存在，确保文件的路径和文件名正确。