#!/bin/sh

#SBATCH -J PCA_reference
#SBATCH --ntasks=3
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=100:00:00 

# Load dependencies
module load gwas/plink/1.90p 
module load bioinformatics/tools/SNP/flashpca/2.1/gcc-8.3.1

#shortcut base directory so the code is more readable
baseDIR=/exports/reum/CKe/PCArun/

flashpca --bfile ${baseDIR}common_variant_extract_V2/G1000_extract/G1000_extracted2 \
  --outload ${baseDIR}PCA_run/loadings.txt \
  --outmeansd ${baseDIR}PCA_run/meansd.txt 
