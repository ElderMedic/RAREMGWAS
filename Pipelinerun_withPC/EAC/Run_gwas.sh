#!/bin/sh

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_eac_1
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
#  - modified: Changlin Ke
###########

module load gwas/plink/1.90p

path_dir=/exports/reum/CKe/Pipelinerun_withPC/EAC/mergedChr/

plink --bfile ${path_dir}EAC_merged --exclude ${path_dir}EAC_merged_dupsExclude.txt --make-bed --out ${path_dir}EAC_merged_noDup

#plink --bfile ${path_dir}EAC_merged_noDup --reference-allele ${path_dir}EAC_merged_AllelesCorr.txt --biallelic-only strict list --maf 0.01 --logistic --hide-covar --allow-no-sex --covar ${path_dir}EAC_re_pc.covar --ci 0.95 --freq --out ${path_dir}gwas_EAC_flipped_maf

plink --bfile ${path_dir}EAC_merged_noDup --reference-allele ${path_dir}EAC_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}EAC_re_pc.covar --ci 0.95 --freq --out ${path_dir}gwas_EAC_flipped_noMAFfilter

awk '!/'NA'/' ${path_dir}gwas_EAC_flipped_noMAFfilter.assoc.logistic > ${path_dir}noNA_noMAFfilter.assoc.logistic

#awk '!/'NA'/' ${path_dir}gwas_EAC_flipped_maf.assoc.logistic > ${path_dir}noNA.assoc.logistic





