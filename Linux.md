# Linux 技巧杂记

## 不安装推荐包
apt --no-install-recommends install [软件包]

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

## 压缩文件
7z a -p -mhe=on 压档名.7z 被压档或夹名

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
1. 将字体文件复制至 /usr/share/fonts, /usr/local/share/fonts, 或 ~/.fonts
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

## 视频切割
```bash
ffmpeg -i in.mp4 -filter:v "crop=out_w:out_h:x:y" out.mp4
# x:y 切割视频左上角在原视频中的位置
# out_w:out_h 切割视频长宽
```
* [How can I crop a video with ffmpeg?](https://video.stackexchange.com/questions/4563/how-can-i-crop-a-video-with-ffmpeg)
* [FFmpeg Filters Documentation](https://ffmpeg.org/ffmpeg-filters.html)


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
# 3. 反复播放音乐至视频结束
ffmpeg -i inputVideoFilePath -filter_complex "amovie=inputAudioFilePath:loop=0,asetpts=N/SR/TB[aud];[0:a][aud]amix[a]" -map 0:v -map '[a]' -c:v copy -c:a aac -b:a 256k -shortest outputVideoFilePath
```
* [FFmpeg: Extract Audio From Video In Original Format Or Converting It To MP3 Or Ogg Vorbis](https://www.linuxuprising.com/2019/11/ffmpeg-extract-audio-from-video-in.html)
* [ffmpeg - replace audio in video](https://superuser.com/questions/1137612/ffmpeg-replace-audio-in-video)
* [FFmpeg Mixing new Audio with video repeat audio until video finishes
](https://superuser.com/questions/1319945/ffmpeg-mixing-new-audio-with-video-repeat-audio-until-video-finishes)

## 录屏
```bash
# 1. 软件编码
ffmpeg -f gdigrab -framerate 30 -i desktop -c:v libx264 output.mkv -f dshow -i audio="Stereo Mix (Realtek Audio)" output.mkv
# 2. 硬件编码
ffmpeg -f gdigrab -framerate 30 -i desktop -c:v h264_nvenc  output.mkv -f dshow -i audio="Remote Audio" 
```
* [Screen recording using ffmpeg](https://superuser.com/questions/1580982/screen-recording-using-ffmpeg)
* [Capturing your Desktop / Screen Recording](https://trac.ffmpeg.org/wiki/Capture/Desktop)

## 远程录屏丢失
1. 本地机器注册表更改
```reg
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Terminal Server Client]
"RemoteDesktop_SuppressWhenMinimized"=dword:00000002
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Terminal Server Client]
"RemoteDesktop_SuppressWhenMinimized"=dword:00000002
```
2. 远程机器以此命令退出远程桌面
```batch
:: X为远程会话号，通常为1
%windir%\System32\tscon.exe X /dest:console
```

* [Recording disconnected RDP sessions](https://github.com/rdp/screen-capture-recorder-to-video-windows-free/issues/7)
* [screencapture with rdp connections](https://www.autoitscript.com/forum/topic/133603-screencapture-with-rdp-connections/)
* [Using RemoteDesktop_SuppressWhenMinimized for a nested RDP session](https://social.technet.microsoft.com/Forums/sqlserver/en-US/0dd103cc-0da3-4d78-9a79-7aaf8598184c/using-remotedesktopsuppresswhenminimized-for-a-nested-rdp-session?forum=winserverTS)

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

## 用系统精灵替换老本地
```bash
# 1.系统精灵+程序
# 1.1 创建一个程序/usr/local/bin/xshare.sh
# ------------
#！/usr/bin/bash
# 挂载主机虚拟机共享文件夹
mount -t vboxsf -o rw,uid=1000,gid=1000 share /home/f/host
# echo $(date +%F" "%T) "挂载程序被执行了" >> /var/log/共享.log
# ------------

