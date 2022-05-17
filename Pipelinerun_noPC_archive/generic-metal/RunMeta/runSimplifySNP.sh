#!/bin/bash

#SBATCH --partition=all,highmem
#SBATCH -J simplifySNP
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

module add tools/miniconda/python3.8

python "/exports/reum/CKe/generic-metal/RunMeta/simplifySNP.py"