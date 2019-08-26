#!/bin/bash
#Script to generate graph of tasks

echo -e 'digraph G {' > ../output/graph.txt

find ../.. -type l -ls | awk '{print $13 " -> " $11}' | #List symbolic links
grep -v '^\.\./\(input\|output\)' | #Drop within-task links
sed 's/^\.\.\/\.\.\/\([a-zA-Z0-9_\-\/]*\)\/output\/.*\.\.\/\.\.\/\([a-zA-Z0-9_\-]*\)\/input\/.*$/\1 -> \2/' | #Retain only task names; drop filenames
sed 's/\/\(input\|output\)\/[a-zA-Z0-9_\.]*//g' | #Retain only task names; drop filenames
sed 's/\.\.\///g' | #Drop relative paths
sed 's/\//_/g' | sed 's/cac\-/cac_/g' | #Eliminate "/" and "-" from node names to please graphviz
sort | uniq >> ../output/graph.txt
echo '}' >> ../output/graph.txt

dot -Grankdir=LR -Tpng ../output/graph.txt -o ../output/task_flow.png
