#!/bin/sh
#SBATCH --partition=highmem,all
#SBATCH -J check_dict
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=8
#SBATCH --mem=100000MB

module load  tools/miniconda/python3.8
conda activate CKe

python "/exports/reum/CKe/Pipelinerun_withPC/checkDict.py"
