#!/bin/sh

# do not re-run in same folder, if so make sure all files generated are deleted

#SBATCH --partition=all,highmem
#SBATCH -J GWAS_EARTHB_1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=c.ke@lumc.nl
#SBATCH --time=24:00:00 
#SBATCH --ntasks=6
#SBATCH --mem-per-cpu=6048MB

#awk to remove NA rows, this step is merged into Run_gwas.sh
module load statistical/R/3.6.2/gcc.8.3.1

path_dir="/exports/reum/CKe/Pipelinerun_withPC/Tacera/Final_imputed/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/EARTH_A/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/EARTH_B/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/Madrid/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/PEAC/Merge/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/RAMS/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/Vienna/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/EAC/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/SERA/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/EIRA/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/ACPA/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/Manchester/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}

path_dir="/exports/reum/CKe/Pipelinerun_withPC/Glagsgow/mergedChr/"
file_name=$(find ${path_dir} -name "*.assoc.logistic")
#awk '!/'NA'/' ${file_name} > ${path_dir}"noNA.assoc.logistic"
file_dir=$(find ${path_dir} -name "*noNA.assoc.logistic")
Rscript "DrawManh.r" ${file_dir} ${path_dir}