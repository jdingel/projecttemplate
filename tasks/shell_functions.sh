`##This file defines shell functions that
# 1. Improve Makefiles' readability by compartmentalizing all the "if" statement around SLURM vs local executables.
# 2. Cause Stata to report an error to Make when the Stata log file ends with an error.`;

stata_with_flag() {
	stata_pc_and_slurm $@;
	LOGFILE_NAME=$(basename ${1%.*}.log);
	if grep -q '^r([0-9]*);$' ${LOGFILE_NAME}; then
		echo "STATA ERROR: There are errors in the running of ${1} file";
		echo "Exiting Status: $(grep '^r([0-9]*);$' ${LOGFILE_NAME} | head -1)";
		exit 1;
	fi
} ;

stata_pc_and_slurm() {
	if command -v sbatch > /dev/null ; then
		command1="module load stata/18";
		command2="stata-se -e $@";
		jobname1=$(echo "${1%.*}_" | sed 's/\.\.\/input\///');
		jobname2=$(echo ${@:2} | sed -E 's/\.\.\/(temp|input|code|output).//g' | sed -E 's/( |\/)/_/g' | cut -c '1-200');
		full_jobname=$(echo "$jobname1$jobname2" | sed -E 's/_{2,}/_/g' | sed -E 's/_$//g');
		print_info Stata $@;
		sbatch -W --export=command1="$command1",command2="$command2" --job-name="$full_jobname" run.sbatch;
	else
		if command -v stata-mp >/dev/null ; then
			print_info Stata $@;
			stata-mp -e $@;
		elif command -v stata-se >/dev/null ; then
			print_info Stata $@;
			stata-se -e $@;
		else
			echo "Stata/MP and Stata/SE not installed on this machine, or not found in PATH. Please fix to continue.";
			exit 1;
		fi;
	fi 
} ; 

R_with_flag() {
	R_pc_and_slurm $@;
	if [ "$1" == "--no-job-name" ]; then
		shift;
	fi ;
	LOGFILE_NAME=$(basename ${1%.*}.log);
	if grep -q '^r([0-9]*);$' ${LOGFILE_NAME}; then 
		echo "R ERROR: There are errors in the running of ${1} file";
		echo "Exiting Status: $(grep '^r([0-9]*);$' ${LOGFILE_NAME} | head -1)";
		exit 1;
	fi
} ;

R_pc_and_slurm() {
	if command -v sbatch > /dev/null ; then
		command1="echo R is not a module on Columbia HPC";
		command2="Rscript $@";
		jobname1=$(echo "${1%.*}_" | sed 's/\.\.\/input\///');
		jobname2=$(echo ${@:2} | sed -E 's/\.\.\/(temp|input|code|output).//g' | sed -E 's/( |\/)/_/g' | cut -c '1-200');
		full_jobname=$(echo "$jobname1$jobname2" | sed -E 's/_{2,}/_/g' | sed -E 's/_$//g');
		print_info R $@;
		sbatch -W --export=command1="$command1",command2="$command2" --job-name="$full_jobname" run.sbatch;
	else
        print_info R $@;
        Rscript $@;
	fi 
} ; 

julia_pc_and_slurm() {
	if command -v sbatch > /dev/null ; then
		command1="module load julia/1.10.2";
		command2="julia $@";
		jobname1=$(echo "${1%.*}_" | sed 's/\.\.\/input\///');
		jobname2=$(echo ${@:2} | sed -E 's/\.\.\/(temp|input|code|output).//g' | sed -E 's/( |\/)/_/g' | cut -c '1-200');
		full_jobname=$(echo "$jobname1$jobname2" | sed -E 's/_{2,}/_/g' | sed -E 's/_$//g');
		print_info Julia $@;
		sbatch -W --export=command1="$command1",command2="$command2" --job-name="$full_jobname" run.sbatch;
	else
        print_info Julia $@;
		check_julia_version 1.10.2;
        julia +1.10.2 $@;
	fi
} ;

check_julia_version() {
	if command -v juliaup > /dev/null; then
		if ! juliaup status | grep -v "release" | grep -q "$1"; then
			echo "Julia version $1 was not found on this machine. To use version $1, please run 'juliaup add $1'.";
			exit 1;
		fi;
	else
		echo "juliaup is not installed on this machine. Please follow instructions to do so at https://julialang.org/downloads/";
		exit 1;
	fi;
} ;

print_info() {
	software=$1;
	shift; 
	if [ $# == 1 ]; then
		echo "Running ${1} via ${software}, waiting...";
    else
        echo "Running ${1} via ${software} with args = ${@:2}, waiting...";
	fi
}
