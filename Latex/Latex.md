# Latex技巧杂记
各种杂散的小技巧

## 安装字体
TeX Live on Windows：
1. Install for All Users
2. Put the font in a project directory and use the Path = command option of fontspec
3. Put the font in a subdirectory of your local TeX Live directory, normally C:\texlive\texmf-local\fonts. Re-run fc-cache -fsv and luaotfload-tool -f -u -v to update your font caches


参考：
* [My system can't find installed otf and ttf fonts](https://tex.stackexchange.com/questions/511897/my-system-cant-find-installed-otf-and-ttf-fonts)


