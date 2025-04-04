# 日志级别（Log Level）

在日志记录中，**日志级别**（Log Level）用于表示日志消息的严重性和优先级。Python 的 `logging` 模块定义了六个标准的日志级别，从最低的 `DEBUG` 到最高的 `CRITICAL`，每个级别都用于不同的场景。它们的区别如下：

### 1. **DEBUG**
   - **用途**：用于输出最详细的信息，通常是程序开发和调试过程中用来追踪程序的行为。
   - **适用场景**：当你希望获得非常详细的运行信息，以帮助调试程序时使用。
   - **日志内容**：包含大量的诊断信息，可能包括变量的值、函数调用的顺序等。
   - **示例**：
     ```python
     logger.debug("Detailed information for debugging.")
     ```

   **特征**：日志级别最轻，不会输出给普通用户。通常会在开发或测试环境中启用。

---

### 2. **INFO**
   - **用途**：用于输出常规的程序运行信息，表示程序正常工作时的状态更新。比 `DEBUG` 更重要，通常用于记录程序的生命周期、关键流程或操作成功等信息。
   - **适用场景**：记录程序正常执行的过程，比如程序启动、任务完成、功能调用成功等。
   - **日志内容**：通常是程序运行中的里程碑或重要操作信息。
   - **示例**：
     ```python
     logger.info("Program started successfully.")
     ```

   **特征**：一般用户不会关注 `INFO` 级别的日志，通常用于开发者了解程序的运行状态。

---

### 3. **WARNING**
   - **用途**：表示程序遇到的潜在问题或不理想的状态，但不至于影响程序的运行。`WARNING` 级别的日志用于提醒开发者注意一些可能会导致问题的情况。
   - **适用场景**：程序运行过程中遇到的非致命性问题，或者程序的某些功能正在使用某些不推荐的做法。
   - **日志内容**：提示某些事情可能会影响程序的稳定性或性能，或者程序的某些功能并不符合预期。
   - **示例**：
     ```python
     logger.warning("The input file is missing some fields.")
     ```

   **特征**：不会影响程序运行，但需要开发者关注，以防将来变成问题。

---

### 4. **ERROR**
   - **用途**：表示程序在运行时发生了错误，导致某些功能不能正确执行，但程序仍然能继续运行。通常用于记录捕获到的异常。
   - **适用场景**：当程序无法完成某个操作，或者某个功能因为错误而无法正常工作时。
   - **日志内容**：包括错误信息、异常追踪（traceback）等，帮助开发者分析错误的原因。
   - **示例**：
     ```python
     logger.error("Failed to open file.")
     ```

   **特征**：表明程序有问题，可能会影响到用户体验或系统的某些功能，但程序可以继续运行。

---

### 5. **CRITICAL**
   - **用途**：表示程序遇到非常严重的问题，通常是不可恢复的错误，可能导致程序终止或整个系统崩溃。`CRITICAL` 级别的日志是最高级别，通常用于记录极其严重的错误。
   - **适用场景**：程序运行出现了致命错误，可能需要立即干预来修复问题，通常意味着程序或系统无法继续运行。
   - **日志内容**：记录会导致程序崩溃或需要紧急处理的重大问题。
   - **示例**：
     ```python
     logger.critical("System failure: unable to connect to the database.")
     ```

   **特征**：程序无法继续执行，需要紧急修复或恢复。

---

### 级别优先顺序：
从低到高的顺序（日志记录的级别递增）为：
- `DEBUG` < `INFO` < `WARNING` < `ERROR` < `CRITICAL`

### 输出级别：
日志记录器只会输出等于或高于当前级别的日志。如果日志级别设置为 `WARNING`，那么 `INFO` 和 `DEBUG` 级别的日志不会被记录。换句话说：
- 如果设置 `DEBUG`，所有级别的日志都会被记录。
- 如果设置 `INFO`，则 `INFO`、`WARNING`、`ERROR`、`CRITICAL` 会被记录。
- 如果设置 `WARNING`，则只有 `WARNING`、`ERROR`、`CRITICAL` 会被记录。
- 如果设置 `ERROR`，则只有 `ERROR` 和 `CRITICAL` 会被记录。
- 如果设置 `CRITICAL`，则只有 `CRITICAL` 会被记录。

### 选择何时使用哪个级别：
- **DEBUG**：适用于开发和调试阶段，记录所有细节。
- **INFO**：记录程序的正常行为，如启动、完成、重要流程。
- **WARNING**：当程序运行有可能导致问题时，给出警告。
- **ERROR**：当程序遇到错误时记录问题，可能需要修复。
- **CRITICAL**：当遇到严重错误或崩溃时，记录问题，通常需要紧急处理。

### 例子：

```python
import logging

# 配置日志
logging.basicConfig(level=logging.DEBUG)

# 创建 logger 实例
logger = logging.getLogger()

# 示例：不同级别的日志
logger.debug("This is a debug message")
logger.info("This is an info message")
logger.warning("This is a warning message")
logger.error("This is an error message")
logger.critical("This is a critical message")
```

输出：
```
DEBUG:root:This is a debug message
INFO:root:This is an info message
WARNING:root:This is a warning message
ERROR:root:This is an error message
CRITICAL:root:This is a critical message
```

---

### 总结：
- **DEBUG**：最详细的调试信息，开发时用，通常不会在生产环境中启用。
- **INFO**：常规信息，程序正常运行时的状态，适用于记录程序的生命周期。
- **WARNING**：警告，程序遇到潜在问题，但不影响程序继续运行。
- **ERROR**：错误，程序遇到的无法恢复的错误，通常需要修复。
- **CRITICAL**：严重错误，程序崩溃或无法继续运行，必须紧急修复。

