#DEFINITIONS

SLIDES_SECTIONS := $(shell grep '\\input' slides.tex | grep -v '%.*input' | grep -o 'sections/[A-Za-z0-9_\-]*\.tex')
SLIDES_INPUTS := $(shell grep --no-filename 'input/' $(SLIDES_SECTIONS) slides.tex | grep -v '^%' | grep -o 'input/[A-Za-z0-9_\.\-]*\.[a-z]*')

all: slides.pdf

.PHONY: clean inputs
clean:
	rm *.log *.aux
inputs: $(SLIDES_INPUTS)

input/:
	mkdir $@

slides.pdf: slides.tex $(SLIDES_SECTIONS) $(SLIDES_INPUTS)
	if command -v sbatch > /dev/null ; then module load texlive; fi
	pdflatex -draftmode $<
	bibtex $(basename $<).aux
	pdflatex -draftmode $<
	pdflatex $<
	rm $(addprefix $(basename $<),.log .aux .out .toc)
	rm $(addprefix $(basename $<),.snm .nav)
	rm $(addprefix $(basename $<),.blg .bbl)

slides_notesonly.pdf: slides.tex $(SLIDES_SECTIONS) $(SLIDES_INPUTS)
	sed 's/notes=hide/notes=only/' slides.tex  > slides_notesonly.tex
	pdflatex slides_notesonly.tex #This will fail due to natbib's bug with notes-only beamer
	rm slides_notesonly.tex slides_notesonly.log  

#INPUT RECIPES
