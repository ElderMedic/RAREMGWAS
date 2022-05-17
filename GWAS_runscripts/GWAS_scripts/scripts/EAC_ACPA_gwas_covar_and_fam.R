
# STEP 1:
# Make the covar file for every cohort looking like:
#Sex (1 = Male, 2 = Female)
# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10


# STEP 2:
# Add the remission outcome to the .fam file
# phenotype (1=unaffected (control), 2=affected (case), 0 or -9 = missing).



## #### how to get the clinical data #### ## 
# from /exports/reum/knevel_lab/EAC_PatDat/

# load in load("20200730_EAC_Merged.RData")

###
# get the cols we are interested in

#   need_for_gwas <- full %>%
#   select(EACNUMM, EZIS.id, crp, Age_incl, geslacht)

###
# write it out

# write.table(need_for_gwas, "/exports/reum/knevel_lab/Scripts_Samantha/additional_for_gwas.txt", sep = " ", quote = F, row.names = F, col.names = T)




# libraries
library(tidyverse)
library(readxl)
library(haven)


###
#   Import all the ID's
###
setwd("X:/Stage/GWAS_preparation/Genetic_IDs")


###
# get the PCA DATA
###
PCA <- read.table("X:/Stage/PCA/version8.0/projections.txt", header = T)


# clinical data
EAC_ACPA_clinical <- read.table("need_for_gwas.txt", header = T)

# imputed data
imputation_EAC_ACPA <- read.csv("X:/Stage/impute_clinical/Xanthe/geimputeerdeDAS20201106.csv", header = T, sep = ";")

# genetic ACPA neg
ACPA_genetic <- read.table("ACPA_neg.txt")

# genetic EAC
EAC_genetic <- read.table("EAC.txt")






##
# Add the cols from .imp 1 (imputed data) to the dataframe with the clinical data
##

# only need 6 month data = beznr 2 OR 3 (number of patients: only 2: 957, both 2 and 3 with distinct EACNUmm: 1016)
imputation_one <- imputation_EAC_ACPA %>%
  filter(.imp == 1, BEZNR == 2 | BEZNR == 3) %>%
  distinct(EACNUMM, .keep_all = T)


EAC_ACPA_imp_1 <- merge(EAC_ACPA_clinical, imputation_one, by="EACNUMM")

# calculate das28crp
getDas <- function(TJC28, SJC28, CRP, GH){
  DAS28CRP = 0.56*sqrt(TJC28) + 0.28*sqrt(SJC28) + 0.36*log(CRP+1) + 0.014*GH + 0.96
  return(DAS28CRP)
}

# use function for filling
# the person with EACNUMM 4047 has a crp of -1.1, this produces NAN's and so this person will be removed
EAC_ACPA_imp_1 <- EAC_ACPA_imp_1 %>%
  filter(!EACNUMM == 4047) %>%
  drop_na(TJC28, SJC28, crp, VASZACT) %>%
  mutate(DAS28CRP = getDas(TJC28, SJC28, crp, VASZACT),
         remission = ifelse(DAS28CRP < 2.6, 1, 2))




##
# COVAR EAC
##

# FID IID Sex AGE PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10

# add key
key <- read.table("X:/Stage/keys/EAC_key_final_typed_samples.txt", sep="|", header=T)

# only select relevant cols
key_filter <- key %>%
  select(EAC.nummer, Gerries.nummer)
colnames(key_filter) <- c("EACNUMM", "ID")

# add col with the number (gerries number) that can merge
EAC_genetic <- EAC_genetic %>%
  mutate(ID = gsub("^.*_","", V1))


# key merge
second_merge <- merge(key_filter, EAC_genetic, by="ID")


# relevant cols and make the sex columns universal with all the other datasets (Female = 2, Male = 1)
EAC_relevant <- EAC_ACPA_clinical %>%
  select(EACNUMM, Age_incl, geslacht) %>%
  mutate(geslacht = ifelse(geslacht == 1 | geslacht == "Vrouw", 2, 1))

