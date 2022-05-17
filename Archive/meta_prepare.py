import pandas as pd
import os
import numpy as np

# prepare assoc.logistic file for meta-analysis not applicable for tacera/leeds
# get correct major allele A2, calculate BETA from OR, drop all biallelic snps
# check pipeline script for latest version!

loc_list = []
for root, dirs, files in os.walk(os.getcwd()):
    for file in files:
        if file.endswith('noNA.assoc.logistic'):
            loc = os.path.join(root, file)
            loc_list.append(loc)
            
for run in loc_list:
    for i in run.split('/'):
        if (i != 'mergedChr') and (i != 'Final_imputed'):
            cohort = i
        else:
            break
    if cohort == 'Tacera': 
        continue
    summary_origin = pd.read_csv(run,sep='\s+')
    A2 = summary_origin['SNP'].str.split(':',expand=True)[2]
    index_to_correct = summary_origin[summary_origin['SNP'].str.split(':',expand=True)[2]==summary_origin['A1']].index
    A2[index_to_correct]=summary_origin['SNP'].str.split(':',expand=True)[3][index_to_correct]
    BETA = np.log(summary_origin['OR'])
    summary_origin.insert(4,'A2',A2)
    summary_origin.insert(8,'BETA',BETA)
    SNP = summary_origin['SNP'].str.split(':',expand=True)[0]+":"+summary_origin['SNP'].str.split(':',expand=True)[1]
    summary_origin['SNP'] = SNP
    summary_origin.drop_duplicates('SNP', keep = False, inplace=True)
    new_name = cohort + "_noNA_maf_meta.txt"
    new_loc = os.path.join(os.path.split(run)[0],new_name)
    summary_origin.to_csv(new_loc,sep='\t',index=0)