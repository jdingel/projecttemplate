#!/bin/sh

#SBATCH --output=slurmlogs/%x_%j.out
#SBATCH --error=slurmlogs/%x_%j.err
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5g
#SBATCH --time=3:00:00
#SBATCH --mail-type=FAIL
#SBATCH --account=sscc

$command1
$command2
