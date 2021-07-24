# 汉字输入法

* [中州韻輸入法引擎](https://github.com/rime)
  * [fcitx-rime](https://github.com/fcitx/fcitx-rime)
  * [四叶草拼音输入方案](https://github.com/fkxxyz/rime-cloverpinyin)
  * [输入法皮肤](https://github.com/VOID001/ssf2fcitx)
    * [搜狗输入法皮肤](https://github.com/fkxxyz/ssfconv)
    * [使用说明](https://www.fkxxyz.com/d/ssfconv/)

```bash
# 0. 安装中州韵输入法
sudo ap install  fcitx-rime
# 1、从 https://github.com/fkxxyz/rime-cloverpinyin/releases 下载四叶草拼音输入方案
# 2. 将下载文件解压到 	~/.config/fcitx/rime(用户文件夹)
# 3. 在用户文件夹下创建 default.custom.yaml，输入内容
patch:
  "menu/page_size": 8
  schema_list:
    - schema: clover

```