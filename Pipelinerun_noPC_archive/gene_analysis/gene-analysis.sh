#!/bin/bash
#
#SBATCH -J MAGMA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --mem=100G
#SBATCH --ntasks-per-node=4
#SBATCH --time=8:0:0
#SBATCH --partition=all,highmem

##step 1 annotate window size=35kb up, 10kb down
#/exports/reum/CKe/gene_analysis/magma --annotate window=35,10 --snp-loc "/exports/reum/CKe/gene_analysis/Metal_snploc_samplesize.txt" --gene-loc NCBI37.3.gene.loc --out Meta

##step 2 gene-analysis
#/exports/reum/CKe/gene_analysis/magma --bfile /exports/reum/CKe/gene_analysis/ref_Samantha_merged --pval "/exports/reum/CKe/gene_analysis/METALresult_filtered_withSamplesize.TBL" ncol=NMISS use=MarkerName,8 --gene-annot "/exports/reum/CKe/gene_analysis/Meta.genes.annot" --gene-model multi --out Meta_gene

/exports/reum/CKe/gene_analysis/magma --bfile /exports/reum/CKe/gene_analysis/g1000_eur/g1000_eur --pval "/exports/reum/CKe/gene_analysis/METALresult_filtered_withSamplesize.TBL" ncol=NMISS use=MarkerName,8 --gene-annot "/exports/reum/CKe/gene_analysis/Meta.genes.annot" --gene-model multi --out Meta_gene_ref1000g
#to include snp synonyms add synonyms="/exports/reum/mliu/gene_analysis/dbsnp151.synonyms" after --bifle

##step 3 gene-set analysis
/exports/reum/CKe/gene_analysis/magma --gene-results Meta_gene_ref1000g.genes.raw --set-annot "/exports/reum/CKe/gene_analysis/msigdb.v7.4.entrez.gmt" --out Meta_allMsigdb_ref1000g

/exports/reum/CKe/gene_analysis/magma --gene-results Meta_gene_ref1000g.genes.raw --set-annot "/exports/reum/CKe/gene_analysis/c2cp_c3all_c5go_c7immu_v7.4.entrez.gmt" --out Meta_ref1000g