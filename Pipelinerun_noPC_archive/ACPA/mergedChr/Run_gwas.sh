#!/bin/sh

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_ACPA_1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB


###########
#  Script run with the input data settings:
#  - Imputated data used for all cohorts except EARTH_B and EIRA (was fully complete)
#  - NO LD PRUNING 
#  - Remission yes/no of 6 months
#  - made by: Samantha Jurado Zapata

#  - Update: .fam file is from SamanthaV8
###########

module load gwas/plink/1.90p

path_dir=/exports/reum/CKe/ACPA/mergedChr/


plink --bfile ${path_dir}ACPAneg_merged_noverlap --biallelic-only strict list --maf 0.01 --logistic --hide-covar --allow-no-sex --covar ${path_dir}ACPA_re_pc.covar --ci 0.95 --out ${path_dir}gwas_ACPA_flipped_maf

awk '!/'NA'/' ${path_dir}gwas_ACPA_flipped_maf.assoc.logistic > ${path_dir}noNA.assoc.logistic






