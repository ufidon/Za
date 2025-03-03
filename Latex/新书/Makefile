# 定义编译器和选项
LATEX = xelatex
BIBER = biber

# 定义主文件名（不带扩展名）
MAIN = main

# 默认目标
all: $(MAIN).pdf

# 编译规则
$(MAIN).pdf: $(MAIN).tex references.bib
	$(LATEX) $(MAIN).tex
	$(BIBER) $(MAIN)
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex

# 清理临时文件
clean:
	rm -f $(MAIN).aux $(MAIN).bbl $(MAIN).blg $(MAIN).log $(MAIN).out $(MAIN).toc $(MAIN).bcf $(MAIN).run.xml

# 清理所有生成的文件
distclean: clean
	rm -f $(MAIN).pdf

.PHONY: all clean distclean