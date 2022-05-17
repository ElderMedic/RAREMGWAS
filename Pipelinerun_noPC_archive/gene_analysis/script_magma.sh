#!/bin/bash
#
#SBATCH -J MAGMA
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH -N8
#SBATCH --ntasks-per-node=2
#SBATCH --time=8:0:0
#SBATCH --partition=all,highmem

OutputName=EAC

##step 1 annotate window size=35kb up, 10kb down
/exports/reum/CKe/gene_analysis/magma --annotate window=35,10 --snp-loc /exports/reum/CKe/EAC/mergedChr/EAC_merged.bim --gene-loc NCBI37.3.gene.loc --out ${OutputName}

##step 2 
/exports/reum/CKe/gene_analysis/magma --bfile /exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Version8/All_cohorts_merged/cohorts_merged --gene-annot ${OutputName}.genes.annot --gene-model multi=all --out ${OutputName} --covar file=/exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Version8/All_cohorts_merged/all_covar.covar
#to include pca --covar file=[path]
#pca file for dosage"/exports/reum/mliu/gene_analysis/backup_data_v5/covar_magama.covar"
#to include snp synonyms add synonyms="/exports/reum/mliu/gene_analysis/dbsnp151.synonyms" after --bifle

##step 3 gene set analysis
# the gmt file in same path contains gene sets
/exports/reum/CKe/gene_analysis/magma --gene-results ${OutputName}.genes.raw --set-annot c2cp_c3all_c5go_c7immu_v7.4.entrez.gmt --out $OutputName