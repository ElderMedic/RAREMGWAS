
# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file
# phenotype (1=unaffected (control), 2=affected (case), 0 or -9 = missing).




# libraries
library(tidyverse)
library(haven)
library(readxl)


###
#   Import all the ID's
###
setwd("X:/Stage/GWAS_preparation/Genetic_IDs")


###
# get the PCA DATA
###
PCA <- read.table("X:/Stage/PCA/version8.0/projections.txt", header = T)



########################################################  Madrid


# base clinical data
Madrid_clinical_base <- read_dta("X:/Stage/Risk_Score/Output_Files/Madrid/Clinical_data_GWAS_patients_HUP.dta")


## additional clinical data
madrid_clinical_additional <- read_excel("X:/Stage/Risk_Score/Output_Files/Madrid/Additional clincal data pacients GWAS HUP.xls")

madrid_orig <- madrid_clinical_additional %>%
  select(codigo2, das28pcr_v2)




# imputed clinical
madrid_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/madrid_imputed.csv", header=T, na.strings=c("","NA"))

# genetic
madrid_gen_id <- read.table("madrid.txt")

# add coupling key to genetic
madrid_gen_id <- madrid_gen_id %>%
  mutate(codigo2 = gsub("^.*_","", V1),
         codigo2 = gsub("^.*C","", V1))






##
# COVAR
##

# first get the cols we are interested in for covar
madrid_age <- madrid_clinical_additional %>%
  select(codigo2, edadinienf)

madrid_sex <- Madrid_clinical_base %>%
  select(codigo2, sexo)

madrid_covar <- merge(madrid_age, madrid_sex, by="codigo2")

# change the age variable
madrid_covar1 <- madrid_covar %>%
  mutate(sex = ifelse(sexo == 1, 2, 1)) %>%
  select(-sexo)

# merge with genetic
madrid_merge <- merge(madrid_covar1, madrid_gen_id, by="codigo2")


# paste PCA and clean the file
colnames(madrid_merge)[4] <- "FID"
madrid_covar_done <- merge(madrid_merge, PCA, by="FID")

madrid_covar_done <- madrid_covar_done %>%
  select(FID, IID, sex, edadinienf, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10)
colnames(madrid_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")


write.table(madrid_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/madrid.covar", sep = "\t", quote = F, row.names = F, col.names = T)




##
# FAM
##

setwd("X:/Stage/GWAS_preparation/Version1/fam files")
madrid_fam <- read.table("old/madrid_merged_extracted_LD_Done.fam")


# get the imputed dataframe and select relevant cols
madrid_imputed_das28crp <- madrid_imputed %>%
  select(codigo2, das28_v2)


# merge between the genetic id's and the keyfile
madrid_merge2 <- merge(madrid_gen_id, madrid_imputed_das28crp, by="codigo2")


# add das28crp
madrid_das <- madrid_merge2 %>%
  mutate(remission = ifelse(das28_v2 < 2.6, 1, 2)) %>%
  select(V1, remission)


# merge fam with the remission
madrid_merge3 <- merge(madrid_das, madrid_fam, by="V1", all=TRUE)

# clean up the fam
madrid_fam_new <- madrid_merge3 %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(-remission)



write.table(madrid_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/madrid_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)
















