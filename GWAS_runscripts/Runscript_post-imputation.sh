#!/bin/bash
#SBATCH -J PostImputation_QC
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl
#SBATCH --ntasks=10
#SBATCH --mem-per-cpu=4048MB
#SBATCH --time=48:00:00 


#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load genomics/ngs/vcftools/0.1.16/gcc-8.3.1
module load gwas/plink/1.90p 

basePath=/exports/reum/knevel_lab/

bash post_imputation_steps.sh ACPAneg ${basePath}ACPA-/genetic/imputed/
#bash post_imputation_steps.sh EA127genotypes ${basePath}EARTH/SetA/genetic/
#bash post_imputation_steps.sh EARTH_setB ${basePath}EARTH/SetB/genetic/
#bash post_imputation_steps.sh madrid ${basePath}Madrid/genetic/
#bash post_imputation_steps.sh princesa ${basePath}Princesa/genetic/
#bash post_imputation_steps.sh RAMS ${basePath}RAMS/genetic/
#bash post_imputation_steps.sh sera ${basePath}SERA/genetic/
#bash post_imputation_steps.sh vienna ${basePath}Vienna/genetic/
#bash post_imputation_steps.sh EAC ${basePath}EAC_GSA/genetic/

## special EIRA set run in EIRA_post_imputation
#bash EIRA_post_imputation/post_imp_1_tm_3.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_4_tm_6.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_7_tm_9.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_10_tm_12.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_13_tm_15.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_16_tm_18.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_19_tm_22.sh EIRA ${basePath}EIRA/genetic/imputed



#bash post_imputation_steps.sh PEAC /exports/reum/knevel_lab/PEAC/genetic/imputed


