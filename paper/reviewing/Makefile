all: repeatedwords tightreferences hardcodednumbers chktex textidote

.PHONY: repeatedwords tightreferences hardcodednumbers chktex textidote

repeatedwords:
	egrep "(\b[a-zA-Z]+) \1\b" ../sections/*.tex -n

tightreferences: tightreferences.sh
	bash tightreferences.sh

hardcodednumbers: hardcodednumbers.sh removeequations.awk
	bash hardcodednumbers.sh

chktex: ../paper.tex 
	cd .. && chktex paper.tex

textidote: /Applications/textidote.jar ../reviewing/textidote_dico.txt ../paper.tex 
	java -jar /Applications/textidote.jar --check en --dict ../reviewing/textidote_dico.txt ../paper.tex 
