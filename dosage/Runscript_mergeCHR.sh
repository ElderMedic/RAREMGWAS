#!/bin/sh

#SBATCH -J merge_Chromosomes
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=4048MB
#SBATCH --time=48:00:00 

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
#module load gwas/plink/2.00a3LM
basePath=/exports/reum/knevel_lab/


#bash merge_CHR.sh ACPAneg_ ${basePath}ACPA-/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh EA127genotypes_ ${basePath}EARTH/SetA/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh EARTH_setB_ ${basePath}EARTH/SetB/genetic/imputed/PostImpCleaned_CKe
bash merge_CHR.sh madrid_ ${basePath}Madrid/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh RAMS_ ${basePath}RAMS/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh sera_ ${basePath}SERA/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh vienna_ ${basePath}Vienna/genetic/imputed/PostImpCleaned_CKe
#bash merge_CHR.sh EAC_ ${basePath}EAC_GSA/genetic/imputed/PostImpCleaned_CKe

#bash merge_CHR.sh EIRA_ ${basePath}EIRA/genetic/imputed/PostImpCleaned_CKe 
#bash merge_CHR.sh PEAC_ ${basePath}PEAC/genetic/imputed/PostImpCleaned_CKe
