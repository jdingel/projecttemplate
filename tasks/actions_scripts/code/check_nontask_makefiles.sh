#!/bin/sh

# this script runs `make -nC` in the paper, slides, and logbook folders
# It flags an error when the output includes "Stop.""

# default exit status
status=0

# Run Make in the relevant folders
for folder in paper slides logbook
do
    make_res=$(make -nC ../../../$folder 2>&1 |
        grep "Stop." | sed "s|.*code: ||" | sed "s/Makefile:/Line /")
    if [ "$make_res" != "" ]
    then
        status=1
        echo "::error file=$folder/Makefile::$folder/Makefile $make_res"
    fi
done

exit $status

