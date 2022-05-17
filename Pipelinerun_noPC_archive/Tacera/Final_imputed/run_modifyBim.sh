#!/bin/bash

#SBATCH --partition=all,highmem
#SBATCH -J modify_bim
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=12:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

# Get correct snp id (chr:bp) without annotation, basically remove alleles from *_noNA_meta.txt, actually useless step :) wrong way 

module add tools/miniconda/python3.8

cd /exports/reum/CKe/Tacera/Final_imputed/
python "/exports/reum/CKe/Tacera/Final_imputed/modifyBim.py"