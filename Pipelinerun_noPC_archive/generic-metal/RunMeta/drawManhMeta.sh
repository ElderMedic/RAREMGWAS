#!/bin/sh
# do not re-run in same folder, if so make sure all files generated are deleted

#SBATCH --partition=all,highmem
#SBATCH -J Metadraw2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

module load statistical/R/3.6.2/gcc.8.3.1

Rscript "/exports/reum/CKe/generic-metal/RunMeta/drawManhMeta.r" $1 $2