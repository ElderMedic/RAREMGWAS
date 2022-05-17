#!/bin/sh
#SBATCH --partition=all,highmem
#SBATCH -J draw_manhMeta
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=8096MB

module load statistical/R/3.6.2/gcc.8.3.1

Rscript "/exports/reum/CKe/RunMeta/drawManhMeta.r" $1 $2