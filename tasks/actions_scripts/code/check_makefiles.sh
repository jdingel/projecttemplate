#!/bin/sh

# this script runs `make -nC` on the given tasks to check Makefiles
# and assume an error occurs when the output includes "Stop."
# note: if no input is provided,
#       then all tasks with a Makefile will be checked.

# check if task graph is acyclic
make -C ../../task_graph/code ../output/graph.txt > /dev/null
CYCLIC=$(sed '1d; $d; s/-> //g; s/^[[:space:]]*//' ../../task_graph/output/graph.txt | tsort 2>&1 >/dev/null | sed 's/tsort: //' | sed 's/cycle in data/Cycle:/')
if [ -n "$CYCLIC" ]; then
    echo "$CYCLIC"
    exit 1
fi

# check makefiles
TASKS="$@" # read in given tasks

# if no task was given, run over all tasks with Makefiles
if [ "$TASKS" == "" ]
then
    TASKS=$(find ../.. -name 'Makefile' | sed "s|/code/Makefile||" | sed "s|\.\./\.\./||" | grep -v '^reports$')
fi

# default exit status
status=0

# run on the given tasks
for task in $TASKS
do
    make_res=$(make -nC ../../$task/code 2>&1 |
        grep "Stop." | sed "s|.*code: ||" | sed "s/Makefile:/Line /")
    if [ "$make_res" != "" ]
    then
        status=1
        echo "::error file=tasks/$task/code/Makefile::tasks/$task/code/Makefile $make_res"
    fi
done

exit $status

