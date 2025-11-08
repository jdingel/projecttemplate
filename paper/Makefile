## DEFINITIONS

PAPER_SECTIONS = $(shell grep -v '%.*input' paper.tex | grep -o 'sections/[A-Za-z_]*\.tex')
PAPER_INPUTS = $(shell grep --no-filename 'input/' $(PAPER_SECTIONS) paper.tex | grep -v '^%.*\\input' | grep -o 'input/[A-Za-z0-9_\.\-]*\.[a-z]*')

## RECIPES

all: paper.pdf

paper.pdf: paper.tex $(PAPER_INPUTS)
	if command -v sbatch > /dev/null ; then module load texlive; fi
	pdflatex -draftmode $<
	bibtex $(basename $<).aux
	pdflatex -draftmode $<
	pdflatex $<
	rm $(addprefix $(basename $<), .aux .log .out)
	-rm $(addprefix $(basename $<), .bbl .blg)

.PHONY: clean inputs
clean:
	-rm *.aux *.log *.out
	-rm *.toc *.bbl *.blg
inputs: $(PAPER_INPUTS)

input/:
	mkdir $@
