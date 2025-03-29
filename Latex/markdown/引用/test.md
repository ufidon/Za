---
title: "Markdown转pdf"
author: "黑白无常"
date: 2021-06-27
---


# 用Markdown写笔记
调用pandoc转成pdf。

# 标签及交叉引用参见[pandoc-crossref](https://lierdakil.github.io/pandoc-crossref/)
- $插_入^图$片, 如图 @fig:双狗：

![双狗过冬](./ss.jpg){#fig:双狗}

# 索引
本文参考了 @author2023。

# 语法上色
```python
名字 = "黑白无常"
print(f"嘿，{名字}，欢迎入红尘。")
```