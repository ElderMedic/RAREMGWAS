
# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file
# phenotype (1=unaffected (control), 2=affected (case), 0 or -9 = missing).


library(tidyverse)


###
# get the PCA DATA
###
PCA <- read.table("X:/Stage/PCA/version8.0/projections.txt", header = T)
PCA$BaselineID <- gsub("_.*","",PCA$FID)
PCA1 <- PCA %>%
  select(-FID)


###
#   Import all the ID's
###
setwd("X:/Stage/GWAS_preparation/Genetic_IDs")


# clinical data (imputed)
PEAC_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/PEAC_imputed.csv")
# only get the right cols
PEAC_age_sex <- PEAC_imputed %>%
  mutate(sex = ifelse(Gender == "F", 2, 1)) %>%
  select(BaselineID,Baseline_Age, sex)


# genetic
PEAC_genetic <- read.table("PEAC_ids_after_QC.txt")
colnames(PEAC_genetic) <- "BaselineID"


# merge first time
PEAC_first_merge <- merge(PEAC_genetic, PEAC_age_sex, by="BaselineID")
PEAC_first_merge_v1 <- PEAC_first_merge %>%
  distinct(BaselineID, .keep_all = T)


#  merge with PCA
PEAC_second_merge <- merge(PEAC_first_merge_v1, PCA1, by = "BaselineID")
PEAC_second_merge$BaselineID <- PEAC_second_merge$IID



# Clean up
PEAC_covar <- PEAC_second_merge %>%
  mutate(id = BaselineID) %>%
  select(BaselineID, id, sex, Baseline_Age, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10)


colnames(PEAC_covar) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(PEAC_covar, "X:/Stage/GWAS_preparation/Version8/covar files/PEAC.covar", sep = "\t", quote = F, row.names = F, col.names = T)







###
# FAM
###


# import
PEAC_fam <- read.table("X:/Stage/GWAS_preparation/Version8/fam files/old/PEAC_extracted.fam")

PEAC_fam$BaselineID <- gsub("_.*","",PEAC_fam$V1)


# select the 6month das data
PEAC_6mo <- PEAC_imputed %>%
  select(BaselineID, Timepoint, DAS28CRP) %>%
  filter(Timepoint == 6) %>%
  mutate(remission = ifelse(DAS28CRP < 2.6, 1, 2))


# merge fam with the remission
PEAC_new_fam <- left_join(PEAC_fam, PEAC_6mo, by="BaselineID", all=TRUE)



# clean up the fam
PEAC_new_fam_V1 <- PEAC_new_fam %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(-remission, -DAS28CRP, -Timepoint, -BaselineID)



write.table(PEAC_new_fam_V1, "X:/Stage/GWAS_preparation/Version8/fam files/new/PEAC_extracted.fam", sep = " ", quote = F, row.names = F, col.names = F)


























