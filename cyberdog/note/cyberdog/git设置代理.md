在 Git 中设置代理可以通过配置 `http.proxy` 和 `https.proxy` 来实现。以下是具体步骤：

### 1. 设置 HTTP 代理
```bash
git config --global http.proxy http://proxy.example.com:8080
```

### 2. 设置 HTTPS 代理
```bash
git config --global https.proxy https://proxy.example.com:8080
```

### 3. 设置代理的用户名和密码（如果需要）
如果代理服务器需要认证，可以在 URL 中包含用户名和密码：
```bash
git config --global http.proxy http://username:password@proxy.example.com:8080
git config --global https.proxy https://username:password@proxy.example.com:8080
```

### 4. 取消代理设置
如果需要取消代理设置，可以使用以下命令：
```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 5. 查看当前代理配置
```bash
git config --global --get http.proxy
git config --global --get https.proxy
```

### 6. 针对特定域名设置代理
如果只想对特定域名使用代理，可以这样配置：
```bash
git config --global http.https://example.com.proxy http://proxy.example.com:8080
```

### 7. 使用环境变量设置代理
你也可以通过环境变量设置代理：
```bash
export http_proxy=http://proxy.example.com:8080
export https_proxy=https://proxy.example.com:8080
```

### 注意事项
- 确保代理服务器的地址和端口正确。
- 如果代理需要认证，确保用户名和密码无误。
- 取消代理设置后，Git 将不再使用代理。
- **通过 Git 命令行参数临时设置代理
  Git 本身不支持直接通过命令行参数设置代理，但可以通过环境变量实现**

通过这些步骤，你可以轻松为 Git 配置代理。