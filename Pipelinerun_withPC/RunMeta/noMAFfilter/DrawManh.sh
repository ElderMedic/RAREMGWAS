#!/bin/sh

# do not re-run in same folder, if so make sure all files generated are deleted

#SBATCH --partition=all,highmem
#SBATCH -J Draw_manh_meta
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

#awk to remove NA rows, this step is merged into Run_gwas.sh
module load statistical/R/3.6.2/gcc.8.3.1

path_dir=/exports/reum/CKe/Pipelinerun_withPC/noMAFfilter/

Rscript "DrawManh.r" /exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/PlinkMeta_A1corr_noMAFfilter_Allcohorts_withPC.meta /exports/reum/CKe/Pipelinerun_withPC/noMAFfilter/

