#!/bin/bash
#Script to generate graph of tasks based on specified terminal nodes denoted by [shape=box]
#This script simply starts at the terminal nodes and takes one step upstream repeatedly until it encounters no upstream pre-requisites.
#Input path is $1; output path is $2

grep -v '^#' $1 | sed 's/^[[:space:]]*//' | sed 's/ \-> /\->/' > temp_graph.txt #Remove comments from graph.

ENDPOINTS="$(grep '\[shape=box\]' temp_graph.txt | sed 's/ \[shape=box\]/$|/' | sed 's/^/\->/' | tr -d '\n' | sed 's/|$//')"
echo $ENDPOINTS

PREV_ENDPOINTS=""
while [ -n "$ENDPOINTS" ]
do
awk /${ENDPOINTS}/{print} temp_graph.txt >> temp.txt
PREV_ENDPOINTS="$ENDPOINTS"
ENDPOINTS=$(awk /${ENDPOINTS}/{print} temp_graph.txt | awk -F'->' '{print "->" $1 "$|"}' | sort | uniq | tr -d '\n' | sed 's/|$//')
if [ "$ENDPOINTS" = "$PREV_ENDPOINTS" ]; then
    break
fi
done
cat <(echo -e 'digraph G {') <(sort temp.txt | uniq | grep -v 'setup_environment' | sed 's/\-\>/ \-\> /') <(grep '\[shape=box\]' temp_graph.txt) <(echo '}') > $2
rm temp.txt temp_graph.txt

# Check if trimmed graph is acyclic
grep -v '\[shape=box\]' $2 > temp_trim.txt
CYCLIC=$(sed '1d; $d; s/-> //g; s/^[[:space:]]*//' temp_trim.txt | tsort 2>&1 >/dev/null | sed 's/tsort: //' | sed 's/cycle in data/Cycle:/')
if [ -n "$CYCLIC" ]; then
    echo "$CYCLIC"
    rm temp_trim.txt
    exit 1
fi
rm temp_trim.txt
