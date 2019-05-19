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

## 像影伸缩
* [用ffmpeg伸缩影像](https://trac.ffmpeg.org/wiki/Scaling)

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
* [VirtualBox + Secure Boot + Ubuntu = fail](https://stegard.net/2016/10/virtualbox-secure-boot-ubuntu-fail/)

1. 安装VirtualBox时不禁止安全启动
2. 创建个人RSA钥对对核心模块签字
```bash
$ sudo -i
# mkdir /root/module-signing
# cd /root/module-signing
# openssl req -new -x509 -newkey rsa:2048 -keyout mok.priv -outform DER -out mok.der -nodes -days 36500 -subj "/CN=登录名/"
[...]
# chmod 600 mok.priv
```
3. 用MOK (“Machine Owner Key”)工具把公钥导入系统以受信任，取简单临时密码即可
```bash
# mokutil --import /root/module-signing/mok.der
input password:
input password again:
```
4. 重启系统。MOK管理器EFI 工具自动运行，输入第三步的临时密码，选"Enroll MOK". 进入系统后，查看公钥导入情况
```bash
dmesg|grep 'EFI: Loaded cert'
```
5. 用系统构建文件中的签名工具及上述私钥对VirtualBox所有模块签字，建以下脚本文件方便签名
```bash
#!/bin/bash
# 文件： /root/module-signing/sign-vbox-modules
for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
  echo "Signing $modfile"
  /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 \
                                /root/module-signing/mok.priv \
                                /root/module-signing/mok.der "$modfile"
done

```
更改脚本权限：
```bash
# chmod 700 /root/module-signing/sign-vbox-modules
```
6. 每次内核升级后，都需运行上述脚本重新签名
7. 重载vboxdrv模块
```bash
# modprobe vboxdrv
```
此过程也可用于对其它第三方内核模块签名，如显卡驱动

## VirtualBox 共享库错误1
```bash
OSError: /usr/lib/x86_64-linux-gnu/VBoxOGLcrutil.so: undefined symbol: crypt_r
```
修正
```bash
sudo apt install patchelf
sudo patchelf --add-needed libcrypt.so.1 /opt/VBoxGuestAdditions-6.0.8/lib/VBoxOGLcrutil.so
```
* [参考](https://www.virtualbox.org/ticket/18324)


