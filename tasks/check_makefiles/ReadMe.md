# Check Makefiles

This task includes bash scripts to verify the makefiles in the repo.
These are used by GitHub Actions.

## Code
* `check_makefiles.sh`:
This script runs `make -n` for each task listed.
If an error occurs, the script exits with a non-zero exit code.
If no task-list argument is provided, the script check all task folders.
* `check_nontask_makefiles.sh`:
This script runs `make -n` in the paper, slides, and logbook folders.
If an error occurs, the script exits with a non-zero exit code.
