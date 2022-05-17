#!/bin/bash

# prepare assoc.logistic file for meta-analysis

#SBATCH --partition=all,highmem
#SBATCH -J meta_prepare_1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

module add tools/miniconda/python3.8

python "/exports/reum/CKe/meta_prepare.py"