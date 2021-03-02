#!/bin/bash
#Script to generate graph of tasks

echo -e 'digraph G {' > ../output/graph.txt

find ../../*/code -depth 1 -name "Makefile" | xargs grep -o 'input.*:.*output' |
sed 's/\.\.\/\.\.\///g' | #Drop leading relative path ../../ from start of line
sed 's/\/code\/Makefile:input.*:/ \->/' | sed 's/\/output$//' | sed 's/ | / /' | #Drop folders and file names; show only tasks
awk -F' -> ' '{ print $2 " -> " $1}' | #Flip order to reflect task flow, not symbolic link direction
sort | uniq >> ../output/graph.txt

find ../../*/code -name "Makefile" | xargs grep 'ln ' |
grep -v 'ln \-s \$[<|] \$@' | # Drop recipes that don't show target (these ought to be handled differently)
sed 's/\.\.\/\.\.\///g' | #Drop leading relative path ../../ from start of line
sed 's/if \[.*\] ; then ln \-s//' | sed 's/; else exit 1; fi//'    | #drop if statement components
sed 's/\/code\/Makefile\:/ \->/' | sed 's/\/output\/.*//'  | sed 's/\/code\/.*//' | #drop within-task directories
grep -v '[[:space:]]*[A-Za-z_]*\/input\/' | #Drop symbolic links that point to 'input' folders
sed 's/[[:space:]]*//g' | awk -F'->' '{ print $2 "->" $1}' | #sed 's/\->/ \-> /' | #Drop all spaces; put spaces around symbolic link arrow
sort | uniq >> ../output/graph.txt

echo '}' >> ../output/graph.txt
