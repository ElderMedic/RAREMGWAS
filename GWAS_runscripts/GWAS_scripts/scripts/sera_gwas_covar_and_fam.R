
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


########################################################  sera

# genetic
sera_gen_id <- read.table("sera.txt")

# imputed clinical
sera_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/sera_imputed.csv", header=T, na.strings=c("","NA"))

# keyfile from  sera
sera_data <- read_excel("X:/Stage/Risk_Score/Output_Files/sera/SERA Final Leiden Manifest.xlsx",  na = "NA", col_names = TRUE, skip = 2)


##
# COVAR
##

# combine to build covar file 
koppeling <- sera_data %>%
  select(dcID, StudyNo)
colnames(koppeling)[1] <- "ID"

koppeling$ID <- gsub(" ", "", koppeling$ID)
koppeling$ID <- substring(koppeling$ID, 2)

sera_gen_id$V1 <- gsub("^.*_","", sera_gen_id$V1)
colnames(sera_gen_id) <- "ID"

first_merge <- merge(koppeling, sera_gen_id, by="ID")
colnames(first_merge)[2] <- "SNo"

sera_clin_merged <- merge(sera_imputed, first_merge, by="SNo")    # only 421 able to merge

# PCA doesnt have 1-1 similar ID's wth sera, so we change them
PCA_sera <- PCA %>%
  mutate(ID = gsub("^.*_", "", FID))

# add PCA
sera_covar_done <- merge(sera_clin_merged, PCA_sera, by="ID")     # still 421

# CLEAN-UP
sera_covar_donev1 <- sera_covar_done %>%
  mutate(IID = FID) %>%
  select(FID, IID, Gender, AgeAtBaseline, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10) %>%
  mutate(Gender = ifelse(Gender == "Female", 2, 1))

colnames(sera_covar_donev1) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")
write.table(sera_covar_donev1, "X:/Stage/GWAS_preparation/Version8/covar files/sera.covar", sep = "\t", quote = F, row.names = F, col.names = T)



##
# FAM
##

setwd("X:/Stage/GWAS_preparation/Version1/fam files")
sera_fam <- read.table("old/sera_merged_extracted_LD_Done.fam")

sera_fam <- sera_fam %>%
  select(-V6)


# ADD das28crp to the right ID
sera_imputed_rem <- sera_covar_done %>%
  mutate(V6 = ifelse(DAS28CRP_Month_6 < 2.6, 1, 2)) %>%
  select(FID, V6)
colnames(sera_imputed_rem) <- c("V1","rem") 


# merge fam with the remission
sera_imputed_rem <- merge(sera_imputed_rem, sera_fam, by="V1", all=TRUE)

sera_fam_new <- sera_imputed_rem %>%
  mutate(V6 = rem, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(V1, V2, V3, V4, V5, V6)


write.table(sera_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/sera_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)


