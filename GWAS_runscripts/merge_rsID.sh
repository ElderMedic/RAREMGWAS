#directory location.
name=$1
DIRECTORY=$2


cd ${DIRECTORY}
mkdir mergedChr

for i in {1..22}
do
  echo ${name}chr${i}_rsids.bed ${name}chr${i}_rsids.bim ${name}chr${i}_rsids.fam >> mergelist.txt
done

plink --merge-list mergelist.txt --make-bed --out ${name}merged_rsID --allow-no-sex

mv ${name}merged* mergedChr/