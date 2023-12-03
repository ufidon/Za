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

## 五线谱简谱排版
* [LaTeX排版的中文乐谱](https://www.latexstudio.net/archives/11337.html)
* [用Lilypond排版简谱](https://www.cnblogs.com/quantumman/p/5189701.html)
* [Lilipond简谱插件](https://ssb22.user.srcf.net/mwrhome/jianpu-ly.py)
* [Musixtex写五线谱](https://blog.csdn.net/cclethe/article/details/73065473)


## 竖排古籍
* [upLatex](https://github.com/Steve-Cheung-emct)

## 纯文本笔记
```bash
for f in *.md; do pandoc --pdf-engine=xelatex \
-V "geometry:margin=1in"  -V CJKmainfont="SimSun" \
-V "monofont:Noto Sans Mono CJK SC"   --toc -N  \
--highlight-style tango -V colorlinks -V urlcolor=NavyBlue \
-f markdown-raw_tex  $f -o ${f%%.md}.pdf  ; done
```

- [纯文本做笔记 --- 使用 Pandoc 把 Markdown 转为 PDF 文件](https://jdhao.github.io/2017/12/10/pandoc-markdown-with-chinese/)
  - [Pandoc User’s Guide](https://pandoc.org/MANUAL.html)
  - [Missing characters to convert the output of `tree` command using pandoc](https://tex.stackexchange.com/questions/650014/missing-characters-to-convert-the-output-of-tree-command-using-pandoc)
    - [Get list of all fonts containing a specific character](https://apple.stackexchange.com/questions/287707/get-list-of-all-fonts-containing-a-specific-character)
    - [Albatross is a command line tool for finding fonts that contain a given (Unicode) glyph](https://gitlab.com/islandoftex/albatross/)
    - [如何使用 FontTools 合并两种字体？](https://superuser.com/questions/1657357/how-do-i-merge-two-fonts-using-fonttools)
      - [将多种字体合并为一种](https://fonttools.readthedocs.io/en/latest/merge.html)
      - [如何在 XeLaTeX 中指定一系列后备字体？](https://tex.stackexchange.com/questions/323575/how-can-i-specify-a-chain-of-fallback-fonts-in-xelatex)
  - [pandoc doesn't text-wrap code blocks when converting to pdf](https://stackoverflow.com/questions/20788464/pandoc-doesnt-text-wrap-code-blocks-when-converting-to-pdf)
  - [Line breaks in the header of a Markdown table with PDF output #4890](https://github.com/jgm/pandoc/issues/4890)
  - [Pandoc - changing the layout when compiling markdown](https://tex.stackexchange.com/questions/524177/pandoc-changing-the-layout-when-compiling-markdown)
- [《简单粗暴LaTeX》开源仓库](https://github.com/wklchris/Note-by-LaTeX)