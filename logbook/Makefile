logbookentries := $(shell grep '\\input{.*entries' logbook.tex | sed 's/^.*\\input{\(.*\.tex\).*/\1/')

all: logbook.pdf

logbook.pdf: logbook.tex $(logbookentries)
	pdflatex -draftmode logbook.tex
	pdflatex logbook.tex
	rm logbook.log logbook.out logbook.toc logbook.aux
