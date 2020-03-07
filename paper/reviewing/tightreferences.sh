#!/bin/sh

#Substitute ~\ref for \ref for words ending in [ens] like Figures, Table, Section, Definition
cd ../sections
for file in *.tex
do
	sed -i.bu 's/\([ens]\)\ \\ref{/\1~\\ref{/g' $file && rm $file.bu
done

#Substitute ~\eqref for \eqref
for file in *.tex
do
	sed -i.bu 's/equation \\eqref{/equation~\\eqref{/g' $file && rm $file.bu
	sed -i.bu 's/equations \\eqref{/equations~\\eqref{/g' $file && rm $file.bu
done

#Substitute "column~1" for "column 1"
for file in *.tex
do
	sed -i.bu 's/column \([0-9]\)/column~\1/g' $file && rm $file.bu
done
