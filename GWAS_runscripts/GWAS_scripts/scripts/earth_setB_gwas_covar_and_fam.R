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



# import clinical 
EARTH_imported <- read_excel("X:/Stage/Risk_Score/Output_Files/EarthB/EA_Samples.xlsx")

# import genetic
EARTH_B_gen_id <- read.table("EARTH_set_B.txt")


##
# COVAR
##

# conform the id's
EARTH_B_gen_id <- EARTH_B_gen_id %>%
  mutate(EANo = gsub("^.*_","", V1))

# get relevant columns
EARTH_covar <- EARTH_imported %>%
  select(EANo, Gender, PtAge)

# merge clinical with genetic
EARTH_covar_merge <- merge(EARTH_B_gen_id, EARTH_covar, by="EANo")
colnames(EARTH_covar_merge)[2] <- "FID"

# Add PCA
EARTH_covar_done <- merge(EARTH_covar_merge, PCA, by="FID")

# format
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10
EARTH_covar_done <- EARTH_covar_done %>%
  select(FID, IID, Gender, PtAge, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10) %>%
  mutate(Gender = ifelse(Gender == "F", 2, 1))
colnames(EARTH_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(EARTH_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/earth_B.covar", sep = "\t", quote = F, row.names = F, col.names = T)


##
# FAM
##

setwd("X:/Stage/GWAS_preparation/Version1/fam files")
EARTH_fam <- read.table("old/EARTH_setB_merged_extracted_LD_Done.fam")


# get relevant columns and turn das28crp into remission
EARTH_clin <- EARTH_imported %>%
  select(EANo, DAS28CRP_FU) %>%
  mutate(remission = ifelse(DAS28CRP_FU < 2.6, 1, 2))

# merge clinical with genetic
EARTH_fam_merge <- merge(EARTH_B_gen_id, EARTH_clin, by="EANo")


# merge fam 
earth_merge <- merge(EARTH_fam_merge, EARTH_fam, by="V1", all=TRUE)

earth_fam_new <- earth_merge %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(V1, V2, V3, V4, V5, V6)


write.table(earth_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/EARTH_setB_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)























