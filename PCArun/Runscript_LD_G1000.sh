#!/bin/sh

#SBATCH -J LD_pruning_reference
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=1000MB
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 

# LD pruning of the reference (G1000)

# Load dependencies
module load gwas/plink/1.90p  

mkdir Reference_LD_done
cd Reference_LD_done

input=/exports/reum/CKe/PCArun/common_variant_extract_V1/G1000_extract/
output=/exports/reum/CKe/PCArun/Reference_LD_done/

plink \
  --bfile ${input}G1000_extracted \
  --indep-pairwise 1500 150 0.7 \
  --out ${output}G1000_extracted_pruned

plink \
  --bfile ${input}G1000_extracted \
  --extract ${output}G1000_extracted_pruned.prune.in \
  --make-bed \
  --out ${output}G1000_extracted_pruned
  
awk '{print $2}' ${output}G1000_extracted_pruned.bim > ${output}snplist_ref_pruned.txt

