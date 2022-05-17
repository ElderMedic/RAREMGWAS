#!/bin/bash
#SBATCH -J PostImputation_QC
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=S.Jurado_Zapata@lumc.nl
#SBATCH --ntasks=3
#SBATCH --mem-per-cpu=4048MB
#SBATCH --time=48:00:00 


#LOAD DEPENDENCIES ON SERVER IN ENVIRONMENT
module add genomics/ngs/vcftools/0.1.16/gcc-8.3.1
module load gwas/plink/1.90p 

basePath=/exports/reum/knevel_lab/

#Call this file with 2 variables, $1 is the file names without the .ped/.map, and $2 is the (full) path to the 
#directory location.
name=EIRA
DIRECTORY=${basePath}EIRA/genetic/imputed

cd $DIRECTORY

for CHR in {13..15}
do
  printf "working on $CHR"
  # Write a list of variants with R^2 metric < 0.3
  zcat chr${CHR}.info.gz | awk '$7 < 0.3' | cut -f 1 > PostImpCleaned/${name}_chr${CHR}_ExcludePositions.txt

  # Call VCFtools to exclude those variants by name
  vcftools --gzvcf chr${CHR}.dose.vcf.gz \
  --exclude PostImpCleaned/${name}_chr${CHR}_ExcludePositions.txt \
  --recode \
  --out PostImpCleaned/${name}_chr${CHR}_clean
  
  # Filter out multiallelic variants, set to missing calls with <80% posterior probability, then make plink binary file
  plink  --vcf PostImpCleaned/${name}_chr${CHR}_clean.recode.vcf \
    --double-id \
    --biallelic-only strict list \
    --vcf-min-gp 0.8 \
    --exclude PostImpCleaned/${name}_chr${CHR}_ExcludePositions.txt \
    --make-bed \
    --out PostImpCleaned/${name}_chr${CHR}

  rm PostImpCleaned/${name}_chr${CHR}.INFO PostImpCleaned/${name}_chr${CHR}_ExcludePositions.txt PostImpCleaned/${name}_chr${CHR}_clean.recode.vcf

done