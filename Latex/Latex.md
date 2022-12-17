# Latex技巧杂记
各种杂散的小技巧

## 找字体
fc-list -f "%{family}\n" :lang=zh
fc-list  :lang=zh

## 安装字体
TeX Live on Windows：
1. Install for All Users
2. Put the font in a project directory and use the Path = command option of fontspec
3. Put the font in a subdirectory of your local TeX Live directory, normally C:\texlive\texmf-local\fonts. Re-run fc-cache -fsv and luaotfload-tool -f -u -v to update your font caches


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
* [闹石汉字 BabelStone Han](https://www.babelstone.co.uk/Fonts/Han.html)
* [点阵体](https://github.com/tony/dot-fonts)
  * [花园体 Hanazono](http://fonts.jp/hanazono/)
* 字体工具
  * [字体炉 fontForge](https://fontforge.org/)
  * [剪图器 Clipper2 - Polygon Clipping and Offsetting Library](http://www.angusj.com/clipper2/Docs/Overview.htm)
  * [字形维基 GlyphWiki](http://zhs.glyphwiki.org/wiki/GlyphWiki)

## 五线谱简谱排版
* [LaTeX排版的中文乐谱](https://www.latexstudio.net/archives/11337.html)
* [用Lilypond排版简谱](https://www.cnblogs.com/quantumman/p/5189701.html)
* [Lilipond简谱插件](https://ssb22.user.srcf.net/mwrhome/jianpu-ly.py)
* [Musixtex写五线谱](https://blog.csdn.net/cclethe/article/details/73065473)


## 竖排古籍
* [upLatex](https://github.com/Steve-Cheung-emct)