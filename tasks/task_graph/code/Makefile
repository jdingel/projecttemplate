SHELL=bash

all: ../output/task_flow.png

../output:
	mkdir $@

../output/graph.txt: graphmaker.sh $(shell find ../../ -name "Makefile") | ../output
	bash graphmaker.sh
../output/task_flow.png: ../output/graph.txt
	dot -Grankdir=LR -Tpng $< -o $@
../output/graph_branchdiff.txt: ../output/graph.txt
	cat <(grep -v '}' ../output/graph.txt) <(git diff --name-status master HEAD | grep '^[AM]' | grep -o 'tasks/[A-z0-9_]*' | sed 's/tasks\///' | sort | uniq | sed 's/$$/ [shape=box]/') <(echo }) > $@
../output/task_flow_branchdiff.png: ../output/graph_branchdiff.txt
	dot -Grankdir=LR -Tpng $< -o $@
../output/graph_bidirectional_edges.txt: ../output/graph.txt
	grep -v '{\|}' ../output/graph.txt | awk -F'->' '{if ($$2 < $$1) {print $$2 "," $$1} else {print $$1 "," $$2} }' | sort | uniq -d  > $@
