## DEFINITIONS

FOLDERS = input
PAPER_SECTIONS = $(shell grep '\\input' paper.tex  | grep -v '%.*\\input' | sed 's/^.*\\input{\(.*\.tex\)}.*/\1/')
#These two lines are commented out because paper.tex lacks content at the moment:
#PAPER_INPUTS_TEX = $(shell $(PAPER_SECTIONS) | xargs grep '\\input' | grep -v '%.*\\input' | sed 's/^.*\\input{\(.*\.tex\)}.*/\1/')
#PAPER_INPUTS_IMG = $(shell $(PAPER_SECTIONS) | xargs grep '\\includegraphics' | grep -v '%.*\\includegraphics' | sed 's/^.*\\includegraphics\[.*\]{\(.*\)}.*/\1/')

## RECIPES

all: $(FOLDERS) $(PAPER_INPUTS_TEX) $(PAPER_INPUTS_IMG) paper.pdf

$(FOLDERS):
	mkdir $@

paper.pdf: paper.tex $(PAPER_INPUTS_TEX) $(PAPER_INPUTS_IMG)
	if command -v sbatch > /dev/null ; then module load texlive; fi
	pdflatex -draftmode paper.tex
	bibtex paper.aux
	pdflatex -draftmode paper.tex
	pdflatex paper.tex
	rm paper.log paper.aux paper.out
	rm paper.bbl paper.blg
