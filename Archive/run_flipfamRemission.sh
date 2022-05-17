#!/bin/bash

#SBATCH --partition=highmem
#SBATCH -J flip_fam_remission
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCJ -N4
#SBATCH --ntasks=4
#SBATCH --mem 64000

module add tools/miniconda/python3.8
python "/exports/reum/CKe/flipfamRemission.py"