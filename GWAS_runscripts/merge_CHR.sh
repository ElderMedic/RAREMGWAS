#directory location.
name=$1
DIRECTORY=$2


cd ${DIRECTORY}
mkdir mergedChr

for i in {1..22}
do
  echo ${name}chr$i.bed ${name}chr$i.bim ${name}chr$i.fam >> mergelist.txt
done

plink --merge-list mergelist.txt --make-bed --out ${name}merged --allow-no-sex --biallelic-only strict list

mv ${name}merged* mergedChr/