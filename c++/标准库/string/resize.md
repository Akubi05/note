在 C++ 中，`std::string` 类提供了一个名为 `resize` 的成员函数，用于改变字符串的大小。通过这个函数，你可以调整字符串的长度，使其变得更长或更短。这个函数在修改字符串大小时，会根据新的大小调整字符串的内容。

### `resize` 函数的语法

```cpp
void resize(size_t n);
void resize(size_t n, char c);
```

- **第一个版本：** `resize(size_t n)`：将字符串调整为 `n` 个字符的长度。
  - 如果 `n` 小于当前字符串的大小，字符串将被截断，超出的部分被删除。
  - 如果 `n` 大于当前字符串的大小，字符串会被扩展，扩展部分的字符将是默认的空字符（`'\0'`）。

- **第二个版本：** `resize(size_t n, char c)`：将字符串调整为 `n` 个字符的长度，并用字符 `c` 填充扩展的部分。
  - 如果 `n` 小于当前字符串的大小，字符串将被截断，超出的部分被删除。
  - 如果 `n` 大于当前字符串的大小，字符串会被扩展，扩展部分的字符将是 `c`。

### 使用示例

#### 1. **增加字符串的大小**

当你调用 `resize` 来增加字符串的大小时，字符串会被填充默认字符 `'\0'`（空字符），除非你指定了其他填充值。

```cpp
#include <iostream>
#include <string>

int main() {
    std::string str = "Hello";
    
    // 扩展字符串到 10 个字符，新增的部分是空字符 '\0'
    str.resize(10);
    
    std::cout << "Resized string: " << str << std::endl;  // 输出 "Hello\0\0\0\0"
    std::cout << "Size: " << str.size() << std::endl;  // 输出 10

    return 0;
}
```

**输出**：
```
Resized string: Hello
Size: 10
```

注意：`std::cout` 默认会忽略字符串中的空字符，因此输出会显示为 `"Hello"`，但实际上字符串的长度是 10，后面是被填充的空字符。

#### 2. **增加字符串的大小并填充字符**

如果你希望在扩展字符串时填充特定的字符，可以使用第二个版本的 `resize`。

```cpp
#include <iostream>
#include <string>

int main() {
    std::string str = "Hello";
    
    // 扩展字符串到 10 个字符，用字符 '*' 填充新增部分
    str.resize(10, '*');
    
    std::cout << "Resized string: " << str << std::endl;  // 输出 "Hello*****"
    std::cout << "Size: " << str.size() << std::endl;  // 输出 10

    return 0;
}
```

**输出**：
```
Resized string: Hello*****
Size: 10
```

#### 3. **缩小字符串的大小**

如果你使用 `resize` 函数将字符串的大小减小，字符串会被截断，只保留前面的字符。

```cpp
#include <iostream>
#include <string>

int main() {
    std::string str = "Hello, World!";
    
    // 缩小字符串到 5 个字符，超出的部分被截断
    str.resize(5);
    
    std::cout << "Resized string: " << str << std::endl;  // 输出 "Hello"
    std::cout << "Size: " << str.size() << std::endl;  // 输出 5

    return 0;
}
```

**输出**：
```
Resized string: Hello
Size: 5
```

### 总结

- **`resize(n)`**：将字符串的大小调整为 `n`。如果 `n` 小于当前大小，字符串会被截断；如果 `n` 大于当前大小，字符串会被扩展并用空字符填充。
- **`resize(n, c)`**：将字符串的大小调整为 `n`，如果扩展，使用字符 `c` 填充新增的部分。

### 注意事项

- `resize` 修改的是字符串的**长度**（size），但它不会影响字符串的**容量**（capacity）。如果你要调整字符串的容量，可以使用 `shrink_to_fit()`。
- 扩展字符串时，新的字符会用空字符（`'\0'`）或者你指定的字符填充。
- `resize` 函数可能会导致字符串的内容被截断，因此使用时要确保 `n` 不小于你希望保留的字符数。

这个函数在很多需要动态调整字符串大小的场景中都非常有用，比如处理用户输入、字符串格式化等。