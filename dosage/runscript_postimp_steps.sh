#!/bin/bash
#SBATCH -J PostImputation_steps
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH -N8
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=8096MB
#SBATCH --time=48:00:00 

#THE ORIGINAL SCRIPT IS FROM SAMANTHA'S WORK /exports/reum/knevel_lab/Scripts_Samantha/GWAS_runscripts/Runscript_post-imputation.sh and also with Mingdong's modification

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load genomics/ngs/vcftools/0.1.16/gcc-8.3.1
cd /exports/reum/CKe/dosage/
basePath=/exports/reum/knevel_lab/

bash postimp_steps.sh ACPAneg ${basePath}ACPA-/genetic/imputed/
#bash postimp_steps.sh EA127genotypes ${basePath}EARTH/SetA/genetic/imputed/
#bash postimp_steps.sh EARTH_setB ${basePath}EARTH/SetB/genetic/imputed/
#bash postimp_steps.sh madrid ${basePath}Madrid/genetic/imputed/
#bash postimp_steps.sh RAMS ${basePath}RAMS/genetic/imputed/
#bash postimp_steps.sh sera ${basePath}SERA/genetic/imputed/
#bash postimp_steps.sh vienna ${basePath}Vienna/genetic/imputed/
#bash postimp_steps.sh EAC ${basePath}EAC_GSA/genetic/imputed/
#bash postimp_steps.sh PEAC /exports/reum/knevel_lab/PEAC/genetic/imputed/
#bash postimp_steps.sh EIRA ${basePath}EIRA/genetic/imputed/ 

## special EIRA set run in EIRA_post_imputation
#bash EIRA_post_imputation/post_imp_1_to_3.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_4_to_6.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_7_to_9.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_10_to_12.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_13_to_15.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_16_to_18.sh EIRA ${basePath}EIRA/genetic/imputed
#bash EIRA_post_imputation/post_imp_19_to_22.sh EIRA ${basePath}EIRA/genetic/imputed




