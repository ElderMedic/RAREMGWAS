#!/bin/bash
#SBATCH --partition=all,highmem
#SBATCH -J countMAF
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

module add gwas/plink/1.90p

#plink --bfile /exports/reum/CKe/Tacera/Final_imputed/TACERA_HRCv1_1_FINAL --freq --out /exports/reum/CKe/Tacera/Final_imputed/MAF_Tacera
#plink --bfile /exports/reum/CKe/ACPA/mergedChr/ACPAneg_merged --freq --out /exports/reum/CKe/ACPA/mergedChr/MAF_ACPA
plink --bfile /exports/reum/CKe/EARTH_A/mergedChr/EA127genotypes_merged --freq --out /exports/reum/CKe/EARTH_A/mergedChr/MAF_EARTH_A
plink --bfile /exports/reum/CKe/EARTH_B/mergedChr/EARTH_setB_merged --freq --out /exports/reum/CKe/EARTH_B/mergedChr/MAF_EARTH_B
plink --bfile /exports/reum/CKe/Madrid/mergedChr/madrid_merged --freq --out /exports/reum/CKe/Madrid/mergedChr/MAF_madrid
plink --bfile /exports/reum/CKe/SERA/mergedChr/sera_merged --freq --out /exports/reum/CKe/SERA/mergedChr/MAF_sera

array_cohorts=("EARTH_setB" "EA127genotypes" "madrid" "RAMS" "vienna" "EAC" "sera" "EIRA" "PEAC") 

#for cohort in ${array_cohorts[@]}
#do
#    plink --bfile /exports/reum/CKe/${cohort}/mergedChr/${cohort}_merged --freq --out /exports/reum/CKe/${cohort}/mergedChr/MAF_${cohort}
#done