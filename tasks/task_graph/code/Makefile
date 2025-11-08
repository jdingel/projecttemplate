SHELL=bash

all: ../output/task_flow.png
branch: $(addprefix ../output/,task_flow.png task_flow_branchdiff.png task_flow_branchdiff_trim.png)

include ../../generic.make

../output/graph.txt: graphmaker.sh $(shell find ../../ -name "Makefile") | ../output
	bash graphmaker.sh
../output/graph_branchdiff.txt: ../output/graph.txt
	cat <(grep -v '}' ../output/graph.txt) <(git diff --name-status origin/main HEAD | grep '^[AM]' | grep -o 'tasks/[A-Za-z0-9_]*' | sed 's/tasks\///' | sort | uniq | sed 's/$$/ [shape=box]/') <(echo }) > $@
../output/graph_%_trim.txt: graph_box_trim.sh ../output/graph_%.txt
	bash $^ $@

../output/task_flow.png: ../output/graph.txt
	dot -Grankdir=LR -Tpng $< -o $@
../output/task_flow_%.png: ../output/graph_%.txt
	dot -Grankdir=LR -Tpng $< -o $@

../output/code_dependencies.txt: code_dependencies.sh $(shell find ../../ -name "Makefile") | ../output
	bash code_dependencies.sh
../output/graph_bidirectional_edges.txt: ../output/graph.txt
	grep -v '{\|}' ../output/graph.txt | awk -F'->' '{if ($$2 < $$1) {print $$2 "," $$1} else {print $$1 "," $$2} }' | sort | uniq -d  > $@
