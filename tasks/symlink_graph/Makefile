all: ../output/task_flow.png

../output:
	mkdir $@

../output/task_flow.png: graphmaker.sh | ../output
	bash graphmaker.sh
