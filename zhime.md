# 汉字输入法

## ubuntu 22.04 LTS 下安装中州韵输入法
```bash
# 0. 安装中文
# Settings → Region & Language → Mange Installed Languages → 安装中文

# 1. 安装ibus-rime
sudo apt install ibus-rime rime-data-luna-pinyin rime-data-pinyin-simp rime-data-emoji

# 2. 设置输入法
# Settings → Keyboard  → Input Sources  → 添加 Chinese (China) → Chinese (Rime)

# 3. 安装绘字
# 3.1 安装东风破 [https://github.com/rime/plum]
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | bash
# 3.2 安装绘字 [https://github.com/rime/rime-emoji]
./rime-install emoji
./rime-install emoji:customize:schema=luna_pinyin
```

* [中州韻輸入法引擎](https://github.com/rime)
  * [fcitx-rime](https://github.com/fcitx/fcitx-rime)
  * [四叶草拼音输入方案](https://github.com/fkxxyz/rime-cloverpinyin)
  * [输入法皮肤](https://github.com/VOID001/ssf2fcitx)
    * [搜狗输入法皮肤](https://github.com/fkxxyz/ssfconv)
    * [使用说明](https://www.fkxxyz.com/d/ssfconv/)

```bash
# 0. 安装中州韵输入法
sudo apt install  fcitx5-rime
# 1、从 https://github.com/fkxxyz/rime-cloverpinyin/releases 下载四叶草拼音输入方案
# 2. 将下载文件解压到 	~/.local/share/fcitx5/rime(用户文件夹)
# 3. 在用户文件夹下创建 default.custom.yaml，输入内容
patch:
  "menu/page_size": 8
  schema_list:
    - schema: clover

```

## 字母序号
- 造号
```python
for i in range(26):
  print(f"'/x{chr(i+ord('a'))}': [ {chr(i+ord('⒜'))}, {chr(i+ord('ⓐ'))}, {chr(i+ord('Ⓐ'))}, {chr(i+ord('🄐'))}, {chr(i+ord('🄰'))}, {chr(i+ord('🅐'))}, {chr(i+ord('🅰'))} ]")
```  
- [rime特殊符号](./tools/symbols.yaml)

## 雾凇拼音
- [雾凇拼音](https://dvel.me/posts/rime-ice/#%e5%9f%ba%e6%9c%ac%e5%a5%97%e8%b7%af)
  - [仓库](https://github.com/iDvel/rime-ice)
- [librime](https://github.com/rime/librime)