## DEFINITIONS

PAPER_SECTIONS = $(shell grep -v '%.*input' paper.tex | grep -o 'sections/[A-Za-z_]*\.tex')
PAPER_INPUTS = $(shell grep --no-filename 'input/' $(PAPER_SECTIONS) paper.tex | grep -v '^%.*\\input' | grep -o 'input/[A-Za-z0-9_\.\-]*\.[a-z]*')

## RECIPES

all: paper.pdf

paper.pdf: paper.tex $(PAPER_INPUTS)
	if command -v sbatch > /dev/null ; then module load texlive; fi
	pdflatex -draftmode paper.tex
	bibtex paper.aux
	pdflatex -draftmode paper.tex
	pdflatex paper.tex
	rm paper.log paper.aux paper.out
	rm paper.bbl paper.blg

input/:
	mkdir $@
