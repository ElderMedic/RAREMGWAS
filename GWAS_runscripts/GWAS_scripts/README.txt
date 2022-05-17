Steps done for running GWAS after post-imputation:
	1. Prepare the covar with (sex, age + 10 PC's) and the .fam file
		see the scripts in the "scripts" directory and the accompanying input files from "input_files_used"
		The scripts have my paths, they are not universal for every pc so you will have to rewrite the path to match the input (in dir input_files_used)
	2. Find common variants between cohorts and filter these out of the cohort plink files
		i did it like: https://git.lumc.nl/mpmaurits/remission-gwas/-/tree/master/PCA at "Determine overlap of variants"
		Filtering with (SHARK): /exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Version8/Runscript_extract_snplist.sh & extract_snplist.sh
	3. Change out the old .fam files after extracting variants with the new .fam made at step 1. 
	4. Merge the filtered files with plink 
		e.g.: /exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Version8/All_cohorts_merged/
	5. run gwas 
		e.g. = /exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Version8/All_cohorts_merged/results/Run_GWAS.sh

