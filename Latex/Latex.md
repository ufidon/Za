# Latex技巧杂记
各种杂散的小技巧

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

## 五线谱简谱排版
* [LaTeX排版的中文乐谱](https://www.latexstudio.net/archives/11337.html)
* [用Lilypond排版简谱](https://www.cnblogs.com/quantumman/p/5189701.html)
* [Lilipond简谱插件](https://ssb22.user.srcf.net/mwrhome/jianpu-ly.py)
* [Musixtex写五线谱](https://blog.csdn.net/cclethe/article/details/73065473)


## 竖排古籍
* [upLatex](https://github.com/Steve-Cheung-emct)