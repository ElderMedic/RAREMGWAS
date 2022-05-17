#!/bin/sh
#SBATCH --partition=all,highmem
#SBATCH -J merge_leeds
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

basePath=/exports/reum/knevel_lab/Leeds/Remission_Results_HCs/
cd ${basePath}
mkdir mergedChr

for i in {1..22}
do
  cat chr$i.assoc.logistic >> mergedCHR.assoc.logistic
done

mv mergedCHR.assoc.logistic mergedChr