# 1.2 创建精灵文件/lib/systemd/user/xshare.service
# ------------
[Unit]
Description= 执行 /usr/local/bin/xshare.sh
[Service]
ExecStart=/usr/local/bin/xshare.sh
[Install]
WantedBy=multi-user.target
# ------------
# 1.3 在/etc/systemd/system目录下创建链接文件至上述精灵文件
sudo ln -s /lib/systemd/user/xshare.service /etc/systemd/system/xshare.service

# 1.4 激活并启动该精灵
sudo systemctl status xservice
sudo systemctl enable xservice
sudo systemctl start xservice

# 1.5 检验
sudo journalctl -u xservice
sudo systemctl status xservice

# 2.激活老本地，不建议再用
sudo systemctl enable rc-local
# check the man page for systemd-rc-local-generator
```

* [Replacing rc.local in systemd Linux systems](https://www.redhat.com/sysadmin/replacing-rclocal-systemd)

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

```bash
# 0. https 访问 github, 提供用户名和密码
git clone https://github.com/usernameatgithub/repo.git
# ex.
git clone https://github.com/ufidon/Za.git

# 1. ssh 访问 github, 无需提供用户名和密码
git clone git@github.com:ufidon/za.git

# https 转 ssh
git remote -v
git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
# ssh 转 https
git remote -v
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

