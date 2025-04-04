```
do you wish to update your shell profile to automatically initialize conda?
This will activate conda on startup and change the command prompt when activated.
If you'd prefer that conda's base environment not be activated on startup,
   run the following command when conda is activated:

conda config --set auto_activate_base false

You can undo this by running conda init --reverse $SHELL? [yes|no]
[no] >>> 

You have chosen to not have conda modify your shell scripts at all.
To activate conda's base environment in your current shell session:

eval "$(/home/luke/anaconda3/bin/conda shell.YOUR_SHELL_NAME hook)" 

To install conda's shell functions for easier access, first activate, then:

conda init

Thank you for installing Anaconda3!
```

你在安装 Anaconda 时，它询问你是否要修改你的 shell 配置文件（如 `~/.bashrc`、`~/.zshrc`），以便自动初始化 `conda`。你选择了 **no**，所以 `conda` 不会自动加载，你需要手动执行以下操作来使用 `conda`：

---

### **1. 手动激活 `conda`**
如果你当前想要使用 `conda`，请运行：
```bash
eval "$(/home/luke/anaconda3/bin/conda shell.bash hook)"
```
> **注意**：如果你使用 `zsh`，请替换 `bash` 为 `zsh`：
```bash
eval "$(/home/luke/anaconda3/bin/conda shell.zsh hook)"
```

---

### **2. 让 `conda` 在每次启动时自动激活**
如果你希望 `conda` 在每次打开终端时都可用，可以运行：
```bash
conda init
```
这个命令会修改你的 shell 配置文件（如 `~/.bashrc` 或 `~/.zshrc`），之后重新打开终端即可自动加载 `conda`。

---

### **3. 禁用 `conda` 的自动激活**
如果 `conda` 被初始化了，但你不想它在每次启动时自动激活 `base` 环境，可以运行：
```bash
conda config --set auto_activate_base false
```
这样，`conda` 仍然可用，但不会自动进入 `base` 环境，你可以手动运行：
```bash
conda activate base
```
来激活它。

---

### **4. 还原 `conda init`**
如果你后悔执行了 `conda init`，想恢复到 `conda` 未初始化的状态，可以运行：
```bash
conda init --reverse
```
这会移除 `conda init` 对你的 shell 配置文件的修改。

---

你打算手动管理 `conda`，还是希望它自动加载？如果你只是想偶尔使用 `conda`，可以手动激活；如果你经常用，建议执行 `conda init` 来自动加载。😃