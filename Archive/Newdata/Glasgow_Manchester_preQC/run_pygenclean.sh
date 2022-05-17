#!/bin/bash
#SBATCH --partition=highmem,all
#SBATCH -J run_pygenclean
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=8096MB

module load gwas/plink/1.90p
module load tools/miniconda/python3.8/4.9.2

conda activate CKe27
cd /exports/reum/CKe/Newdata/PLINK_011121_0443/
pyGenClean_duplicated_samples --tfile GSA2021_523b2_025_V3_dupsamples.final --out GSA2021_523b2_025_V3_filtered_dup