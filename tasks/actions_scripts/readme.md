# Actions Scripts

This folder contains shell scripts that are used by our GitHub Actions.

* `check_makefiles.sh`:
This script runs `make -n` for each task listed.
If an error occurs, the script exits with a non-zero exit code.
If no task-list argument is provided, the script check all task folders.
* `check_nontask_makefiles.sh`:
This script runs `make -n` in the paper, slides, and logbook folders.
If an error occurs, the script exits with a non-zero exit code.
* `check_tex_files.sh` and `entrypoint.sh` compiles the slides and paper.
These scripts were first developed by [Xu Chang](https://github.com/xu-cheng/latex-action).
