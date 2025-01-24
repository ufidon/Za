# Latex技巧杂记
各种杂散的小技巧

## 找字体
```bash
fc-list -f "%{family}\n" :lang=zh
fc-list  :lang=zh
```

## 安装字体
TeX Live on Windows：
1. Install for All Users
2. Put the font in a project directory and use the Path = command option of fontspec
3. Put the font in a subdirectory of your local TeX Live directory, normally C:\texlive\texmf-local\fonts. Re-run fc-cache -fsv and luaotfload-tool -f -u -v to update your font caches

On Linux 🐧

```bash
1. 将字体文件复制至 /usr/share/fonts, /usr/local/share/fonts, 或 ~/.fonts
2. sudo fc-cache -f -v
```


参考：
* [My system can't find installed otf and ttf fonts](https://tex.stackexchange.com/questions/511897/my-system-cant-find-installed-otf-and-ttf-fonts)

## 怎样使Texlive字体系统可见

```bash
cp $TEX_HOME/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive-fonts.conf
```

* [How can I make the Ubuntu see LaTeX fonts installed through TeXLive?](https://askubuntu.com/questions/1174423/how-can-i-make-the-ubuntu-see-latex-fonts-installed-through-texlive)

## 安装微软字体
```bash
sudo apt install ttf-mscorefonts-installer
```

* [How to install Microsoft TrueType Fonts on Ubuntu-based Distributions](https://itsfoss.com/install-microsoft-fonts-ubuntu/)


## 谷歌字体集
- [看板](https://notofonts.github.io/)
- [工具](https://github.com/notofonts/nototools)
- [并集](https://github.com/notofonts/notofonts.github.io/tree/main/megamerge)


## 两套大字体
```bash
sudo apt install fonts-babelstone-han
sudo apt install fonts-hanazono
```
* [字源](https://hanziyuan.net/)
  * [中国哲学书电子化计划](https://ctext.org/zhs)
* [闹石汉字 BabelStone Han](https://www.babelstone.co.uk/Fonts/Han.html)
* [点阵体](https://github.com/tony/dot-fonts)
  * [花园体 Hanazono](http://fonts.jp/hanazono/)
* 字体工具
  * [字体炉 fontForge](https://fontforge.org/)
  * [剪图器 Clipper2 - Polygon Clipping and Offsetting Library](http://www.angusj.com/clipper2/Docs/Overview.htm)
  * [字形维基 GlyphWiki](http://zhs.glyphwiki.org/wiki/GlyphWiki)

## 更纱等距字体
- [终端更纱体](https://github.com/laishulu/Sarasa-Term-SC-Nerd)
- [更纱体](https://github.com/be5invis/Sarasa-Gothic)

## 找出含某字符的所有字体文件
```bash
albatross '🐕️'

        __ __           __
.---.-.|  |  |--.---.-.|  |_.----.-----.-----.-----.
|  _  ||  |  _  |  _  ||   _|   _|  _  |__ --|__ --|
|___._||__|_____|___._||____|__| |_____|_____|_____|

                 Unicode glyph with code points [1F415, FE0F]                  
                         mapping to [🐕️] (AND search)                          
┌─────────────────────────────────────────────────────────────────────────────┐
│ Font name                                                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│ Twemoji Mozilla                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 彩色表情包
- [示例](./coloremoji.tex)
- [咋使用彩色表情包?](https://tex.stackexchange.com/questions/497403/how-to-use-noto-color-emoji-with-lualatex)

## 合并字体档
```python
from fontTools.ttLib import TTFont
from fontTools.merge import Merger
# Open the first font
档1 = "宋.ttf"

# Open the second font
档2= "Julia.ttf"

# Merge the fonts
并 = Merger()
合体 = 并.merge([档1, 档2])

# 功能有限, 多数出错
合体.save("并档.ttf")
```
- [fonttools](https://fonttools.readthedocs.io/en/latest/index.html)

## 分解字体档
```python
from fontTools.ttLib.ttCollection import TTCollection
import os
import sys

合档 = TTCollection('Noto.tcc')
for 子号, 子体 in enumerate(合档):
    子体.save(f"Noto{i}.ttf")
```    

## 轮廓字体转点阵
```bash
# 1. -p 16指定的字体大小为16个像素
otf2bdf -p 16 input_font.otf -o output_font.bdf

# 2. BDF（Bitmap Distribution Format）点阵字体
fontforge -lang=ff -c 'Open($1); SetFontOrder(2); Generate($2)' input_font.ttf output_font.bdf

# 3. 用fontforge剧本
#----
#!/usr/bin/fontforge
import fontforge
import sys

font = fontforge.open(sys.argv[1])
sizes = [12, 14, 16, 18, 20]  # 你想要的点阵字体尺寸

for size in sizes:
    font.selection.all()
    font.autoHint()
    font.autoInstr()
    font.generate(f"{sys.argv[2]}_{size}.bdf", "", ("otb", "fnt"))
#----
fontforge -script convert_to_bitmap.pe input_font.ttf output_font
```

## 字体设计工具
- [Fontra — 基于浏览器的字体编辑器](https://fontra.xyz/)
  - [源码](https://github.com/googlefonts/fontra)
  - [绘械](https://github.com/typemytype/drawbot/)
- [fontTools - 字体工具](https://fonttools.readthedocs.io/)
  - [简介](https://github.com/arrowtype/fonttools-intro)
- [FontForge](https://fontforge.org)
  - [点控曲线戏](https://bezier.method.ac/)
- [TruFont - 真字体](https://trufont.github.io/)
- [BirdFont - 鸟字体](https://birdfont.org/)
- [Google 字体工具](https://github.com/googlefonts/gftools/)
- [fnt - 字体管理器](https://github.com/alexmyczko/fnt)
- [字体点阵转轮廓](https://github.com/fcambus/bdf2sfd)

## 字体规范
- [统一字体对象 (UFO)](https://unifiedfontobject.org/)
- [OpenType® 规范](https://learn.microsoft.com/en-us/typography/opentype/spec/)
- [OpenType 连排初谈](https://ilovetypography.com/OpenType/opentype-features.html)

## 字体研讨会
- [Typographics](https://2024.typographics.com/)
- [Navigating TTFs via FontTools](https://github.com/lynneyun/Tutorials/blob/6cabd407054431559b30d66d9b664462bb1d58b7/FontTools%20%26%20DrawBot/Navigating%20TTFs%20with%20fontTools.ipynb)
  - [操字体数据](https://github.com/aparrish/material-of-language/blob/master/manipulating-font-data.ipynb)
  - [点控线初谈](https://pomax.github.io/bezierinfo)

## 五线谱简谱排版
* [LaTeX排版的中文乐谱](https://www.latexstudio.net/archives/11337.html)
* [用Lilypond排版简谱](https://www.cnblogs.com/quantumman/p/5189701.html)
* [Lilipond简谱插件](https://ssb22.user.srcf.net/mwrhome/jianpu-ly.py)
* [Musixtex写五线谱](https://blog.csdn.net/cclethe/article/details/73065473)


## 竖排古籍
* [upLatex](https://github.com/Steve-Cheung-emct)

## 纯文本笔记 markdown 转 pdf
- 长串换行

```bash
# 1. md转pdf
pandoc doc.md -o doc.pdf --pdf-engine=xelatex --toc --highlight-style=tango -V mainfont="FreeSerif" -V fontsize=12pt --wrap=auto

# 长串换行
---
header-includes:
  - \usepackage{seqsplit}
---

Here is a long digit string:

\$1.6726219 \times 10^{-27} \approx 0.\seqsplit{000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100100001001100110101101111110101111100110000011}\_2\$


# 2. 批量转换
for f in *.md; do pandoc --pdf-engine=xelatex \
-V "geometry:margin=1in"  -V CJKmainfont="SimSun" \
-V "monofont:Noto Sans Mono CJK SC"   --toc -N  \
--highlight-style tango -V colorlinks -V urlcolor=NavyBlue \
-f markdown-raw_tex  $f -o ${f%%.md}.pdf  ; done
```

- 含彩色表情包`笔记` → pdf
  - [示例](./markdown/ce.md)


- [纯文本做笔记 --- 使用 Pandoc 把 Markdown 转为 PDF 文件](https://jdhao.github.io/2017/12/10/pandoc-markdown-with-chinese/)
  - [Pandoc User’s Guide](https://pandoc.org/MANUAL.html)
  - [pandoc doesn't text-wrap code blocks when converting to pdf](https://stackoverflow.com/questions/20788464/pandoc-doesnt-text-wrap-code-blocks-when-converting-to-pdf)
  - [Line breaks in the header of a Markdown table with PDF output #4890](https://github.com/jgm/pandoc/issues/4890)
  - [Pandoc - changing the layout when compiling markdown](https://tex.stackexchange.com/questions/524177/pandoc-changing-the-layout-when-compiling-markdown)
- [《简单粗暴LaTeX》开源仓库](https://github.com/wklchris/Note-by-LaTeX)

## 字体合并
- [Missing characters to convert the output of `tree` command using pandoc](https://tex.stackexchange.com/questions/650014/missing-characters-to-convert-the-output-of-tree-command-using-pandoc)
  - [Get list of all fonts containing a specific character](https://apple.stackexchange.com/questions/287707/get-list-of-all-fonts-containing-a-specific-character)
  - [Albatross is a command line tool for finding fonts that contain a given (Unicode) glyph](https://gitlab.com/islandoftex/albatross/)
  - [如何使用 FontTools 合并两种字体？](https://superuser.com/questions/1657357/how-do-i-merge-two-fonts-using-fonttools)
    - [将多种字体合并为一种](https://fonttools.readthedocs.io/en/latest/merge.html)
    - [如何在 XeLaTeX 中指定一系列后备字体？](https://tex.stackexchange.com/questions/323575/how-can-i-specify-a-chain-of-fallback-fonts-in-xelatex)
  - [How to Merge Two Fonts in Linux](https://linuxhint.com/merge_two_fonts_linux/)