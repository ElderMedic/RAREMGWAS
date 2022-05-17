
name=$1
DIRECTORY=$2

cd $DIRECTORY
mkdir -p PostImpCleaned_CKe

for CHR in {1..22}
do
  echo ""
  printf "Working on $CHR"
  echo ""
  /exports/reum/plink2 --vcf PostImpCleaned_CKe/${name}_chr${CHR}_clean.recode.vcf.gz dosage=HDS\
    --double-id \
    --max-alleles 2 \
    --out PostImpCleaned_CKe/${name}_chr${CHR} \
    --make-pgen \
    --exclude PostImpCleaned_CKe/${name}_chr${CHR}_ExcludePositions.txt
    
done