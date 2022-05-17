#!/bin/bash
#SBATCH -J Pvcf_postimpu_merge
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --ntasks=10
#SBATCJ -N4
#SBATCH --mem-per-cpu=4048MB
#SBATCH --time=48:00:00 

module load genomics/ngs/vcftools/0.1.16/gcc-8.3.1

basePath=/exports/reum/knevel_lab/

#bash vcf_postimpu_merge.sh ACPAneg ${basePath}ACPA-/genetic/imputed/
#bash vcf_postimpu_merge.sh EA127genotypes ${basePath}EARTH/SetA/genetic/imputed/
#bash vcf_postimpu_merge.sh EARTH_setB ${basePath}EARTH/SetB/genetic/imputed/
#bash vcf_postimpu_merge.sh madrid ${basePath}Madrid/genetic/imputed/
#bash vcf_postimpu_merge.sh RAMS ${basePath}RAMS/genetic/imputed/
#bash vcf_postimpu_merge.sh sera ${basePath}SERA/genetic/imputed/
#bash vcf_postimpu_merge.sh vienna ${basePath}Vienna/genetic/imputed/
#bash vcf_postimpu_merge.sh EAC ${basePath}EAC_GSA/genetic/imputed/
#bash vcf_postimpu_merge.sh PEAC /exports/reum/knevel_lab/PEAC/genetic/imputed
bash vcf_postimpu_merge.sh EIRA ${basePath}EIRA/genetic/imputed