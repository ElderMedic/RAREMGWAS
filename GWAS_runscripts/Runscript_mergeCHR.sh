#!/bin/sh

#SBATCH -J merge_Chromosomes
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=4048MB
#SBATCH --time=48:00:00 

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load gwas/plink/1.90p 
basePath=/exports/reum/knevel_lab/


bash merge_CHR.sh ACPAneg_ ${basePath}ACPA-/genetic/PostImpCleaned
#bash merge_CHR.sh EA127genotypes_ ${basePath}EARTH/SetA/genetic/PostImpCleaned
#bash merge_CHR.sh EARTH_setB_ ${basePath}EARTH/SetB/genetic/PostImpCleaned
#bash merge_CHR.sh madrid_ ${basePath}Madrid/genetic/PostImpCleaned
#bash merge_CHR.sh princesa_ ${basePath}Princesa/genetic/PostImpCleaned
#bash merge_CHR.sh RAMS_ ${basePath}RAMS/genetic/PostImpCleaned
#bash merge_CHR.sh sera_ ${basePath}SERA/genetic/PostImpCleaned
#bash merge_CHR.sh vienna_ ${basePath}Vienna/genetic/PostImpCleaned
#bash merge_CHR.sh EAC_ ${basePath}EAC_GSA/genetic/PostImpCleaned
#bash merge_CHR.sh EAC_ ${basePath}EAC_GSA/genetic/Alternative_imputation/PostImpCleaned/

bash merge_CHR.sh EIRA_ ${basePath}EIRA/genetic/PostImpCleaned


## RSID version
#bash merge_rsID.sh madrid_ ${basePath}Madrid/genetic/PostImpCleaned/version_with_rsID/
