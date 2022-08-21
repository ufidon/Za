# 办公软件技巧杂记

## LibreOffice Calc 格址

* [Addresses and References, Absolute and Relative](https://help.libreoffice.org/Calc/Addresses_and_References,_Absolute_and_Relative)
* [Moving Cells by Drag-and-Drop](https://help.libreoffice.org/Calc/Moving_Cells_by_Drag-and-Drop)

```bash
A1:A7, A1:Q1 相对寻址, 拖到别格可自动变更
$A$1:$A$7, $A$1:$Q$1 绝对寻址, 拖动不变
```

## 行列拖动

* [Swap two columns](https://forum.openoffice.org/en/forum/viewtopic.php?f=9&t=61692)
```bash
1. 选择要拖动列
2. 左键按住选中列高亮区任何地方,试拖鼠标指针变成拖动针
3. 按下ALT键, 拖动, 一条高亮列线显示当前拖至位置
4. 至目标位置松左键完成
```

## SDKMAN 管理的 JDK 与 Zotero LibreOffice插件

需做如下环境设置
```bash
# 1. 建一个sdk.sh 于/etc/profile.d内，内容如下
export JAVA_HOME=/opt/sdkman/candidates/java/current

# 2. 建两个系统软链接
sudo ln -s "$JAVA_HOME/bin/java" /usr/bin/java
sudo ln -s "$JAVA_HOME/bin/javac" /usr/bin/javac


# 3. 安装zotero
# Install zotero, go to the fold where zotero for linux is saved

# Change the following file name(Zotero-5.0.88_linux-x86_64.tar.bz2) to yours
tar jxf Zotero-5.0.88_linux-x86_64.tar.bz2

# Check the name(Zotero_linux-x86_64) of the unarchived folder of zotero, change it to yours
sudo chown $USER:$USER /opt
mv Zotero_linux-x86_64 /opt/zotero
cd /opt/zotero
sudo ./set_launcher_icon
sudo cp /opt/zotero/zotero.desktop /usr/share/applications/
# logout then login Ubuntu, 需要编辑其菜单以指向正确位置
sudo apt install libreoffice-java-common 
# run zotero from start menu and install Zotero LibreOffice plugin
```

pdftk-java 安装有如下设置也不行，自己编译[pdftk-java](https://gitlab.com/pdftk-java/pdftk)
