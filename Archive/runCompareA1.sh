#!/bin/bash

#SBATCH --partition=highmem
#SBATCH -J compareA1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCJ -N6
#SBATCH --ntasks=6
#SBATCH --mem 100000

#python "/exports/reum/CKe/compareA1.py" 
python "/exports/reum/CKe/processCompareA1.py"