* [Managing remote repositories](https://docs.github.com/en/github/getting-started-with-github/getting-started-with-git/managing-remote-repositories)

## git 标签管理

```bash
# 列出标签
git tag
# 查看标签
git show v1.6

# 创建注释标签并提交远程服务器
git tag -a v1.6 -m "稳定版 1.6"
git push origin v1.6

# 创建轻标签
git tag v1.6-lw

# 给以前的提交打标签
# 查看提交
git log --pretty=oneline
# 打标签
git tag -a v1.2 9fceb02

# 删除标签
git tag -d v1.6-lw
git push origin :refs/tags/v1.6-lw
# 二合一做法
git push origin --delete v1.6-lw

# 取出某标签版
git pull
git checkout v2.0.0

```

* [Git Basics - Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

## git本地仓库与远程仓库的比较
```bash
# 获取远程仓库信息
git fetch

# 查看所有分支
git branch -a

# 比较相应的分支，如master（本地）与origin/master(远程)
git diff master origin/master
```

## git bash 添加私钥

```bash
exec ssh-agent bash 
eval ssh-agent -s
ssh-add ~/.ssh/id_rsa
```
* [Running SSH Agent when starting Git Bash on Windows](https://stackoverflow.com/questions/18404272/running-ssh-agent-when-starting-git-bash-on-windows)
* [Setup SSH Authentication for Git Bash on Windows](https://gist.github.com/bsara/5c4d90db3016814a3d2fe38d314f9c23)
* [Automatically starting ssh-agent when powershell or git-bash are started](https://dmtavt.com/post/2020-08-03-ssh-agent-powershell/)

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

- 参考
  - [Using multiple github accounts with ssh keys](https://gist.github.com/oanhnn/80a89405ab9023894df7)
  

1. 访问
```bash
git clone git@github.com:usernameatgithub/repo.git
# ex.
git clone git@github.com:ufidon/Za.git
```
1. 设置
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

## Git教程
* [集锦](https://gist.github.com/jaseemabid/1321592)

## wsl2高级配置
```powershell
# 1. Enable Hyper-V and Management PowerShell Features:
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell

# 2. Create an External Virtual Switch in Hyper-V:
New-VMSwitch -Name "External Switch" -NetAdapterName eth0

# 3. Modify the WSL Configuration:
# $env:USERPROFILE/.wslconfig to configure global settings 
#   across all installed distributions running on WSL 2.
[wsl2]
networkingMode=bridged
vmSwitch="External Switch"
dhcp=true
ipv6=true

# 3.1 In powershell,
wsl --shutdown # then turn on the guest

# 3.2 verify the networkingMode in guest Linux
wslinfo --networking-mode

# 4. Enable systemd in the WSL Distribution:
# /etc/wsl.conf to configure local settings per-distribution 
#   for each Linux distribution running on WSL 1 or WSL 2.
[boot]
systemd=true
[network]
hostname = HOSTAGE
generateResolvConf = false

# 5. Configure Network Addressing:
# 5.1 For dynamic address configuration
# /etc/systemd/network/10-eth0.network:
[Match]
Name=eth0
[Network]
DHCP=yes

# 5.2 For static address configuration, use
[Match]
Name=eth0
[Network]
Address=192.168.x.xx/24
Gateway=192.168.x.x
DNS=192.168.x.x

# 6. Link systemd Resolv.conf:
ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf

# 7. Restart the WSL 2 instance and verify the network configuration with:
ip addr show eth0
```

- [WSL2 make available/visible all Windows' network adapters inside Ubuntu](https://superuser.com/questions/1670969/wsl2-make-available-visible-all-windows-network-adapters-inside-ubuntu)
- [Advanced settings configuration in WSL](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

## 版本管理
```bash
# 0. 都安装到/opt
sudo chown -R $USER:$USER /opt

# 1. 安装sdkman
export SDKMAN_DIR="/opt/sdkman" && curl -s "https://get.sdkman.io" | bash
# 用sdkman安装多个java版本

# 2. 安装nvm
# 安装依件
sudo apt install build-essential libssl-dev

# 安装nvm
export NVM_DIR="/opt/nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
# 放如下三行于 $HOME/.bashrc
export NVM_DIR="/opt/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

# 手工更新
(
  cd "$NVM_DIR"
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

# 安装LTS node
nvm install --lts
nvm use --lts

# 3. 安装miniconda
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

conda config --add channels conda-forge
conda update conda

# 建ml环境并安装scikit-learn和pytorch
conda create --name ml scikit-learn # 建名为ml的环境并安装scikit-learn
conda env --list
conda info --envs
conda activate ml

conda install  numpy scipy matplotlib ipython jupyter pandas sympy nose scikit-image
# 安装pytorch
conda install pytorch torchvision torchaudio cpuonly -c pytorch
conda deactivate

# 建tensorflow 环境并安装
conda create -n tensorflow python=3.8
conda activate tensorflow
pip install --upgrade pip
wget https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow_cpu-2.4.0-cp38-cp38-manylinux2010_x86_64.whl
pip install ./tensorflow_cpu-2.4.0-cp38-cp38-manylinux2010_x86_64.whl
pip install  numpy scipy matplotlib ipython jupyter pandas sympy nose scikit-image
conda deactivate

# 建sage环境并安装sagemath
conda install mamba -c conda-forge # installs mamba
mamba create -n sage sage -c conda-forge # replaces "conda create..."

# 配置SageTex
TEXMFHOME=$(kpsewhich -var-value=TEXMFHOME)
echo $TEXMFHOME 
ln -s /opt/miniconda/envs/sage/share/texmf/tex/latex/sagetex "$TEXMFHOME/tex/latex/sagetex"
ls -l "$TEXMFHOME/tex/latex/sagetex"
ls -l "$TEXMFHOME/tex/latex/sagetex/"
TEXLOCAL=$(kpsewhich -var-value=TEXMFLOCAL)
echo $TEXLOCAL
texhash $TEXLOCAL

# jyputer notebook 显示Latex数学公式
%display latex
```


* [sdkman](https://sdkman.io/)
* [nvm](https://github.com/nvm-sh/nvm)
  * [.profile not running when I start a bash terminal](https://superuser.com/questions/385766/profile-not-running-when-i-start-a-bash-terminal)
* [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html)
  * [Get your computer ready for machine learning: How, what and why you should use Anaconda, Miniconda and Conda](https://towardsdatascience.com/get-your-computer-ready-for-machine-learning-how-what-and-why-you-should-use-anaconda-miniconda-d213444f36d6)
  * [scikit-learn](https://scikit-learn.org/stable/install.html)
  * [scipy](https://www.scipy.org/install.html)
  * [scikit-image](https://scikit-image.org/docs/stable/install.html)
  * [pytorch](https://pytorch.org/get-started/locally/)
  * [tensorflow](https://www.tensorflow.org/install?)
    * [Not creating XLA devices, tf_xla_enable_xla_devices not set](https://github.com/tensorflow/tensorflow/issues/44683)
  * [sagemath](https://doc.sagemath.org/html/en/installation/conda.html)

## 远程桌面
```bash
# 1. 安装桌面
sudo apt update -y && sudo apt upgrade -y
sudo apt install ubuntu-desktop # install Gnome

# xrdp可选
sudo apt install xubuntu-desktop


# 2. 安装xrdp
sudo apt install dbus-x11 xrdp xorgxrdp
sudo systemctl status xrdp

# xrdp默认采用/etc/ssl/private/ssl-cert-snakeoil.key
sudo adduser xrdp ssl-cert

sudo systemctl restart xrdp

# 3.防火墙设置
sudo ufw allow from 登录机所在cidr to any port 3389

# 允许从任何地方远程桌面
sudo ufw allow 3389

# 4. 去除每次远程登录之授权请求
# 4.1 wifi扫描
sudo vim /etc/polkit-1/localauthority/50-local.d/10-network-manager.pkla # 键入下文
[Allow Wifi Scan]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.wifi.scan;org.freedesktop.NetworkManager.enable-disable-wifi;org.freedesktop.NetworkManager.settings.modify.own;org.freedesktop.NetworkManager.settings.modify.syste>
ResultAny=yes
ResultInactive=yes
ResultActive=yes

# 4.2 色彩设备
sudo vim  /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla  # 键入下文
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
```


* [How to Install Xrdp Server (Remote Desktop) on Ubuntu 20.04](https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/)
  * [xRDP – Easy install xRDP on Ubuntu](https://c-nergy.be/blog/?p=15733)
  * [xRDP – How to Fix the Infamous system crash popups](http://c-nergy.be/blog/?p=12043)
  * [xRDP - Authentication required. System policy prevents WiFi scans](https://askubuntu.com/questions/1291512/authentication-required-system-policy-prevents-wifi-scans-in-focalfossa)
  * [Error "Could not acquire name on session bus"](https://github.com/neutrinolabs/xrdp/issues/1559)
  * [Using the console and XRDP together in Debian / Ubuntu / Mint](https://github.com/neutrinolabs/xrdp/wiki/Debian-dbus-user-session-package)
* [xrdp thinclient_drive](http://catch22cats.blogspot.com/2018/05/xrdp-creates-strange-directory-called.html)

## VPN
用多协议客户openconnect可连接多种VPN服务器，从而无需安装相应客户端，如Cisco AnyConnect，GlobalProtect等。

```bash
# 1. 安装openconnect
sudo apt install network-manager-openconnect-gnome
# 2. 用openconnect图形界面连接VPN服务器，如失败用以下命令行，
# 保持运行以维持连接，关闭则断开
# 2.1 代替GlobalProtect客户端
sudo openconnect --protocol=gp vpn服务器 -u 户名
# 2.2 代替AnyConnect客户端
sudo openconnect --protocol=anyconnect vpn服务器 -u 户名

```

* [How to connect to a GlobalProtect VPN](https://linuxkamarada.com/en/2020/03/19/how-to-connect-to-a-globalprotect-vpn)
* [openconnect - Multi-protocol VPN client, for Cisco AnyConnect VPNs and others](https://manpages.ubuntu.com/manpages/jammy/man8/openconnect.8.html)
  * [支持的vpn协议](https://www.infradead.org/openconnect/protocols.html)