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

## 更新pdf书签

两个书签示例:

BookmarkBegin
BookmarkTitle: PDF Reference (Version 1.5)
BookmarkLevel: 1
BookmarkPageNumber: 1
BookmarkBegin
BookmarkTitle: Contents
BookmarkLevel: 2
BookmarkPageNumber: 3

```bash
# 1. 导出书签:
pdftk doc.pdf dump_data output doc_data.txt

# 2. 导入书签:
pdftk doc.pdf update_info doc_data.txt output updated.pdf
```
* [How to Export and Import PDF Bookmarks](https://www.pdflabs.com/blog/export-and-import-pdf-bookmarks/)
* [How to Create Photo Albums for Nook or Kindle](https://www.pdflabs.com/blog/enjoy-photos-on-nook-or-kindle-using-pdf-albums/)


## pdf转html
```bash
# 1. 极简
pdf2htmlEX --zoom 1.3 pdf/test.pdf
# 2. 高级
pdf2htmlEX -f 3 -l 5 --fit-width 1024 --bg-format jpg pdf/test.pdf
# 3. 简单出版
pdf2htmlEX --embed cfijo --dest-dir out pdf/test.pdf
# 4. 高级出版
pdf2htmlEX --embed cfijo --split-pages 1 --dest-dir out --page-filename test-%d.page pdf/test.pdf
# 5. 最后一手
pdf2htmlEX --fallback 1 pdf/test.pdf
```
* [pdf2htmlEX quick start](https://github.com/pdf2htmlEX/pdf2htmlEX/wiki/Quick-Start)
* [pdf2htmlEX](https://github.com/pdf2htmlEX/pdf2htmlEX)

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

```bash
# 1. 更改视频分辨率至320x240
ffmpeg -i input.avi -vf scale=320:240 output.avi

# 2. 更改图片分辨率至320x240
ffmpeg -i input.jpg -vf scale=320:240 output_320x240.png

# 3. 更改长至320， 高度自调
ffmpeg -i input.jpg -vf scale=320:-1 output_320.png

# 4. 采用入者属性变量(iw-入者宽， ih-入者高)
ffmpeg -i input.jpg -vf scale=iw*2:ih input_double_width.png
ffmpeg -i input.jpg -vf "scale=iw*.5:ih*.5" input_half_size.png
ffmpeg -i input.jpg -vf "scale=iw/2:ih/2" input_half_size.png

# 5. 强制变形
ffmpeg -i input.jpg -vf scale=w=320:h=240:force_original_aspect_ratio=decrease output_320.png

ffmpeg -i input.jpg -vf "scale=320:240:force_original_aspect_ratio=decrease,pad=320:240:(ow-iw)/2:(oh-ih)/2" output_320_padding.png

# 6. 指定变形算法
ffmpeg -i test.tif -vf scale=504:376 -sws_flags bilinear out.bmp

````

## 对多个对象做同样处理
* [Bash参考手册](http://www.gnu.org/software/bash/manual/bashref.html)
```bash
find . -iname "*.pdf" -exec convert -input {} -output {}.jpg \;
或者
for file in *.pdf; do convert -input "$file" -output "${file/%pdf/jpg}"; done

```
## 视频切分
```bash
# 1. 准确切分, -ss 起时，开始时间 -t 时长 -to 至时，截至时间
ffmpeg -i source.mp4 -ss 0:14:42.000 -codec copy -t 0:00:02.000 -y output.mp4

# 2. 复制切分
# 两步切一为二 
time ffmpeg -v quiet -y -i input.ts -vcodec copy -acodec copy -ss 00:00:00 -t 00:30:00 -sn test1.mkv
time ffmpeg -v quiet -y -i input.ts -vcodec copy -acodec copy -ss 00:30:00 -t 01:00:00 -sn test2.mkv

# 单步切一为二 
time ffmpeg -v quiet -y -i input.ts -vcodec copy -acodec copy -ss 00:00:00 -t 00:30:00   -sn test3.mkv -vcodec copy -acodec copy -ss 00:30:00 -t 01:00:00 -sn test4.mkv
# 割取
ffmpeg -ss 00:00:00 -t 00:50:00 -i largefile.mp4 -acodec copy 
-vcodec copy smallfile.mp4
# 切一为二
ffmpeg -i largefile.mp4 -t 00:50:00 -c copy smallfile1.mp4 -ss 00:50:00 -c copy smallfile2.mp4

# 切分后合并
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex "\
[0:v]trim=0:10,setpts=PTS-STARTPTS[v0]; \
[1:v]trim=0:5,setpts=PTS-STARTPTS[v1]; \
[0:v]trim=15:30,setpts=PTS-STARTPTS[v2]; \
[v0][v1][v2]concat=n=3:v=1:a=0[out]" \
-map "[out]" output.mp4

## 去除部分视频
# 1. Create segments:

ffmpeg  -t 00:11:00 -i input.mp4 -map 0 -c copy segment1.mp4
ffmpeg -ss 00:11:10 -i input.mp4 -map 0 -c copy segment2.mp4

# 2. Create input.txt:

file 'segment1.mp4'
file 'segment2.mp4'

# 3. Concatenate with the concat demuxer:

ffmpeg -f concat -i input.txt -map 0 -c copy output.mp4

```

* [FFMPEG Splitting MP4 with Same Quality](https://superuser.com/questions/140899/ffmpeg-splitting-mp4-with-same-quality)
* [FFmpeg: How to split video efficiently?](https://stackoverflow.com/questions/5651654/ffmpeg-how-to-split-video-efficiently)
* [ffmpeg not creating exact duration clip](https://video.stackexchange.com/questions/23373/ffmpeg-not-creating-exact-duration-clip)
[FFmpeg split video and merge back](https://superuser.com/questions/1229945/ffmpeg-split-video-and-merge-back)
* [How to remove a few seconds from .mp4 file using ffmpeg?](https://askubuntu.com/questions/977162/how-to-remove-a-few-seconds-from-mp4-file-using-ffmpeg)

## 视频加水印
```bash
ffmpeg -i input.mp4 -i watermark.png -filter_complex "[1]lut=a=val*0.1[a];[0][a]overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" output.mp4
```

* [How to Add a Watermark to Video](https://gist.github.com/bennylope/d5d6029fb63648582fed2367ae23cfd6)
* [Watermarking Videos from the Command Line with FFMPEG Filters](http://ksloan.net/watermarking-videos-from-the-command-line-using-ffmpeg-filters/)
* [ffmpeg add semi transparent watermark(png) with different size
](https://stackoverflow.com/questions/39591675/ffmpeg-add-semi-transparent-watermarkpng-with-different-size)

## 视频提取更换音轨
```bash
# 1. 取音轨
ffmpeg -i myvideo.mp4 -vn -acodec copy audio.ogg
# 2. 换音轨
ffmpeg -i v.mp4 -i a.wav -c:v copy -map 0:v:0 -map 1:a:0 new.mp4
```
* [FFmpeg: Extract Audio From Video In Original Format Or Converting It To MP3 Or Ogg Vorbis](https://www.linuxuprising.com/2019/11/ffmpeg-extract-audio-from-video-in.html)
* [ffmpeg - replace audio in video](https://superuser.com/questions/1137612/ffmpeg-replace-audio-in-video)

## 对多个对象做同样处理
* [Bash参考手册](http://www.gnu.org/software/bash/manual/bashref.html)
```bash
find . -iname "*.pdf" -exec convert -input {} -output {}.jpg \;
或者
for file in *.pdf; do convert -input "$file" -output "${file/%pdf/jpg}"; done

## Cisco Anyconnect在ubuntu 18.04上的替换方案
```bash
  # 安装openconnect，兼容anyconnect
  sudo apt-get install network-manager-openconnect-gnome
  # 测试vpn链接
  sudo openconnect 私有局域网服务器
```
重启电脑，用GUI设置私有局域网链接


## 定制显示屏分辨率
```bash
# 0. 显示显示器分辨率列表
xrandr
# 1. 生成分辨率配置
cvt 1920 1080
# 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# 2. 新建分辨率配置
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# DP-1为要加模式的显示器
xrandr --addmode DP-1 "1920x1080_60.00"
```

* [](https://www.tecmint.com/set-display-screen-resolution-in-ubuntu/)

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

## ssh 访问github
0. https 访问 github, 提供用户名和密码
```bash
git clone https://github.com/usernameatgithub/repo.git
# ex.
git clone https://github.com/ufidon/Za.git
```

## 多个SSH密钥访问不同Github 及 Gitlab账号

1. 为不同账号生成不同密钥
```bash
    ssh-keygen -t rsa -b 4096 -C "账号1 email" -f 账号1.私钥
    ssh-keygen -t rsa -b 4096 -C "账号2 email" -f 账号2.私钥
```
2. 为不同账号配置公钥
    ```bash
    cd ~/.ssh/
    vim config
    ```

    config内容:
    ```bash
    \# Github账号
    Host account1.github.com
    	HostName github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/账号1.私钥
    
    \# Gitlab账号
    Host account2.github.com
    	HostName github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/账号2.私钥
    ```

3. 添加身份
    ```bash
    0. 运行认证代理
    eval `ssh-agent -s`
    1. 删除缓存钥匙
	ssh-add -D
    2. 添加私钥
    ssh-add ~/.ssh/账号1.私钥
    ssh-add ~/.ssh/账号2.私钥
    ```

4. 测试
    ```bash
    ssh -T git@github.com
    ssh -T git@gitlab.com
    ```


[参考](https://coderwall.com/p/7smjkq/multiple-ssh-keys-for-different-accounts-on-github-or-gitlab)

1. 访问
```bash
git clone git@github.com:usernameatgithub/repo.git
# ex.
git clone git@github.com:ufidon/Za.git
```
2. 设置
 2.1 检查是否有可用的ssh钥匙
 ```bash
 ls -al ~/.ssh
 ```
 2.2 若没有则制作
 ```bash
 ssh-keygen -t rsa -b 4096 -C "your email"
 # 保存生成的钥匙于默认位置
 ```
 2.3 把ssh钥匙放入ssh-agent
 ```bash
 eval "$(ssh-agent -s)"
 ssh-add ~/.ssh/id_rsa
 ```
 2.4 从私钥制作公钥, 再登录github.com添加此公钥
 ```bash
 openssl rsa -in 私钥 -pubout > 公钥
 # 或者
 openssl rsa -in 私钥 -pubout -out 公钥
 ```
 2.5 测试ssh至github
 ```bash
 ssh -vT git@github.com
 # ssh -vT usernameatgithub@github.com
 ```

* [参考1](https://help.github.com/en/articles/about-ssh)
* [参考2](https://help.github.com/en/articles/troubleshooting-ssh)



