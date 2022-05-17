#!/bin/sh

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_TACERA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB


###########
#  Script run with the input data settings:
#  - Imputated data used for all cohorts (was fully complete)
#  - NO LD PRUNING 
#  - Remission yes/no of 6 months
#  - made by: Samantha Jurado Zapata, modified: Changlin Ke

#  - Update: all binary plink files are from Marc's earliest ver in Final_imputed with snpid and fam remission updated.
###########

module load gwas/plink/1.90p

path_dir=/exports/reum/CKe/Tacera/Final_imputed/

plink --bfile ${path_dir}TACERA_HRCv1_1_FINAL --biallelic-only strict list --logistic --maf 0.01 --hide-covar --allow-no-sex --covar ${path_dir}tacera_pc.covar --ci 0.95 --out ${path_dir}gwas_TACERA_maf

#run with plink2 and add allele freq count
#/exports/reum/plink2 --bfile ${path_dir}TACERA_HRCv1_1_FINAL --logistic --covar ${path_dir}tacera.covar --ci 0.95 --out gwas_TACERA_plink2 --freq

awk '!/'NA'/' ${path_dir}gwas_TACERA_maf.assoc.logistic > ${path_dir}noNA.assoc.logistic




