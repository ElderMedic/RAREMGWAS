#!/bin/bash
#
#SBATCH -J MAGMA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --mem=100G
#SBATCH --ntasks-per-node=4
#SBATCH --time=8:0:0
#SBATCH --partition=all,highmem

cd /exports/reum/CKe/gene_analysis/A1corr_withPC_noMAFfilter/
##step 1 annotate window size=35kb up, 10kb down
#/exports/reum/CKe/gene_analysis/magma --annotate window=35,10 --snp-loc "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/PlinkMeta_snploc_samplesize.txt" --gene-loc ../NCBI37.3.gene.loc --out Meta_plink_fixed

##step 2 gene-analysis
#/exports/reum/CKe/gene_analysis/magma --bfile /exports/reum/CKe/gene_analysis/ref_Samantha_merged --pval "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/PlinkMeta_A1corr_noMAFfilter_Allcohorts_withPC_toFUMA.txt" ncol=NMISS use=MarkerName,P --gene-annot Meta_plink_fixed.genes.annot --gene-model multi --out Meta_plink_fixed_gene_refSamantha

#/exports/reum/CKe/gene_analysis/magma --bfile /exports/reum/CKe/gene_analysis/g1000_eur/g1000_eur --pval "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/PlinkMeta_A1corr_noMAFfilter_Allcohorts_withPC_toFUMA.txt" ncol=NMISS use=MarkerName,P --gene-annot Meta_plink_fixed.genes.annot --gene-model multi --out Meta_plink_fixed_gene_ref1000g
#to include snp synonyms add synonyms="/exports/reum/mliu/gene_analysis/dbsnp151.synonyms" after --bifle

##step 3 gene-set analysis
/exports/reum/CKe/gene_analysis/magma --gene-results Meta_plink_fixed_gene_refSamantha.genes.raw --set-annot "/exports/reum/CKe/gene_analysis/msigdb.v7.4.entrez.gmt" --out Meta_plink_fixed_allMsigdb_refSamantha

/exports/reum/CKe/gene_analysis/magma --gene-results Meta_plink_fixed_gene_refSamantha.genes.raw --set-annot "/exports/reum/CKe/gene_analysis/c2cp_c3all_c5go_c7immu_v7.4.entrez.gmt" --out Meta_plink_fixed_refSamantha