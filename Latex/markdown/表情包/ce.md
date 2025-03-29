# 含彩色表情包`笔记` → pdf

<!-- 
% 1、表情包预处理，用自定义字体命令包围: 
采用如下规则表达式替换:
%[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}] 
→ \emojitext{$1}

2、命令行
pandoc ce.md -o ce.pdf --pdf-engine=lualatex -V mainfont="FandolKai" -V mainfontoptions="Scale=MatchUppercase" -V monofont="Noto Sans Mono CJK SC"  --include-in-header=preamble.tex
-->

你好，这里有些彩色表情包:

- \emojitext{🚀} Rocket
- \emojitext{❤}️ Heart
- \emojitext{😄} Smile
- \emojitext{🌟} Star
- \emojitext{🎉} Celebration

Thank you for checking out this example! \emojitext{🎯🎉🪃🦩🐮}
