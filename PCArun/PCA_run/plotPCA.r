######
## COHORTS
######

# read in the cohort projections produced in PLINK. Change the colnames and remove information we don't need.
eigenvec <- read.table('projections.txt', header = FALSE, skip=1, sep = "\t")
rownames(eigenvec) <- eigenvec[,2]
eigenvec <- eigenvec[,2:ncol(eigenvec)]
colnames(eigenvec) <- c("IDs", paste('PC', c(1:10), sep = ''))

#I will not include this in the gitlab, but we have vectors (acpa_neg, EARTH_set_A etc) with patient ID's. With these patient ID's we can look up the right cohort and label them as such.
group_eigenvec <- eigenvec %>%
  mutate(group_code = case_when(IDs %in% acpa_neg ~ "ACPA negative",
                                IDs %in% EARTH_set_A ~ "Earth set A",
                                IDs %in% EARTH_set_B ~ "Earth set B",
                                IDs %in% EAC ~ "EAC",
                                IDs %in% Madrid ~ "Madrid",
                                IDs %in% RAMS ~ "RAMS",
                                IDs %in% ref ~ "reference",
                                IDs %in% sera ~ "Sera",
                                IDs %in% vienna ~ "Vienna"))




######
## REFERENCE
######

# read in the reference principle components produced in PLINK. Change the colnames and remove information we don't need.
ref_eig <- read.table('pcs.txt', header = FALSE, skip=1, sep = "\t")
rownames(ref_eig) <- ref_eig[,2]
ref_eig <- ref_eig[,2:ncol(ref_eig)]
colnames(ref_eig) <- c("IDs", paste('PC', c(1:10), sep = ''))


# REF add the populations to the reference
PED <- read.table('20130606_g1k.ped', header = TRUE, skip = 0, sep = '\t')
colnames(PED) <- c("Family_ID", "IDs", "Paternal_ID", "Maternal_ID", "Gender", "Phenotype","Population","Relationship","Siblings","Second_Order","Third_Order","Other_Comments")
PED_fil <- PED %>%
  select(IDs, Population)



#####
## Merge
#####

total_ref_v3 <- merge(ref_eig_v3, PED_fil, by=c("IDs"))

total_ref_v3 <- total_ref_v3 %>%
  mutate(Super_code = case_when(Population == "CHB" ~ "EAS",
                                Population == "JPT" ~ "EAS",
                                Population == "CHS" ~ "EAS",
                                Population == "CDX" ~ "EAS",
                                Population == "KHV" ~ "EAS",
                                Population == "CEU" ~ "EUR",
                                Population == "TSI" ~ "EUR",
                                Population == "FIN" ~ "EUR",
                                Population == "GBR" ~ "EUR",
                                Population == "IBS" ~ "EUR",
                                Population == "YRI" ~ "AFR",
                                Population == "LWK" ~ "AFR",
                                Population == "GWD" ~ "AFR",
                                Population == "MSL" ~ "AFR",
                                Population == "ESN" ~ "AFR",
                                Population == "ASW" ~ "AFR",
                                Population == "ACB" ~ "AFR",
                                Population == "MXL" ~ "AMR",
                                Population == "PUR" ~ "AMR",
                                Population == "CLM" ~ "AMR",
                                Population == "PEL" ~ "AMR",
                                Population == "GIH" ~ "SAS",
                                Population == "PJL" ~ "SAS",
                                Population == "BEB" ~ "SAS",
                                Population == "STU" ~ "SAS",
                                Population == "ITU" ~ "SAS"
  ))



#####
## Plot only reference
#####

gg_ref <- ggplot(total_ref_v3, aes(x=PC1, y=PC2, col=Super_code)) + 
  geom_point(data = total_ref_v3) +
  labs(subtitle="PC1 vs PC2", 
       y="PC2", 
       x="PC1", 
       title="1000 Genomes only")



#####
## Plot both reference and cohorts (reference is gray, colors in legend for cohorts)
#####

# Scatterplot PC1 VS PC2
gg <- ggplot(group_eigenvec, aes(x=PC1, y=PC2, col=group_code)) + 
  geom_point(data = ref_eig, color = "gray") +
  geom_point(size=1.5) +
  labs(subtitle="PC1 vs PC2", 
       y="PC2", 
       x="PC1", 
       title="Reference based: colored by cohort") +
  scale_color_manual(values=c("#f94144", "#f3722c", "#f8961e","#f9c74f", "#90be6d", "#43aa8b","#577590", "#22223b"))