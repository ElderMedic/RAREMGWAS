#!/bin/sh

#SBATCH -J first_compare_extract
#SBATCH --ntasks=4
#SBATCH --mem=100000
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 

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
mkdir common_variant_extract_V1
cd common_variant_extract_V1

bash /exports/reum/CKe/PCArun/common_extract.sh \
  PEAC_merged \
  PEAC_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/PEAC/ \
  PEAC_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  G1000.chr_merged \
  G1000_extract \
   /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/G1000/ \
   G1000_extracted \
   /exports/reum/CKe/PCArun/snplist.txt
   
bash /exports/reum/CKe/PCArun/common_extract.sh \
  vienna_merged \
  Vienna_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/vienna/ \
  vienna_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  sera_merged \
  SERA_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/sera/ \
  SERA_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  RAMS_merged \
  RAMS_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/RAMS/ \
  RAMS_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  madrid_merged \
  Madrid_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/madrid/ \
  Madrid_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EARTH_setB_merged \
  EARTH_B_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/EARTH_set_B/ \
  EARTH_B_extracted \
  /exports/reum/CKe/PCArun/snplist.txt

  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EA127genotypes_merged \
  EARTH_A_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/EA127/ \
  EARTH_A_extracted \
  /exports/reum/CKe/PCArun/snplist.txt     
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  ACPAneg_merged \
  ACPA_neg_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/ACPA_neg/ \
  ACPA_neg_extracted \
  /exports/reum/CKe/PCArun/snplist.txt 
  
bash /exports/reum/CKe/PCArun/common_extract.sh \
  EIRA_merged \
  EIRA_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/EIRA/ \
  EIRA_extracted \
  /exports/reum/CKe/PCArun/snplist.txt
  

bash /exports/reum/CKe/PCArun/common_extract.sh \
  EAC_merged \
  EAC_extract \
  /exports/reum/knevel_lab/Scripts_Samantha/PCA_files/EAC/ \
  EAC_extracted \
  /exports/reum/CKe/PCArun/snplist.txt

# source data of Tacera cohort is in different location
bash /exports/reum/CKe/PCArun/common_extract.sh \
  TACERA_HRCv1_1_FINAL \
  Tacera_extract \
  /exports/reum/CKe/Tacera/Final_imputed/ \
  Tacera_extracted \
  /exports/reum/CKe/PCArun/snplist.txt












