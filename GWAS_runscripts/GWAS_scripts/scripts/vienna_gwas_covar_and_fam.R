
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
colnames(PCA)[1] <- "V1"




########################################################  vienna

# genetic
vienna_gen_id <- read.table("vienna.txt")
vienna_gen_id <- vienna_gen_id %>% 
  mutate(genetic = gsub("^.*_","", V1))


# clinical
vienna_clinical <- VIENNA_data <- read.csv("X:/Stage/GWAS/Rachel_data_ready_to deliver.csv", sep=";", header=TRUE, na.strings=c(""," ","NA"))


# imputed clinical
vienna_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/vienna_imputed.csv", header=T, na.strings=c("","NA"))
colnames(vienna_imputed)[1] <- "genetic"


# key for combining clinical - genotype
vienna_key <- read_excel("X:/Stage/Risk_Score/Output_Files/vienna/input/vienna_sample_key_ID_FULL_LINK.xlsx")
colnames(vienna_key) <- c("patient", "genetic")



##
# COVAR
##

# merge between the genetic id's and the keyfile
vienna_merge1 <- merge(vienna_key, vienna_gen_id, by="genetic")

# merge between the previous merge, and the imputation clinical data
vienna_merge2 <- merge(vienna_merge1, vienna_imputed, by="genetic")


# get sex and age from clinical file + ID
vienna_covar <- vienna_merge2 %>%
  select(V1, sex, age) %>%
  group_by(V1) %>%
  arrange(age) %>%
  distinct(V1, .keep_all = T)



# merge with PCA
vienna_covar_PCA <- merge(vienna_covar, PCA, by = "V1")


# cleanup and format
vienna_covar_done <- vienna_covar_PCA %>%
  select(V1, IID, sex, age, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10) %>%
  mutate(sex = ifelse(sex == "F", 2, 1))

colnames(vienna_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")


write.table(vienna_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/vienna.covar", sep = "\t", quote = F, row.names = F, col.names = T)





###
# FAM
###

setwd("X:/Stage/GWAS_preparation/Version1/fam files")
vienna_fam <- read.table("old/vienna_merged_extracted_LD_Done.fam")

# we only want the around 6 month remission outcomes - chosen for visit 3 or 4 (gain of 50 people taking both)
vienna_merge3_das28crp <- vienna_imputed %>%
  filter(visit_nr == 3 | visit_nr == 4) %>%
  group_by(genetic) %>%
  arrange(desc(visit_nr)) %>%
  distinct(genetic, .keep_all = T)



# merge between the genetic id's and the keyfile
vienna_merge3 <- merge(vienna_gen_id, vienna_merge3_das28crp, by="genetic")


# add das28crp
vienna_das <- vienna_merge3 %>%
  mutate(remission = ifelse(DAS_crp < 2.6, 1, 2)) %>%
  select(V1, remission)


# merge fam with the remission
vienna_merge4 <- merge(vienna_das, vienna_fam, by="V1", all=TRUE)

# clean up the fam
vienna_fam_new <- vienna_merge4 %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(-remission)

  

write.table(vienna_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/vienna_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)



########################################################  vienna



















