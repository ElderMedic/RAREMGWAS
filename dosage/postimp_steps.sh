#THE ORIGINAL SCRIPT IS FROM SAMANTHA'S WORK /exports/reum/knevel_lab/Scripts_Samantha/GWAS_runscripts/post-imputation_steps.sh and also with Mingdong's modification
#Call this file with 2 variables, $1 is the file names without the .ped/.map, and $2 is the (full) path to the 
#directory location.
name=$1
DIRECTORY=$2

cd $DIRECTORY
mkdir -p PostImpCleaned_CKe

for CHR in {1..22}
do
  echo ""
  printf "Working on $CHR"
  echo ""
  # Write a list of variants with R^2 metric < 0.3
  zcat chr${CHR}.info.gz | awk '$7 < 0.3' | cut -f 1 > PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt

  # Call VCFtools to exclude those variants by name
  vcftools --gzvcf chr${CHR}.dose.vcf.gz \
  --exclude PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt \
  --recode \
  --out PostImpCleaned_CKe/${name}_chr${CHR}_clean

done