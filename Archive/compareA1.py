import pandas as pd
import os
import numpy as np

#checking A1s for *_noNA_meta.txt files
 
loc_list = []
for root, dirs, files in os.walk("/exports/reum/CKe/generic-metal/RunMeta/"):
    for file in files:
        if file.endswith('noNA_maf_meta.txt'):
            loc = os.path.join(root, file)
            loc_list.append(loc)
 
merge_temp = pd.DataFrame(columns=['SNP','NMISS'])
cols_to_keep = ['SNP','NMISS','A1']
for i in range(len(loc_list)):
    cohort1 = pd.read_csv(loc_list[i],sep='\t')
    cohort1_name = os.path.split(loc_list[i])[1].split("_")[0]
    #cohort2 = pd.read_csv(loc_list[i+1],sep='\t')
    #cohort2_name = loc_list[i+1].split("_")[0].lstrip("/exports/reum/CKe/generic-metal/RunMeta/")
    merge_temp = pd.merge(merge_temp,cohort1,how='outer',left_on='SNP',right_on='SNP') #,suffixes=('',"_"+cohort1_name)
    merge_temp['NMISS_x'].fillna(0,inplace=True)
    merge_temp['NMISS_y'].fillna(0,inplace=True)
    merge_temp['NMISS'] = merge_temp['NMISS_x'] + merge_temp['NMISS_y'] #calculate phenotypes for each snp
    if i != 0:
      cols_to_keep.append('A1')
    merge_temp = merge_temp.loc[:,cols_to_keep]
    merge_temp = merge_temp.rename({'A1':'A1_'+cohort1_name},axis=1)
    cols_to_keep = merge_temp.columns.tolist()
    #print(merge_temp.columns)
    print("cols to keep: ",cols_to_keep)
    #merge_temp.to_csv("/exports/reum/CKe/"+cohort1_name+"_compareA1.txt",sep='\t')
    merge_temp.to_csv("/exports/reum/CKe/compareA1.txt",sep='\t')

    
