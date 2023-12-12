# Python 技巧杂记

## 怎样 matplot 中文
* 方法一: 指定使用的字体文件
1. 查找系统安装的中文字体文件
```bash
fc-list | grep -i 'cjk'
```

```python
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
#mpl.rcParams['text.latex.unicode'] = True
mpl.rcParams['text.latex.preamble'] = '\n'.join([
    #r'\usepackage{fontspec}',
    r'\usepackage{CJK}',
    r'\AtBeginDocument{\begin{CJK}{UTF8}{gbsn}}',
    r'\AtEndDocument{\end{CJK}}'
])

x = np.arange(-np.pi, np.pi, 0.1)
y = np.sin(x)
plt.plot(x,y) 
plt.title(r"正弦曲线图",fontproperties=myfont) 
plt.ylabel(r"$ \textbf{纵轴}\; \sin(x) $",fontproperties=myfont) 
plt.xlabel(r"$ \textbf{横轴}\; x: -\pi \rightarrow \pi $",fontproperties=myfont)  
plt.show()
```

```python
import matplotlib as mpl
mpl.use("pgf")
import matplotlib.pyplot as plt

plt.rcParams.update({
    "font.family": "serif",  # use serif/main font for text elements
    "text.usetex": True,     # use inline math for ticks
    "pgf.rcfonts": False,    # don't setup fonts from rc parameters
    "pgf.preamble": "\n".join([
        r'\usepackage{fontspec}',
         r"\usepackage{url}",            # load additional packages
         r"\usepackage{unicode-math}",   # unicode math setup
         #r"\setmainfont{Courier}",  # serif font via preamble
         r'\usepackage{xeCJK}',
         r'\xeCJKsetup{CJKmath=true}',
         r'\setCJKmainfont{NotoSerifCJKsc-SemiBold}',
    ])
})

fig, ax = plt.subplots(figsize=(4.5, 2.5))

ax.plot(range(5))

ax.set_xlabel("unicode text: я, ψ, €, ü虫子")
ax.set_ylabel(r"\url{https://matplotlib.org}")
ax.legend(["unicode math: $λ=∑_i^∞ μ_i^2 云_啥^石$"])

fig.tight_layout(pad=.5)
fig.savefig('figure.pdf')
```

* 方法二: 设置 matplotlibrc 及 rcParams

```python
plt.rcParams['font.sans-serif'] = ['中文字体名'] 
plt.rcParams['axes.unicode_minus'] = False
```
* [参考1](https://medium.com/marketingdatascience/%E8%A7%A3%E6%B1%BApython-3-matplotlib%E8%88%87seaborn%E8%A6%96%E8%A6%BA%E5%8C%96%E5%A5%97%E4%BB%B6%E4%B8%AD%E6%96%87%E9%A1%AF%E7%A4%BA%E5%95%8F%E9%A1%8C-f7b3773a889b)
* [参考2](https://www.zhihu.com/question/55035983)

## ipython中的数学公式显示

1. sympy
```python
from sympy import init_printing
init_printing() # doctest: +SKIP
# 或
from sympy import init_session
init_session() # doctest: +SKIP

```
* [参考](https://docs.sympy.org/latest/tutorial/printing.html)

2. sagemath
```python
%display latex
f=x^2+3*x+1
# 或
pretty_print(f) # 或
show(f)
```
* [参考](https://github.com/nteract/nteract/issues/3364)

3. jupyter notebook/lab
```python
%pprint
```
* [参考](https://ipython.readthedocs.io/en/stable/interactive/magics.html?highlight=pprint)
