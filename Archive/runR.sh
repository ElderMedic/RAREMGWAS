#!/bin/bash

#SBATCH --partition=all,highmem
#SBATCH -J Rsid_trial
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

# Get rsid for all cohort .assoc.logistic files, output a column of rsid

module purge
module add statistical/R/4.0.2/gcc.8.3.1

array_cohorts=("EARTH_B" "EARTH_A" "Madrid" "RAMS" "Vienna" "EAC" "SERA" "EIRA") 

for cohort in ${array_cohorts[@]}
do
    Rscript "/exports/reum/CKe/genotyped_snps_to_rsids.r" "/exports/reum/CKe/"$cohort"/mergedChr/noNA.assoc.logistic" "/exports/reum/CKe/"$cohort"/mergedChr/rsid_noNA.txt"
done


