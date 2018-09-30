# Linux 技巧杂记

## 怎样下载一个网站
* [Downloading an Entire Web Site with wget](http://www.linuxjournal.com/content/downloading-entire-web-site-wget)
```bash
wget \
     --recursive \
     --no-clobber \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --domains website.org \
     --no-parent \
         www.website.org/tutorials/html/
```


## 去除已知pdf密码或者保护
* [HowTo: Linux Remove a PDF File Password Using Command Line Options](https://www.cyberciti.biz/faq/removing-password-from-pdf-on-linux/)
```bash
qpdf --password=YOURPASSWORD-HERE --decrypt input.pdf output.pdf

```
* [qpdf 用法](https://www.pdflabs.com/docs/pdftk-man-page/)

## pdf嵌入字体
```bash
gs -o 输出.pdf -sDEVICE=pdfwrite -dEmbedAllFonts=true 待嵌字体档.pdf
```

## 去除pdf内链接
```bash
pdfjam 待去链档.pdf
```

## 安装字体
* [Ubuntu字体安装](https://wiki.ubuntu.com/Fonts)
```bash
1. 将字体文件拷贝至 /usr/share/fonts, /usr/local/share/fonts, 或 ~/.fonts
2. sudo fc-cache -f -v
```

## 对多个对象做同样处理
* [Bash参考手册](http://www.gnu.org/software/bash/manual/bashref.html)
```bash
find . -iname "*.pdf" -exec convert -input {} -output {}.jpg \;
或者
for file in *.pdf; do convert -input "$file" -output "${file/%pdf/jpg}"; done

```

## Cisco Anyconnect在ubuntu 18.04上的替换方案
```bash
  # 安装openconnect，兼容anyconnect
  sudo apt-get install network-manager-openconnect-gnome
  # 测试vpn链接
  sudo openconnect 私有局域网服务器
```
重启电脑，用GUI设置私有局域网链接

## VirtualBox 驱动安装失败
* [vboxdrv.sh: failed: modprobe vboxdrv failed](https://askubuntu.com/questions/900118/vboxdrv-sh-failed-modprobe-vboxdrv-failed-please-use-dmesg-to-find-out-why)

