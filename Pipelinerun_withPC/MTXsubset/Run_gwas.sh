#!/bin/sh

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_MTXsubset
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=8096MB


###########
#  Same setup, top 100 snp of previous study, only on MTX sample subsets
###########

module load gwas/plink/1.90p
out_dir=/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/


path_dir=/exports/reum/CKe/Pipelinerun_withPC/Tacera/Final_imputed/

plink --bfile ${path_dir}TACERA_HRCv1_1_FINAL --exclude ${path_dir}TACERA_HRCv1_1_FINAL_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/Tacera_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/plinkmeta_top100_4ksup_chrbp.txt" --reference-allele ${path_dir}TACERA_HRCv1_1_FINAL_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}tacera_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_TACERA_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_TACERA_noMAFfilter_MTX.assoc.logistic > ${path_dir}Tacera_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/Glasgow/mergedChr/

plink --bfile ${path_dir}Glasgow_merged --exclude ${path_dir}Glasgow_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/Glasgow_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/Glasgow/mergedChr/Glasgow_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}Glasgow_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex -covar ${path_dir}Glasgow_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_Glasgow_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_Glasgow_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}Glasgow_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/SERA/mergedChr/

plink --bfile ${path_dir}sera_merged --exclude ${path_dir}sera_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/SERA_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/SERA/mergedChr/SERA_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}sera_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}SERA_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_SERA_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_SERA_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}SERA_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/

plink --bfile ${path_dir}vienna_merged --exclude ${path_dir}vienna_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/Vienna_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/Vienna_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}vienna_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Vienna_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_Vienna_flipped_noMAFfilter_MTX


awk '!/'NA'/' ${out_dir}gwas_Vienna_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}Vienna_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/RAMS/mergedChr/

plink --bfile ${path_dir}RAMS_merged --exclude ${path_dir}RAMS_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/RAMS_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/RAMS/mergedChr/RAMS_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}RAMS_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}RAMS_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_RAMS_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_RAMS_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}RAMS_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/

plink --bfile ${path_dir}madrid_merged --exclude ${path_dir}madrid_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/Madrid_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/Madrid_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}madrid_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Madrid_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_madrid_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_madrid_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}Madrid_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/EARTH_A/mergedChr/

plink --bfile ${path_dir}EA127genotypes_merged --exclude ${path_dir}EA127genotypes_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/EARTH_setA_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/EARTH_A/mergedChr/EARTH_A_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}EA127genotypes_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}EARTH_A_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_EARTHA_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_EARTHA_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}EARTHA_noNA_noMAFfilter_MTX.assoc.logistic



path_dir=/exports/reum/CKe/Pipelinerun_withPC/EARTH_B/mergedChr/

plink --bfile ${path_dir}EARTH_setB_merged --exclude ${path_dir}EARTH_setB_merged_dupsExclude.txt --keep "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/EARTH_setB_merged_MTX.fam" --extract "/exports/reum/CKe/Pipelinerun_withPC/EARTH_B/mergedChr/EARTH_B_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}EARTH_setB_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}EARTH_B_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_EARTHB_flipped_noMAFfilter_MTX

awk '!/'NA'/' ${out_dir}gwas_EARTHB_flipped_noMAFfilter_MTX.assoc.logistic > ${path_dir}EARTHB_noNA_noMAFfilter_MTX.assoc.logistic

