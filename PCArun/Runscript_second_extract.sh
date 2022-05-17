#!/bin/sh

#SBATCH -J second_compare_extract
#SBATCH --ntasks=6
#SBATCH --mem=100000MB
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=100:00:00 

# First step after getting the common variants from find_overlap_snps.py with snplist.txt
## Name dictionary, input and output

## example:  bash extract_file.sh 
                # input_name 
                # directory_name 
                # input_dir 
                # output_name 
                # snplist_location

# Load dependencies
module load gwas/plink/1.90p  


# create new directory for the new command
mkdir common_variant_extract_V2
cd common_variant_extract_V2

bash /exports/reum/CKe/PCArun/common_extract.sh \
  PEAC_extracted \
  PEAC_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/PEAC_extract/ \
  PEAC_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  G1000_extracted \
  G1000_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/G1000_extract/ \
   G1000_extracted2 \
   /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
   
bash /exports/reum/CKe/PCArun/common_extract.sh \
 vienna_extracted \
  Vienna_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/Vienna_extract/ \
  vienna_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  SERA_extracted \
  SERA_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/SERA_extract/ \
  SERA_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  RAMS_extracted \
  RAMS_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/RAMS_extract/ \
  RAMS_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  Madrid_extracted \
  Madrid_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/Madrid_extract/ \
  Madrid_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EARTH_B_extracted \
  EARTH_B_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/EARTH_B_extract/ \
  EARTH_B_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EAC_extracted \
  EAC_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/EAC_extract/ \
  EAC_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt

  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EARTH_A_extracted \
  EARTH_A_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/EARTH_A_extract/ \
  EARTH_A_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt   
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  ACPA_neg_extracted \
  ACPA_neg_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/ACPA_neg_extract/ \
  ACPA_neg_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EIRA_extracted \
  EIRA_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/EIRA_extract/ \
  EIRA_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
# source data of Tacera cohort is in different location
bash /exports/reum/CKe/PCArun/common_extract.sh \
  Tacera_extracted \
  Tacera_extract \
  /exports/reum/CKe/PCArun/common_variant_extract_V1/Tacera_extract/ \
  Tacera_extracted2 \
  /exports/reum/CKe/PCArun/Reference_LD_done/snplist_ref_pruned.txt
  
  















