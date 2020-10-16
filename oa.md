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
## pdftk-java 安装前也需如下设置

需做如下环境设置
```bash
# 1. 建一个sdk.sh 于/etc/profile.d内，内容如下
export JAVA_HOME=/opt/sdkman/candidates/java/current

# 2. 建两个系统软链接
sudo ln -s "$JAVA_HOME/bin/java" /usr/bin/java
sudo ln -s "$JAVA_HOME/bin/javac" /usr/bin/javac

```