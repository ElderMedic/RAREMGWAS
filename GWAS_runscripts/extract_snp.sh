
plink --bfile madrid_merged --extract snplist.txt --make-bed --out madrid_snp


mkdir snp_pca
mv madrid_snp* snp_pca/
mv snp_pca/ ../../../