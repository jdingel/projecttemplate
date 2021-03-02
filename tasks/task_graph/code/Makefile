all: ../output/task_flow.png

../output:
	mkdir $@

../output/graph.txt: graphmaker.sh $(shell find ../../ -name "Makefile") | ../output
	bash graphmaker.sh
../output/task_flow.png: ../output/graph.txt
	dot -Grankdir=LR -Tpng $< -o $@
../output/graph_bidirectional_edges.txt: ../output/graph.txt
	grep -v '{\|}' ../output/graph.txt | awk -F'->' '{if ($$2 < $$1) {print $$2 "," $$1} else {print $$1 "," $$2} }' | sort | uniq -d  > $@
