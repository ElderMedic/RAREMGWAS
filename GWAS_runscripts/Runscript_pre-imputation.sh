#!/bin/sh

#SBATCH -J pre-imputation-steps
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=10000MB
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl
#SBATCH --time=100:00:00 

module load gwas/plink/1.90p 
module load genomics/ngs/samtools/1.10/gcc-8.3.1


#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load genomics/ngs/samtools/1.10/gcc-8.3.1
module load gwas/plink/1.90p 

basePath=/exports/reum/knevel_lab/

bash pre_imputation_steps.sh ACPAneg_37 ${basePath}ACPA-/genetic/
#bash pre_imputation_steps.sh EA127genotypes ${basePath}EARTH/SetA/genetic/
#bash pre_imputation_steps.sh EARTH_sorted_noQC ${basePath}EARTH/SetB/genetic/
#bash pre_imputation_steps.sh madrid_sorted_noQC ${basePath}Madrid/genetic/
#bash pre_imputation_steps.sh princesa_sorted_noQC ${basePath}Princesa/genetic/
#bash pre_imputation_steps.sh RAMS_GSA2018 ${basePath}RAMS/genetic/
#bash pre_imputation_steps.sh sera_sorted_noQC ${basePath}SERA/genetic/
#bash pre_imputation_steps.sh vienna_sorted_noQC ${basePath}Vienna/genetic/
#bash pre_imputation_steps.sh EAC_sorted_noQC ${basePath}EAC_GSA/genetic/
#bash pre_imputation_steps.sh PEAC_SOW43_GSA_Plink ${basePath}Queen_mary/genetic/
#bash pre_imputation_steps.sh SEkiMTX_37 ${basePath}EIRA/genetic/









