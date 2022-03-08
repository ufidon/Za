# https://stackoverflow.com/questions/16767575/how-to-remove-remove-multiple-different-extensions-from-a-word-list-in-gnu-make
# https://stackoverflow.com/questions/54020765/simple-loop-over-files-in-some-directory-makefile
# https://unix.stackexchange.com/questions/347032/makefile-looping-files-with-pattern
# https://makefiletutorial.com/
# https://github.com/alejandrogallo/simple-latex-makefile/blob/master/Makefile

TEXER=xelatex
BIBER=bibtex
BOOK=main
CHAPDIR=./chapters

all: $(BOOK).tex  $(CHAPDIR)/*.tex
	$(TEXER) $(BOOK)
	for f in $$(ls ${CHAPDIR}/*.tex); do $(BIBER) $${f%.*}; done
	$(TEXER) $(BOOK)
	$(TEXER) $(BOOK)

# all: $(BOOK).tex $(CHAPDIR)/*.tex
# 	for f in $$(ls ${CHAPDIR}/*.tex); do echo $${f%.*}; done


.PHONY: clean
clean:
	rm *.aux *.log	*.toc
