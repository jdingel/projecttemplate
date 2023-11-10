#DEFINITIONS

slides_sections := $(shell grep '\\input' slides.tex | grep -v '%.*input' | grep -o 'sections/[A-Za-z0-9_\-]*\.tex')
slides_inputs := $(shell grep --no-filename 'input/' $(slides_sections) slides.tex | grep -v '^%' | grep -o 'input/[A-Za-z0-9_\.\-]*\.[a-z]*')

all: slides.pdf

clean:
	rm *.log *.aux

input/:
	mkdir $@

slides.pdf: slides.tex $(slides_sections) $(slides_inputs)
	#module load texlive
	pdflatex -draftmode $<
	bibtex slides.aux
	pdflatex -draftmode $<
	pdflatex $<
	rm slides.log slides.aux slides.out slides.toc
	rm slides.snm slides.nav
	rm slides.blg slides.bbl	
	#module unload texlive

slides_notesonly.pdf: slides.tex $(slides_sections) $(slides_inputs)
	sed 's/notes=hide/notes=only/' slides.tex  > slides_notesonly.tex
	pdflatex slides_notesonly.tex #This will fail due to natbib's bug with notes-only beamer
	rm slides_notesonly.tex slides_notesonly.log  

#INPUT RECIPES
