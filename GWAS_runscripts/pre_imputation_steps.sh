

#Call this file with 2 variables, $1 is the file names without the .ped/.map, and $2 is the (full) path to the 
#directory location.
NAME=$1
DIRECTORY=$2

printf "Working at $NAME in $DIRECTORY\n"
cd $DIRECTORY
mkdir cleaned
mkdir strandCORR
mkdir imputed

printf "\nWorking in directory $DIRECTORY\nQC steps starting\n\n"

plink  --bfile raw/${NAME} \
  --mind 0.02 \
  --maf 0.01 \
  --hwe 0.0001 \
  --geno 0.02 \
  --recode \
  --out cleaned/${NAME}_cleaned 

plink --file cleaned/${NAME}_cleaned \
  --freq \
  --out cleaned/${NAME}_cleaned


printf "Continueing with strand correction\n"

cd ${DIRECTORY}/strandCORR
cp ${DIRECTORY}/cleaned/${NAME}_cleaned* .
plink --file ${NAME}_cleaned --make-bed --out ${NAME}_cleaned
plink --bfile ${NAME}_cleaned \
--freq \
--out ${NAME}_cleaned

perl /exports/reum/knevel_lab/HRC-1000G-check-bim/HRC-1000G-check-bim-NoReadKey.pl -b ${NAME}_cleaned.bim -f ${NAME}_cleaned.frq -r /exports/reum/knevel_lab/HRC-1000G-check-bim/HRC.r1-1.GRCh37.wgs.mac5.sites.tab -h

sh Run-plink.sh
rm *23*
rm *.bim
rm *.bed
rm *.fam
rm *.nosex
rm *.log

parallel bgzip {} ::: *.vcf 



  
  
  
  

