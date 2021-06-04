SHELL=/bin/bash

all: repeatedwords tightreferences hardcodednumbers chktex textidote checkURLs

.PHONY: repeatedwords tightreferences hardcodednumbers chktex textidote

repeatedwords:
	egrep "(\b[a-zA-Z]+) \1\b" ../sections/*.tex -n

labelsreferenced:
	diff --side-by-side --suppress-common-lines <(grep -o --no-filename 'ref{[A-Za-z0-9:_]*}' ../sections/*.tex | sed 's/ref//' | sort | uniq) <(grep -o --no-filename 'label{[A-Za-z0-9:_]*}' ../sections/*.tex | sed 's/label//' | sort | uniq)

acronyms_usedanddefined:
	diff --side-by-side --suppress-common-lines  <(grep -o --no-filename -E ' \(+[A-Z]+[A-Z]+\)' sections/*.tex | sort | uniq | sed 's/[()]//g' | sed 's/ //g') <(grep --no-filename -v '^%' sections/*.tex | grep -o -E ' [A-Z]+[A-Z]+ ' | sort | uniq | sed 's/ //g')

tightreferences: tightreferences.sh
	bash tightreferences.sh

hardcodednumbers: hardcodednumbers.sh
	bash hardcodednumbers.sh

chktex: ../paper.tex 
	cd .. && chktex paper.tex

textidote: /Applications/textidote.jar ../reviewing/textidote_dico.txt ../paper.tex 
	java -jar /Applications/textidote.jar --check en --dict ../reviewing/textidote_dico.txt ../paper.tex 

URL_LIST:= $(shell grep -o 'href{[A-Za-z0-9:/\._?=]*}' ../sections/*.tex | sed 's/.*href{//' | sed 's/}//' )
checkURLs:
	for URL in $(URL_LIST) ; do wget --spider --no-verbose $${URL} ; done

availablegreeks: greekletters.tex
	diff --side-by-side --suppress-common-lines <(grep -o --no-filename '\\[A-Za-z][a-z]*' ../sections/*.tex | sort | uniq) <(sort greekletters.tex) | grep -v '<' | sed 's/^.*[|>]//'

dueto_list:  #Did you mean "because of", "owing to", or "from"?
	grep -n 'due to' ../sections/*.tex
