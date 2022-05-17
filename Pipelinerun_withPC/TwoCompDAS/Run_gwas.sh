#!/bin/sh

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_sDAI_cDAI
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=8096MB


###########
#  Same setup, top 100 snp of previous study, alt outcomes
###########

module load gwas/plink/1.90p
out_dir=/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/

# sDAI
path_dir=/exports/reum/CKe/Pipelinerun_withPC/Tacera/Final_imputed/

plink --bfile ${path_dir}TACERA_HRCv1_1_FINAL --keep "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Tacera_merged_sDAI.fam" --fam "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Tacera_merged_sDAI.fam" --exclude ${path_dir}TACERA_HRCv1_1_FINAL_dupsExclude.txt --extract "/exports/reum/CKe/Pipelinerun_withPC/MTXsubset/plinkmeta_top100_4ksup_chrbp.txt" --reference-allele ${path_dir}TACERA_HRCv1_1_FINAL_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}tacera_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_TACERA_noMAFfilter_sDAI

awk '!/'NA'/' ${out_dir}gwas_TACERA_noMAFfilter_sDAI.assoc.logistic > ${path_dir}Tacera_noNA_noMAFfilter_sDAI.assoc.logistic


path_dir=/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/

plink --bfile ${path_dir}madrid_merged --keep "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Madrid_merged_sDAI.fam" --fam "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Madrid_merged_sDAI.fam" --exclude ${path_dir}madrid_merged_dupsExclude.txt --extract "/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/Madrid_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}madrid_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Madrid_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_madrid_flipped_noMAFfilter_sDAI

awk '!/'NA'/' ${out_dir}gwas_madrid_flipped_noMAFfilter_sDAI.assoc.logistic > ${path_dir}Madrid_noNA_noMAFfilter_sDAI.assoc.logistic


path_dir=/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/

plink --bfile ${path_dir}vienna_merged --keep "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Vienna_merged_sDAI.fam" --fam "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Vienna_merged_sDAI.fam" --exclude ${path_dir}vienna_merged_dupsExclude.txt --extract "/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/Vienna_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}vienna_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Vienna_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_Vienna_flipped_noMAFfilter_sDAI


awk '!/'NA'/' ${out_dir}gwas_Vienna_flipped_noMAFfilter_sDAI.assoc.logistic > ${path_dir}Vienna_noNA_noMAFfilter_sDAI.assoc.logistic


# cDAI
path_dir=/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/

plink --bfile ${path_dir}madrid_merged --keep "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Madrid_merged_cDAI.fam" --fam "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Madrid_merged_cDAI.fam" --exclude ${path_dir}madrid_merged_dupsExclude.txt --extract "/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/Madrid_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}madrid_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Madrid_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_madrid_flipped_noMAFfilter_cDAI

awk '!/'NA'/' ${out_dir}gwas_madrid_flipped_noMAFfilter_cDAI.assoc.logistic > ${path_dir}Madrid_noNA_noMAFfilter_cDAI.assoc.logistic


path_dir=/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/

plink --bfile ${path_dir}vienna_merged --keep "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Vienna_merged_cDAI.fam" --fam "/exports/reum/CKe/Pipelinerun_withPC/TwoCompDAS/Vienna_merged_cDAI.fam" --exclude ${path_dir}vienna_merged_dupsExclude.txt --extract "/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/Vienna_top100_4ksup_chrbpa1.txt" --reference-allele ${path_dir}vienna_merged_AllelesCorr.txt --biallelic-only strict list --logistic --hide-covar --allow-no-sex --covar ${path_dir}Vienna_re_pc.covar --ci 0.95 --freq --out ${out_dir}gwas_Vienna_flipped_noMAFfilter_cDAI


awk '!/'NA'/' ${out_dir}gwas_Vienna_flipped_noMAFfilter_cDAI.assoc.logistic > ${path_dir}Vienna_noNA_noMAFfilter_cDAI.assoc.logistic