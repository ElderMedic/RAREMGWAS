name=$1
DIRECTORY=$2

cd $DIRECTORY
#mkdir -p PostImpCleaned_CKe

#for CHR in {1..22}
#do
#  echo ""
#  printf "Working on $CHR"
#  echo ""
  # Write a list of variants with R^2 metric < 0.3
#  zcat chr${CHR}.info.gz | awk '$7 < 0.3' | cut -f 1 > PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt

  # Call VCFtools to exclude those variants by name
#  vcftools --gzvcf chr${CHR}.dose.vcf.gz \
#  --exclude PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt \
#  --recode \
#  --out PostImpCleaned_CKe/${name}_chr${CHR}_clean
  
#  rm PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt
  
#done

cd $DIRECTORY/PostImpCleaned_CKe

for i in {1..22}
do
  echo ${name}_chr${i}_clean.recode.vcf >> mergelist.txt
done

/exports/reum/knevel_lab/bcftool/bin/bcftools concat -f mergelist.txt -Oz -o ${name}.vcf.gz