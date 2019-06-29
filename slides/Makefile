#DEFINITIONS

SLIDES_SECTIONS := $(wildcard sections/*.tex)
FOLDERS = input
INPUTS = #Tasks' output goes here

#RECIPES

all: $(INPUTS) slides.pdf

$(FOLDERS):
	mkdir $@

input/embedthistable.tex : | input
	if [ -e ../tasks/taskname/output/$(@F) ] ; then ln -s ../../tasks/taskname/output/$(@F) $@ ; else exit 1; fi

slides.pdf: slides.tex $(SLIDES_SECTIONS) $(INPUTS)
	#pdflatex -draftmode slides.tex
	#bibtex slides.aux
	pdflatex -draftmode slides.tex
	pdflatex slides.tex
	rm slides.log slides.aux slides.out slides.toc
	rm slides.snm slides.nav
	#rm slides.blg slides.bbl	
