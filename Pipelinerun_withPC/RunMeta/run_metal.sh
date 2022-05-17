#!/bin/bash

# Run METAL meat-analysis

#SBATCH --partition=all,highmem
#SBATCH -J run_meta_withTACERA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

/exports/reum/CKe/generic-metal/metal "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/metal-replicateMergedCohort.txt"

#/exports/reum/CKe/generic-metal/metal "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/metal.txt"
