#!/bin/sh

#SBATCH -J PCA_dataset
#SBATCH --partition=all,highmem
#SBATCH --ntasks=3
#SBATCH --mem-per-cpu=10000MB
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=10:0:0


# Load dependencies
module load gwas/plink/1.90p 
module load bioinformatics/tools/SNP/flashpca/2.1/gcc-8.3.1

#shortcut base directory so the code is more readable
baseDIR=/exports/reum/CKe/PCArun/

flashpca --bfile ${baseDIR}Merge_cohorts/cohorts_merged --project --inmeansd ${baseDIR}PCA_run/meansd.txt \
   --outproj ${baseDIR}PCA_run/projections.txt --inload ${baseDIR}PCA_run/loadings.txt -v
