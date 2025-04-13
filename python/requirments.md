列出所有软件安装包 pip list  or  pip freeze
从requirements.txt文件安装所有依赖项 : pip install -r requirements.txt
验证安装的软件包是否具有兼容的依赖关系 pip check
所有软件包升级 pip install -r requirements.txt --upgrade

生成一个requirements.txt文件,然后把所有的==换成>=即可,然后安装所有的库