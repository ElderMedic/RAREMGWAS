#!/bin/bash

#SBATCH --partition=all,highmem
#SBATCH -J run_compare_effect
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

python "/exports/reum/CKe/generic-metal/RunMeta/compareEffectSizes.py"