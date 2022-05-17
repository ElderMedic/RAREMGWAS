
# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file
# phenotype (1=unaffected (control), 2=affected (case), 0 or -9 = missing).


library(tidyverse)
library(readxl)

###
# get the PCA DATA
###
PCA <- read.table("X:/Stage/PCA/version8.0/projections.txt", header = T)
colnames(PCA)[1] <- "V1"


###
#   Import all the ID's
###
setwd("X:/Stage/GWAS_preparation/Genetic_IDs")


# genetic id
EIRA_genetic <- read.table("EIRA.txt")


# clinical data
EIRA_clinical <- read_excel("X:/Stage/GWAS_preparation/clinical data/Info to Rachel K 2020-12-10.xlsx")
EIRA_clinical <- EIRA_clinical %>%
  mutate(V1 = paste0("FAM001_", EIRA_MTX))



###################
# COVAR
###################

# Need cols for covar
EIRA_clin_V1 <- EIRA_clinical %>%
  mutate(FID = V1) %>%
  select(V1, FID, sex, age)

EIRA_merge_V1 <- merge(EIRA_clin_V1, PCA, by="V1")

EIRA_clin_V2 <- EIRA_merge_V1 %>%
  select(-IID, -IID)

colnames(EIRA_clin_V2) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(EIRA_clin_V2, "X:/Stage/GWAS_preparation/Version8/covar files/EIRA.covar", sep = "\t", quote = F, row.names = F, col.names = T)



###
# FAM
###


EIRA_fam <- read.table("X:/Stage/GWAS_preparation/Version8/fam files/old/EIRA_extracted.fam")


EIRA_clin_V1 <- EIRA_clinical %>%
  mutate(V1 = paste0("FAM001_", EIRA_MTX),
         remission = ifelse(das28crp_6 < 2.6, 1, 2)) %>%
  select(V1, remission)

EIRA_new_fam <- merge(EIRA_fam, EIRA_clin_V1, by="V1")


# clean up the .fam
EIRA_new_fam <- EIRA_new_fam %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(-remission)

write.table(EIRA_new_fam, "X:/Stage/GWAS_preparation/Version8/fam files/new/EIRA_extracted.fam", sep = " ", quote = F, row.names = F, col.names = F)

























