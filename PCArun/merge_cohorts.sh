#!/bin/sh

#SBATCH --partition=all
#SBATCH -J Merge_cohorts
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=10000MB
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=10:0:0

# Load dependencies
module load gwas/plink/1.90p  

baseDIR=/exports/reum/CKe/PCArun/common_variant_extract_V2/

#exclude strand inconsistent alleles found in last run
plink --bfile ${baseDIR}Madrid_extract/Madrid_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}Madrid_extract/Madrid_extracted2_tmp
plink --bfile ${baseDIR}EARTH_A_extract/EARTH_A_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}EARTH_A_extract/EARTH_A_extracted2_tmp
plink --bfile ${baseDIR}Vienna_extract/vienna_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}Vienna_extract/vienna_extracted2_tmp
plink --bfile ${baseDIR}SERA_extract/SERA_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}SERA_extract/SERA_extracted2_tmp
plink --bfile ${baseDIR}EAC_extract/EAC_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}EAC_extract/EAC_extracted2_tmp
plink --bfile ${baseDIR}RAMS_extract/RAMS_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}RAMS_extract/RAMS_extracted2_tmp
plink --bfile ${baseDIR}EARTH_B_extract/EARTH_B_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}EARTH_B_extract/EARTH_B_extracted2_tmp
plink --bfile ${baseDIR}ACPA_neg_extract/ACPA_neg_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}ACPA_neg_extract/ACPA_neg_extracted2_tmp
plink --bfile ${baseDIR}PEAC_extract/PEAC_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}PEAC_extract/PEAC_extracted2_tmp
plink --bfile ${baseDIR}EIRA_extract/EIRA_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}EIRA_extract/EIRA_extracted2_tmp
plink --bfile ${baseDIR}Tacera_extract/Tacera_extracted2 --exclude /exports/reum/CKe/PCArun/Merge_cohorts/cohorts_merged-merge.missnp --make-bed --out ${baseDIR}Tacera_extract/Tacera_extracted2_tmp

echo ${baseDIR}Madrid_extract/Madrid_extracted2_tmp.bed ${baseDIR}Madrid_extract/Madrid_extracted2_tmp.bim ${baseDIR}Madrid_extract/Madrid_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}EARTH_A_extract/EARTH_A_extracted2_tmp.bed ${baseDIR}EARTH_A_extract/EARTH_A_extracted2_tmp.bim ${baseDIR}EARTH_A_extract/EARTH_A_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}Vienna_extract/vienna_extracted2_tmp.bed ${baseDIR}Vienna_extract/vienna_extracted2_tmp.bim ${baseDIR}Vienna_extract/vienna_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}SERA_extract/SERA_extracted2_tmp.bed ${baseDIR}SERA_extract/SERA_extracted2_tmp.bim ${baseDIR}SERA_extract/SERA_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}EAC_extract/EAC_extracted2_tmp.bed ${baseDIR}EAC_extract/EAC_extracted2_tmp.bim ${baseDIR}EAC_extract/EAC_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}RAMS_extract/RAMS_extracted2_tmp.bed ${baseDIR}RAMS_extract/RAMS_extracted2_tmp.bim ${baseDIR}RAMS_extract/RAMS_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}EARTH_B_extract/EARTH_B_extracted2_tmp.bed ${baseDIR}EARTH_B_extract/EARTH_B_extracted2_tmp.bim ${baseDIR}EARTH_B_extract/EARTH_B_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}ACPA_neg_extract/ACPA_neg_extracted2_tmp.bed ${baseDIR}ACPA_neg_extract/ACPA_neg_extracted2_tmp.bim ${baseDIR}ACPA_neg_extract/ACPA_neg_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}PEAC_extract/PEAC_extracted2_tmp.bed ${baseDIR}PEAC_extract/PEAC_extracted2_tmp.bim ${baseDIR}PEAC_extract/PEAC_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}EIRA_extract/EIRA_extracted2_tmp.bed ${baseDIR}EIRA_extract/EIRA_extracted2_tmp.bim ${baseDIR}EIRA_extract/EIRA_extracted2_tmp.fam >> mergelist.txt
echo ${baseDIR}Tacera_extract/Tacera_extracted2_tmp.bed ${baseDIR}Tacera_extract/Tacera_extracted2_tmp.bim ${baseDIR}Tacera_extract/Tacera_extracted2_tmp.fam >> mergelist.txt

cd Merge_cohorts

plink --merge-list ../mergelist.txt --make-bed --out cohorts_merged --allow-no-sex 
