#!/bin/bash
#Script to document code dependencies

find ../../*/code -maxdepth 1 -name "Makefile" | while read makefile; do
    # Extract the current task name from the Makefile path
    current_task=$(echo "$makefile" | sed 's/\.\.\/\.\.\///g' | sed 's/\/code\/Makefile//') # current task that Makefile is located
    
    # In current_task's Makefile, search for ../taskname/code patterns
    grep -oh '\.\./[A-Za-z0-9_]*/code' "$makefile" | \
    # Ignore interactive_fe_estimation: setup_environment Makefile mentions this task for user_specific_sbatch
    grep -v '\.\./interactive_fe_estimation' | \
    
    # Cleanup path name; just get task
    sed 's/\.\.\///g' | sed 's/\/code//g' | \
    
    while read -r dependency_task; do
    if [[ "$current_task" == "task_graph" && "$dependency_task" == "output" ]]; then
        continue
    fi
    echo "$dependency_task -> $current_task"
    done
    
done | sort | uniq >> ../output/code_dependencies.txt
