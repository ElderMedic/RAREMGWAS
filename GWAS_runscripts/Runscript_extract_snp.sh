#!/bin/bash
#SBATCH -J PostImputation_QC
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load gwas/plink/1.90p 

basePath=/exports/reum/knevel_lab/


#bash extract_snp.sh ACPAneg ${basePath}ACPA-/genetic/
#bash extract_snp.sh EA127genotypes ${basePath}EARTH/SetA/genetic/
#bash extract_snp.sh EARTH_setB ${basePath}EARTH/SetB/genetic/
#bash extract_snp.sh madrid ${basePath}Madrid/genetic/
#bash extract_snp.sh princesa ${basePath}Princesa/genetic/
#bash extract_snp.sh RAMS ${basePath}RAMS/genetic/
#bash extract_snp.sh sera ${basePath}SERA/genetic/
bash extract_snp.sh vienna ${basePath}Vienna/genetic/
#bash extract_snp.sh EAC ${basePath}EAC_GSA/genetic/
