#!/bin/sh
#SBATCH --partition=all,highmem
#SBATCH -J run_varsoverlap
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --mem=100000
#SBATCH --ntasks=4


python "/exports/reum/CKe/PCArun/VarsOverlap.py"