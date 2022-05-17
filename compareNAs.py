import pandas as pd
import os
import numpy as np
import seaborn as sns

# count and plot missings in each cohort vs samples
# only have run in terminal not as script in one-go

loc_list = []
cleaned_list = []
for root, dirs, files in os.walk(os.getcwd()):
    for file in files:
        if file.endswith('_flipped.assoc.logistic'):
            loc = os.path.join(root, file)
            loc_list.append(loc)
        if file.endswith('noNA.assoc.logistic'):
            loc = os.path.join(root, file)
            cleaned_list.append(loc)
loc_list.append("/exports/reum/CKe/Tacera/Final_imputed/gwas_TACERA.assoc.logistic")

origin_num_dict = {}
for run in loc_list:
    for i in run.split('/'):
        if (i != 'mergedChr') and (i != 'Final_imputed'):
            cohort = i
        else:
            break
    summary_origin = pd.read_csv(run,sep='\s+')
    origin_num_dict[cohort] = summary_origin.shape[0]
     
noNA_num_dict = {}
for run in cleaned_list:
    for i in run.split('/'):
        if (i != 'mergedChr') and (i != 'Final_imputed'):
            cohort = i
        else:
            break    
    summary_noNA = pd.read_csv(run,sep='\s+')
    noNA_num_dict[cohort] = summary_noNA.shape[0]

#origin_num_dict
#{'RAMS': 12293615, 'Madrid': 13039847, 'EARTH_B': 9629990, 'EIRA': 20510411, 'ACPA': 12954732, 'SERA': 15510242, 'EARTH_A': 10235902, 'PEAC': 18036602, 'Vienna': 14572254, 'EAC': 18801643, 'Tacera': 21193891}

#noNA_num_dict
#{'RAMS': 8436114, 'Madrid': 7816659, 'noNA.assoc.logistic': 5310377, 'EARTH_B': 6847099, 'EIRA': 13198552, 'ACPA': 7718282, 'SERA': 9492920, 'EARTH_A': 6744538, 'PEAC': 8291145, 'Vienna': 9137097, 'EAC': 10655080, 'Tacera': 5310377}

#NAs_dict
#{'RAMS': 3857501, 'Madrid': 5223188, 'EARTH_B': 2782891, 'EIRA': 7311859, 'ACPA': 5236450, 'SERA': 6017322, 'EARTH_A': 3491364, 'PEAC': 9745457, 'Vienna': 5435157, 'EAC': 8146563, 'Tacera': 15883514}

#check how many snps left after prepare_meta(remove duplicate/biallelic snps)
prepareMeta_list = []
for root, dirs, files in os.walk("/exports/reum/CKe/generic-metal/RunMeta/"):
    for file in files:
        if file.endswith('noNA_meta.txt'):
            loc = os.path.join(root, file)
            prepareMeta_list.append(loc)
noDup_num_dict = {}
for run in prepareMeta_list:
    cohort = os.path.basename(run).split("_")[0] #prefered way to get cohort name
    summary_noDup = pd.read_csv(run,sep='\s+')
    noDup_num_dict[cohort] = summary_noDup.shape[0]
        
#>>> noDup_num_dict
#{'PEAC': 8278325, 'EIRA': 13168462, 'Madrid': 7806297, 'EARTHA': 6738130, 'SERA': 9476110, 'TACERA': 5310377, 'Vienna': 9122341, 'EAC': 10634476, 'EARTHB': 6839833, 'ACPA': 7708337, 'RAMS': 8423584}

#19251355 rows in original compareA1_unique.txt
#3539745 duplicated snps are removed, 15693023 remains (18587 snps repeated more than once, but we don't know how many different snps are there within those 18587 snps)

#for new compareA1.txt, in total we have 15709515 snps and 2541053 of them can not be found in EIRA reference A1
    
    