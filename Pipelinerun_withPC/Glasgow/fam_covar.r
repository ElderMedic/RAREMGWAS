# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file



# libraries
library(tidyverse)
library(readxl)

PCA <- read.table("/exports/reum/knevel_lab/Scripts_Samantha/PCA_files/version8.0/PCA_run/projections.txt", header = T)
sera_gen_id <- read.table("/exports/reum/knevel_lab/Scripts_Samantha/GWAS_run/Genetic_IDs/sera.txt")
sera_imputed <- read.csv("/exports/reum/knevel_lab/Scripts_Samantha/clinical_imputation/impute_clinical/completed_datasets/sera_imputed.csv", header=T, na.strings=c("","NA"))
sera_data <- read_excel("/exports/reum/knevel_lab/SERA/Data/SERA Final Leiden Manifest.xlsx",  na = "NA", col_names = TRUE, skip = 2)

