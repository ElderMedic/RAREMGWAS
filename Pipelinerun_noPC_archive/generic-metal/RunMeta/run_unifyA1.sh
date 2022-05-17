#!/bin/bash

#SBATCH --partition=highmem
#SBATCH -J run_unifyA1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem 120000

module add tools/miniconda/python3.8
cd /exports/reum/CKe/generic-metal/RunMeta/
python "/exports/reum/CKe/generic-metal/RunMeta/unifyA1.py"