这些级别帮助开发者根据不同的日志严重性设置适当的记录和过滤机制，以便在开发、调试和生产环境中有效地管理日志输出。

# 2. 举例

```
#!/usr/bin/env python
"""
# File Name: logger.py
# Description:

"""

import logging

def create_logger(name='', ch=True, fh='', levelname=logging.INFO):
    logger = logging.getLogger(name)
    logger.setLevel(levelname)
    
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    # handler 
    if ch:
        ch = logging.StreamHandler()
        ch.setLevel(logging.INFO)
        ch.setFormatter(formatter)
        logger.addHandler(ch)
    if fh:
        fh = logging.FileHandler(fh, mode='w')
        fh.setLevel(logging.DEBUG)
        fh.setFormatter(formatter)
        logger.addHandler(fh)
    return logger

```

这段 Python 代码定义了一个日志记录器 (`logger`) 的创建函数。日志记录器是用来记录程序运行过程中的信息、错误、警告等，这对于调试和跟踪程序的行为非常有用。

### 逐行解释：

```python
#!/usr/bin/env python
```
- 这是一个 **shebang** 行，用来指定 Python 解释器的路径，通常用于 Unix 系统中。`/usr/bin/env python` 会根据环境变量查找 Python 解释器的位置。

```python
"""
# File Name: logger.py
# Description:
"""
```
- 这是一个多行注释，用来说明该文件的文件名和描述。在这个例子中，`Description` 是空的，可能是为了后续添加注释。

```python
import logging
```
- 导入 Python 的 **logging** 模块，它提供了一个灵活的框架来记录程序运行时的日志。

```python
def create_logger(name='', ch=True, fh='', levelname=logging.INFO):
```
- 定义一个名为 `create_logger` 的函数，它用于创建一个配置好的日志记录器（logger）。
- **参数**：
  - `name`：指定日志记录器的名称，默认是空字符串（表示根记录器）。如果提供了名称，则会创建一个具名记录器。
  - `ch`：布尔值，表示是否添加一个 **StreamHandler**（控制台输出）。默认值是 `True`，表示添加。
  - `fh`：字符串，表示是否添加一个 **FileHandler**（文件输出）。如果提供了文件路径，会将日志输出到该文件。
  - `levelname`：日志的最低级别，默认是 `logging.INFO`，表示记录信息级别及以上的日志。

```python
    logger = logging.getLogger(name)
    logger.setLevel(levelname)
```
- 获取或创建一个名为 `name` 的日志记录器。
- 设置日志记录器的日志级别为 `levelname`（即传入的日志级别，默认为 `INFO`）。日志级别决定了记录哪些级别的日志：
  - `logging.DEBUG`：调试信息
  - `logging.INFO`：一般信息
  - `logging.WARNING`：警告
  - `logging.ERROR`：错误
  - `logging.CRITICAL`：严重错误

```python
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
```
- 创建一个日志格式化器（formatter），定义日志的输出格式。这里设置的格式是：
  - `%(asctime)s`：时间戳
  - `%(name)s`：日志记录器的名称
  - `%(levelname)s`：日志级别（如 INFO, DEBUG, ERROR）
  - `%(message)s`：日志消息

```python
    if ch:
        ch = logging.StreamHandler()
        ch.setLevel(logging.INFO)
        ch.setFormatter(formatter)
        logger.addHandler(ch)
```
- 如果 `ch` 为 `True`（默认值），则添加一个 **StreamHandler**（流处理器），它将日志输出到控制台。
- 设置 `StreamHandler` 的日志级别为 `INFO`，并使用之前定义的 `formatter` 格式化日志输出。
- 将该处理器添加到 `logger` 上。

```python
    if fh:
        fh = logging.FileHandler(fh, mode='w')
        fh.setLevel(logging.DEBUG)
        fh.setFormatter(formatter)
        logger.addHandler(fh)
```
- 如果 `fh` 参数传入了一个文件路径（例如日志文件的路径），则创建一个 **FileHandler**（文件处理器），将日志输出到该文件。
- 设置文件处理器的日志级别为 `DEBUG`，表示记录所有级别的日志。
- 同样，设置日志的格式化方式并将该处理器添加到 `logger` 上。

```python
    return logger
```
- 返回配置好的日志记录器 `logger`，可以在后续的代码中使用这个日志记录器来记录日志信息。

### 使用示例：

假设你有如下的文件路径 `log.txt`，你想创建一个同时将日志输出到控制台和文件的日志记录器：

```python
logger = create_logger(name='my_logger', ch=True, fh='log.txt', levelname=logging.DEBUG)

# 记录不同级别的日志
logger.debug("This is a debug message")
logger.info("This is an info message")
logger.warning("This is a warning message")
logger.error("This is an error message")
logger.critical("This is a critical message")
```

- `debug()`：记录 `DEBUG` 级别的日志。
- `info()`：记录 `INFO` 级别的日志。
- `warning()`：记录 `WARNING` 级别的日志。
- `error()`：记录 `ERROR` 级别的日志。
- `critical()`：记录 `CRITICAL` 级别的日志。

日志将会同时输出到控制台和 `log.txt` 文件中（如果设置了文件路径）。

### 总结：
这个 Python 文件定义了一个 `create_logger` 函数，用于创建一个配置好的日志记录器。日志记录器可以输出日志到控制台和文件，并且支持不同的日志级别和格式设置。这个函数非常适合用于日志记录和调试，尤其是在大规模应用程序中。