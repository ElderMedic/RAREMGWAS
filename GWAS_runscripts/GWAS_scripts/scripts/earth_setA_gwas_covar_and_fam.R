
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



# base clinical data
EARTH_A_clinical_base <- read.csv("X:/Stage/GWAS/GWAS_Remission_23082019_V3_Shared_adj.csv", sep=";", header = T, skip = 1, na.strings=c("","NA"))

# imputed clinical
EARTH_A_imputed <- read.csv("X:/Stage/impute_clinical/completed_datasets/earth_setA_imputed.csv", header=T, na.strings=c("","NA"))

# genetic
EARTH_A_gen_id <- read.table("EA127.txt")




##
# COVAR
##

# remove trailing 0's and conform the id's
EARTH_A_gen_id <- EARTH_A_gen_id %>%
  mutate(EA.Number = gsub("^.*_","", V1),
         EA.Number = gsub("^.*EA", "",EA.Number),
         EA.Number = sub("^0+", "", EA.Number))


# clinical imputed file, need to select the age / sex
EARTH_A_imputed_relevant <- EARTH_A_imputed %>%
  select(EA.Number, Sex, Age.at.EAC) %>%
  distinct(EA.Number, .keep_all = T) %>%
  mutate(Sex = ifelse(Sex == "F", 2, 1))



# first merge clinical imputed with genetic
earth_a_merge1 <- merge(EARTH_A_gen_id, EARTH_A_imputed_relevant, by="EA.Number")


# add PCA
colnames(earth_a_merge1)[2] <- "FID"
earth_A_covar_done <- merge(earth_a_merge1, PCA, by="FID")


# clean up the file
earth_A_covar_done <- earth_A_covar_done %>%
  select(IID, FID, Sex, Age.at.EAC, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10)
colnames(earth_A_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(earth_A_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/earth_A.covar", sep = "\t", quote = F, row.names = F, col.names = T)


##
# FAM
##


setwd("X:/Stage/GWAS_preparation/Version1/fam files")
EARTH_fam <- read.table("old/EA127genotypes_merged_extracted_LD_Done.fam")

# get the das28crp & make remission
EARTH_A_imputed$Months.since.1st.Visit <- gsub(",",".",EARTH_A_imputed$Months.since.1st.Visit)
EARTH_A_imputed <- transform(EARTH_A_imputed, Months.since.1st.Visit = as.numeric(Months.since.1st.Visit))
EARTH_remission <- EARTH_A_imputed %>%
  select(EA.Number, DAS28_CRP, Months.since.1st.Visit) %>%
  mutate(V6 = ifelse(DAS28_CRP < 2.6, 1, 2)) %>%
  filter(Months.since.1st.Visit >= 2 & Months.since.1st.Visit <= 13) %>%
  distinct(EA.Number, .keep_all = T)




## COUNTING HOW MANY WE KEEP 
EARTH_A_imputed %>%
  filter(Months.since.1st.Visit == 0) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()

EARTH_A_imputed %>%
  filter(Months.since.1st.Visit > 3 & Months.since.1st.Visit < 9) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()

EARTH_A_imputed %>%
  filter(Months.since.1st.Visit > 9 & Months.since.1st.Visit < 15) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()



EARTH_A_clinical_base$Months.since.1st.Visit <- gsub(",",".",EARTH_A_clinical_base$Months.since.1st.Visit)
EARTH_A_clinical_base <- transform(EARTH_A_clinical_base, Months.since.1st.Visit = as.numeric(Months.since.1st.Visit))
EARTH_A_clinical_base %>%
  filter(Months.since.1st.Visit == 0) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()

EARTH_A_clinical_base %>%
  filter(Months.since.1st.Visit > 3 & Months.since.1st.Visit < 9) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()

EARTH_A_clinical_base %>%
  filter(Months.since.1st.Visit > 9 & Months.since.1st.Visit < 15) %>%
  drop_na(DAS28_CRP) %>%
  distinct(EA.Number) %>%
  tally()



# first merge clinical imputed with genetic
earth_a_merge2 <- merge(EARTH_A_gen_id, EARTH_remission, by="EA.Number")


# merge fam with the remission
earth_merge3 <- merge(earth_a_merge2, EARTH_fam, by="V1", all=TRUE)



# clean up the fam
earth_merge3 <- earth_merge3 %>%
  mutate(remission = ifelse(DAS28_CRP < 2.6, 1, 2))
  
earth_fam_new <- earth_merge3 %>%
  mutate(V6 = remission, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(V1, V2, V3, V4, V5, V6)


write.table(earth_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/EA127genotypes_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)






