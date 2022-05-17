#directory location.
name=$1
DIRECTORY=$2


cd ${DIRECTORY}
mkdir mergedChr_CKe

for i in {1..22}
do
  echo ${name}chr$i.pgen ${name}chr$i.pvar ${name}chr$i.psam >> mergelist.txt
done

/exports/reum/plink2 --pmerge-list mergelist.txt pfile --out ${name}merged

mv ${name}merged* mergedChr_CKe/