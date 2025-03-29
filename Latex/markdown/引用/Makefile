# Makefile for converting Markdown files to PDF using Pandoc

PANDOC := pandoc
PDF_ENGINE := xelatex
HIGHLIGHT_STYLE := tango
HEAD := head.tex
MAINFONT := FandolSong
SANSFONT := FandolSong
MONOFONT := FandolSong
MATHFONT := FandolSong
FONTSIZE := 12pt
WRAP := auto
BIB_FILE := references.bib

MD_FILES := $(wildcard *.md)
PDF_FILES := $(patsubst %.md,%.pdf,$(MD_FILES))

.PHONY: all clean

all: $(PDF_FILES)

%.pdf: %.md $(HEAD) $(BIB_FILE)
	@echo "$< → $@"
	$(PANDOC) "$<" -o "$@" \
		-s --pdf-engine=$(PDF_ENGINE) \
		-H $(HEAD) \
		--highlight-style=$(HIGHLIGHT_STYLE) \
		--filter pandoc-crossref \
		--citeproc \
		--bibliography=$(BIB_FILE) \
		-V mainfont="$(MAINFONT)" \
		-V sansfont="$(SANSFONT)" \
		-V monofont="$(MONOFONT)" \
		-V mathfont="$(MATHFONT)" \
		-V fontsize="$(FONTSIZE)" \
		-V colorlinks \
		-V urlcolor=NavyBlue \
		-V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" \
		--wrap=$(WRAP) \
		-N \
		--toc

clean:
	rm -f *.pdf