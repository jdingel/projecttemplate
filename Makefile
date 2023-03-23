SHELL=bash

README.md: header.md researchinfrastructure.md
	cat $^ > $@
.INTERMEDIATE: researchinfrastructure.md
researchinfrastructure.md: logbook/entries/researchinfrastructure.tex
	pandoc <(sed 's/\\ref{entry:unixshelltips}/A\.9/' $<) -f latex -o $@