EAC_covar <- merge(second_merge, EAC_relevant, by="EACNUMM")


# add pca
colnames(EAC_covar)[3] <- "FID"
EAC_covar_done <- merge(EAC_covar, PCA, by="FID")

# clean up and rename
EAC_covar_done <- EAC_covar_done %>%
  select(FID, IID, geslacht, Age_incl, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10)
colnames(EAC_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")


write.table(EAC_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/EAC.covar", sep = "\t", quote = F, row.names = F, col.names = T)





##
# COVAR ACPA NEG
##


# keyfile ACPA NEG
ACPA_keyfile <- read_sav("X:/Stage/GWAS/Sleutelfile neg GWAS EAC.sav")

# make a col that can be merged
ACPA_genetic <- ACPA_genetic %>%
  mutate(DNA_volgnummer = sub("\\_.*", "", V1))


# merge acpa_genetic with acpa keyfile
ACPA_covar <- merge(ACPA_genetic, ACPA_keyfile, by="DNA_volgnummer")



# merge the clinical with acpa_covar
ACPA_covar_v2 <- merge(ACPA_covar, EAC_relevant, by="EACNUMM")

# add pca
colnames(ACPA_covar_v2)[3] <- "FID"
ACPA_covar_done <- merge(ACPA_covar_v2, PCA, by="FID")


# clean up and rename
ACPA_covar_done <- ACPA_covar_done %>%
  select(FID, IID, geslacht, Age_incl, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10)
colnames(ACPA_covar_done) <- c("FID", "IID", "Sex", "AGE", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")

write.table(ACPA_covar_done, "X:/Stage/GWAS_preparation/Version8/covar files/ACPA.covar", sep = "\t", quote = F, row.names = F, col.names = T)







##
# FAM EAC
##

# import both fam
setwd("X:/Stage/GWAS_preparation/Version1/fam files")
EAC_fam <- read.table("old/EAC_merged_extracted_LD_Done.fam")
ACPA_fam <- read.table("old/ACPAneg_merged_extracted_LD_Done.fam")


# merge to the keyfile with the genetic ids
EAC_fam_make <- merge(second_merge, EAC_clin_relevant, by="EACNUMM", all=T)
EAC_fam_make <- EAC_fam_make %>%
  drop_na(EACNUMM)




# lets see if we can add any that are in the original patdat
EAC_additional_DAS <- read.table("X:/Stage/GWAS_preparation/Genetic_IDs/additional_for_gwas.txt", header=T)

# remove cols that dont have das28crp at all
EAC_additional_DAS <- EAC_additional_DAS %>%
  drop_na(das28crp) %>%
  select(EACNUMM, das28crp)

EAC_fam_v2 <- merge(EAC_fam_make, EAC_additional_DAS, by="EACNUMM", all=T)

EAC_fam_v2 <- EAC_fam_v2 %>%
  drop_na(EACNUMM) %>%
  mutate(rem = ifelse(das28crp < 2.6, 1, 2), remission_achieved = coalesce(remission, rem))

EAC_fam_v2 <- EAC_fam_v2 %>%
  select(V1, remission_achieved)

EAC_fam_v3 <- merge(EAC_fam, EAC_fam_v2, by="V1")

EAC_fam_new <- EAC_fam_v3 %>%
  mutate(V6 = remission_achieved, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(V1, V2, V3, V4, V5, V6)

write.table(EAC_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/EAC_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)






##
# FAM ACPA NEG
##

# do we have any already present in additional das28crp?
ACPA_neg_das <- merge(EAC_additional_DAS, ACPA_covar, by="EACNUMM", all=T)

ACPA_neg_das <- ACPA_neg_das %>%
  drop_na(V1)


# now from the imputation
ACPA_imp <- EAC_ACPA_imp_1 %>%
  select(EACNUMM, DAS28CRP, remission)

ACPA_neg_dasV2 <- merge(ACPA_imp, ACPA_neg_das, by="EACNUMM", all=T)
ACPA_neg_dasV2 <- ACPA_neg_dasV2 %>%
  drop_na(EACNUMM)

ACPA_neg_dasV2 <- ACPA_neg_dasV2 %>%
  drop_na(EACNUMM) %>%
  mutate(rem = ifelse(das28crp < 2.6, 1, 2), remission_achieved = coalesce(remission, rem))


ACPA_neg_dasV2 <- ACPA_neg_dasV2 %>%
  select(V1, remission_achieved) %>%
  drop_na(V1)

ACPA_fam_v3 <- merge(ACPA_fam, ACPA_neg_dasV2, by="V1")

ACPA_fam_new <- ACPA_fam_v3 %>%
  mutate(V6 = remission_achieved, V6 = ifelse(is.na(V6), "-9", V6)) %>%
  select(V1, V2, V3, V4, V5, V6)


write.table(ACPA_fam_new, "X:/Stage/GWAS_preparation/Version1/fam files/new/ACPAneg_merged_extracted_LD_Done.fam", sep = " ", quote = F, row.names = F, col.names = F)









# V4 only non imputed data
setwd("X:/Stage/GWAS_preparation/Version1/fam files/new")

newest_fam <- read.table("X:/Stage/GWAS_preparation/Version1/fam files/new/EAC_merged_extracted_LD_Done.fam")

EAC_famV4 <- newest_fam %>%
  mutate(ID = gsub("^.*_","", V1))

V4_merge <- merge(key_filter, EAC_famV4, by="ID")


V4_merge_fam <- V4_merge %>%
  mutate(V6 = ifelse(!EACNUMM %in% EAC_additional_DAS$EACNUMM, -9, V6)) %>%
  select(-EACNUMM, -ID)
         


write.table(V4_merge_fam, "X:/Stage/GWAS_preparation/Version1/fam files/new/EAC_V4.fam", sep = " ", quote = F, row.names = F, col.names = F)




# V6 only non imputed data
genotype_id <- read.table("X:/Stage/GWAS_preparation/Version4/EAC_genotyped_ids.txt")

genotype_id <- genotype_id %>%
  mutate(V3 = paste0(V1, "_",V2))


#######

# WITHOUT CLINICAL DATA
V6_without_clinical <- V4_merge_fam
nrow(V6_without_clinical)


V6_genotype <- genotype_id %>%
  mutate(V1 = V3, V6 = -9) %>%
  select(-V2, -V3)

both <- merge(V6_genotype, V6_without_clinical, by="V1", all=T)

both <- both %>%
  mutate(remission_achieved = coalesce(V6.y, V6.x),
         V6 = remission_achieved,
         V2 = V1) %>%
  select(-remission_achieved, -V6.x, -V6.y)

both[is.na(both)] <- 0


write.table(both, "X:/Stage/GWAS_preparation/Version1/fam files/new/V6_without_clinical.fam", sep = " ", quote = F, row.names = F, col.names = F)










#######

# WITH CLINICAL DATA
V6_with_clinical <- newest_fam
nrow(V6_with_clinical)


V6_genotype <- genotype_id %>%
  mutate(V1 = V3, V6 = -9) %>%
  select(-V2, -V3)

both <- merge(V6_genotype, V6_with_clinical, by="V1", all=T)

both <- both %>%
  mutate(remission_achieved = coalesce(V6.y, V6.x),
         V6 = remission_achieved,
         V2 = V1) %>%
  select(-remission_achieved, -V6.x, -V6.y)

both[is.na(both)] <- 0


write.table(both, "X:/Stage/GWAS_preparation/Version1/fam files/new/V6_with_clinical.fam", sep = " ", quote = F, row.names = F, col.names = F)







