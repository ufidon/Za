# Python 技巧杂记

## 怎样 matplot 中文
* 方法一: 指定使用的字体文件
1. 查找系统安装的中文字体文件
```bash
fc-list | grep -i 'cjk'
```

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
matplot中文的方法:
1. 指定字体文件
2. 设定matplotlibrc及rcParams
"""


import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.font_manager as mf

# 1. 指定字体文件
# matplotlib 
myfont = mf.FontProperties(fname=r'/usr/share/fonts/opentype/noto/NotoSerifCJK-Bold.ttc')
plt.rc('text', usetex=True)
mpl.rcParams['text.usetex'] = True
mpl.rcParams['text.latex.unicode'] = True
mpl.rcParams['text.latex.preamble'] = [
    '\\usepackage{CJK}',
    r'\AtBeginDocument{\begin{CJK}{UTF8}{gbsn}}',
    r'\AtEndDocument{\end{CJK}}'
]

x = np.arange(-np.pi, np.pi, 0.1)
y = np.sin(x)
plt.plot(x,y) 
plt.title(r"正弦曲线图",fontproperties=myfont) 
plt.ylabel(r"$ \textbf{纵轴}\; \sin(x) $",fontproperties=myfont) 
plt.xlabel(r"$ \textbf{横轴}\; x: -\pi \rightarrow \pi $",fontproperties=myfont)  
plt.show()

```

* 方法二: 设置 matplotlibrc 及 rcParams

```python
plt.rcParams['font.sans-serif'] = ['中文字体名'] 
plt.rcParams['axes.unicode_minus'] = False
```
* [参考1](https://medium.com/marketingdatascience/%E8%A7%A3%E6%B1%BApython-3-matplotlib%E8%88%87seaborn%E8%A6%96%E8%A6%BA%E5%8C%96%E5%A5%97%E4%BB%B6%E4%B8%AD%E6%96%87%E9%A1%AF%E7%A4%BA%E5%95%8F%E9%A1%8C-f7b3773a889b)
* [参考2](https://www.zhihu.com/question/55035983)

