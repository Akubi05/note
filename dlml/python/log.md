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

