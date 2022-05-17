#!/bin/bash
#SBATCH -J run_vcf_to_plink2
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH -N6
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=8096MB
#SBATCH --time=48:00:00 

#THE ORIGINAL SCRIPT IS FROM SAMANTHA'S WORK /exports/reum/knevel_lab/Scripts_Samantha/GWAS_runscripts/Runscript_post-imputation.sh and also with Mingdong's modification

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load genomics/ngs/vcftools/0.1.16/gcc-8.3.1
cd /exports/reum/CKe/dosage/
basePath=/exports/reum/knevel_lab/

bash vcf_to_plink2.sh ACPAneg ${basePath}ACPA-/genetic/imputed/
#bash vcf_to_plink2.sh EA127genotypes ${basePath}EARTH/SetA/genetic/imputed/
#bash vcf_to_plink2.sh EARTH_setB ${basePath}EARTH/SetB/genetic/imputed/
#bash vcf_to_plink2.sh madrid ${basePath}Madrid/genetic/imputed/
#bash vcf_to_plink2.sh RAMS ${basePath}RAMS/genetic/imputed/
#bash vcf_to_plink2.sh sera ${basePath}SERA/genetic/imputed/
#bash vcf_to_plink2.sh vienna ${basePath}Vienna/genetic/imputed/
#bash vcf_to_plink2.sh EAC ${basePath}EAC_GSA/genetic/imputed/
#bash vcf_to_plink2.sh PEAC /exports/reum/knevel_lab/PEAC/genetic/imputed/
bash vcf_to_plink2.sh EIRA ${basePath}EIRA/genetic/imputed/ 