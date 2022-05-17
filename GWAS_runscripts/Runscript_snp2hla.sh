#!/bin/sh

#SBATCH -J pre-imputation-steps
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl
#SBATCH --ntasks=12
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=48:00:00 

#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module load genomics/ngs/samtools/1.10/gcc-8.3.1
module load gwas/plink/1.90p

basePath=/exports/reum/knevel_lab/


#bash snp2hla.sh ACPAneg_37 ${basePath}ACPA-/genetic/ /exports/reum/knevel_lab/ACPA-/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh EA127genotypes ${basePath}EARTH/SetA/genetic/ /exports/reum/knevel_lab/EARTH/SetA/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh EARTH_sorted_noQC ${basePath}EARTH/SetB/genetic/ /exports/reum/knevel_lab/EARTH/SetB/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh madrid_sorted_noQC ${basePath}Madrid/genetic/ /exports/reum/knevel_lab/Madrid/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh princesa_sorted_noQC ${basePath}Princesa/genetic/ /exports/reum/knevel_lab/Princesa/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh RAMS_GSA2018 ${basePath}RAMS/genetic/ /exports/reum/knevel_lab/RAMS/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh sera_sorted_noQC ${basePath}SERA/genetic/ /exports/reum/knevel_lab/SERA/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh EAC_sorted_noQC ${basePath}EAC_GSA/genetic/ /exports/reum/knevel_lab/EAC_GSA/genetic/SNP2HLA_newest_ref/
#bash snp2hla.sh vienna_sorted_noQC ${basePath}Vienna/genetic/ /exports/reum/knevel_lab/Vienna/genetic/SNP2HLA_newest_ref/

#using special file, the only difference is a snp2hla directory path, since the other one is occupied
bash snp2hla_special.sh SEkiMTX_37 ${basePath}EIRA/genetic/ /exports/reum/knevel_lab/EIRA/genetic/SNP2HLA_newest_ref/

# peac has a different name which has to be changed before it can go into the general script
#cp /exports/reum/knevel_lab/PEAC/genetic/strandCORR/PEAC_SOW43_GSA_Plink_QC_done-updated-chr6.vcf.gz /exports/reum/knevel_lab/PEAC/genetic/strandCORR/PEAC_SOW43_GSA_Plink_QC_done_cleaned-updated-chr6.vcf.gz
#bash snp2hla.sh PEAC_SOW43_GSA_Plink_QC_done ${basePath}PEAC/genetic/ /exports/reum/knevel_lab/PEAC/genetic/SNP2HLA_newest_ref/


