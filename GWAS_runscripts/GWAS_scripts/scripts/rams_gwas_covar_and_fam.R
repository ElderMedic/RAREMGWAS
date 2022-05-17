
# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file
# phenotype (1=unaffected (control), 2=affected (case), 0 or -9 = missing).




# libraries
library(tidyverse)
library(readxl)


###
#   Import all the ID's
###
setwd("X:/Stage/GWAS_preparation/Genetic_IDs")


###
# get the PCA DATA
###
PCA <- read.table("X:/Stage/PCA/version8.0/projections.txt", header = T)







########################################################  RAMS


# genetic
RAMS_gen_id <- read.table("RAMS.txt")

# clinical
RAMS_clin_id <- read.csv("X:/Stage/GWAS/pheno.csv", header=TRUE, na.strings=c(""," ","NA"))

# imputed clinical
RAMS_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/RAMS_imputed.csv", header=T, na.strings=c("","NA"))

##
# COVAR
##

# combine to build covar file 
RAMS_gen_id <- RAMS_gen_id %>% 
  mutate(fid_anon = sub("(.*?_.*?)_.*", "\\1", V1))

colnames(RAMS_gen_id)[1] <- "gen_id"

# get sex and age from clinical file
RAMS_clin_id <- RAMS_clin_id %>%
  select(fid_anon, fupno, sex, age_baseline) %>%
  filter(fupno == "Baseline") %>%
  select(-fupno)

# merge the clinical to the gen_id file and drop the cols we don't need
RAMS_covar <- merge(RAMS_gen_id, RAMS_clin_id, by="fid_anon")

# add PCA
colnames(RAMS_covar)[2] <- "FID"
RAMS_covar_done <- merge(RAMS_covar, PCA, by="FID")

# CLEAN-UP
RAMS_covar_done <- RAMS_covar_done %>%
  select(-IID) %>%
  mutate(fid_anon = FID,
         sex = ifelse(sex == "F", 2, 1))
colnames(RAMS_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(RAMS_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/RAMS.covar", sep = "\t", quote = F, row.names = F, col.names = T)


##
# FAM
##

setwd("X:/Stage/GWAS_preparation/Version1/fam files")
RAMS_fam <- read.table("old/RAMS_merged_extracted_LD_Done.fam")

RAMS_fam <- RAMS_fam %>%
  select(-V6)


# ADD das28crp to the right ID
RAMS_imputed_filter <- RAMS_imputed %>%
  mutate(V1 = paste0(fid_anon, "_", fid_anon),
         V6 = ifelse(DAS28_CRP < 2.6, 1, 2)) %>%
  filter(fupno == "6 Mo") %>%
  select(fid_anon, V1, V6)

# merge
RAMS_new_fam <- merge(RAMS_fam, RAMS_imputed_filter, by="V1")

RAMS_new_fam <- RAMS_new_fam %>%
  select(-fid_anon)


write.table(RAMS_new_fam, "X:/Stage/GWAS_preparation/Version1/fam files/new/RAMS_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)

########################################################  RAMS

