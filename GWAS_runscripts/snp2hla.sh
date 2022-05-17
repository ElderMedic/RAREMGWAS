#call met bv:   bash snp2hla.sh madrid_sorted_noQC /exports/reum/knevel_lab/Madrid/genetic/ /exports/reum/knevel_lab/Madrid/genetic/SNP2HLA_newest_ref/


module load genomics/ngs/samtools/1.10/gcc-8.3.1
module load gwas/plink/1.90p

NAME=$1
DIRECTORY=$2
outputdir=$3

printf "Running SNP2HLA:\n\n"

inputVCF=${DIRECTORY}strandCORR/${NAME}_cleaned-updated-chr6.vcf.gz
homeDir=${DIRECTORY}SNP2HLA
snp2hla=/exports/reum/knevel_lab/Scripts_Samantha/SNP2HLA/SNP2HLA/

cp $inputVCF $snp2hla
cd $snp2hla

bgzip -d "${NAME}_cleaned-updated-chr6.vcf.gz"
plink --vcf ${NAME}_cleaned-updated-chr6.vcf --const-fid 0 --out ${NAME}_chr6

./SNP2HLA.csh ${NAME}_chr6 /exports/reum/knevel_lab/Scripts_Samantha/SNP2HLA/SNP2HLA_package_v1.0.3/T1DGC/T1DGC_REF ${NAME}_IMPUTED ./plink 7000

mv ${NAME}_* $outputdir 

printf "\n\n Workflow pre-imputation finished for $NAME"
  
  
  
