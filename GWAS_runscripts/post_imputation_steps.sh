#Call this file with 2 variables, $1 is the file names without the .ped/.map, and $2 is the (full) path to the 
#directory location.
name=$1
DIRECTORY=$2

cd $DIRECTORY
mkdir -p PostImpCleaned

for CHR in {1..22}
do
  echo ""
  printf "Working on $CHR"
  echo ""
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