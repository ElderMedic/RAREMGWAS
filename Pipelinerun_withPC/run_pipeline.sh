#!/bin/sh
#SBATCH --partition=highmem,all
#SBATCH -J pipeline_run
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --mem=100000MB
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6

module load  tools/miniconda/python3.8
conda activate CKe

#python "/exports/reum/CKe/Pipelinerun_withPC/GWASandMetaPipeline_v4.py" -wk "/exports/reum/CKe/Pipelinerun_withPC/" -f "piperun_fixa1.txt" --metaPrepare --makeA1compare --correctA1 --meta --postmeta

python "/exports/reum/CKe/Pipelinerun_withPC/GWASandMetaPipeline_v5.py"