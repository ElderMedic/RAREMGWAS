#!/bin/bash

#SBATCH --partition=highmem
#SBATCH -J compareA1_NMISS
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem 100000

python "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/checkNMISS.py"