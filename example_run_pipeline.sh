#!/bin/sh
#SBATCH --partition=all,highmem
#SBATCH -J pipeline_run
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=8096MB

module load  tools/miniconda/python3.8
conda activate CKe
python "/exports/reum/CKe/GWASandMetaPipeline_v4.py" --metaPrepare --meta --makeA1compare --correctA1 --meta --postmeta 