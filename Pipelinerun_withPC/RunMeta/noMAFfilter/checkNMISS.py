import pandas as pd
import os
import numpy as np

#check fam phenos and support NMISS, to be updated with all cohorts
loc_list = []
rootdir = "/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/"
for root, dirs, files in os.walk(rootdir):
    for file in files:
        if file.endswith('noNA_noMAFfilter_meta.txt'):
            loc = os.path.join(root, file)
            loc_list.append(loc)
            
#remove run only once, don't remove at final meta, no Glasgow for now but if it's named with same end it will be added in future run
#loc_list.remove('/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/Manchester_noNA_noMAFfilter_meta.txt')
#loc_list.remove('/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/Tacera_noNA_noMAFfilter_meta.txt')

merge_temp = pd.DataFrame(columns=['SNP','NMISS'])
cols_to_keep = ['SNP','NMISS']
for i in range(len(loc_list)):
    cohort = pd.read_csv(loc_list[i],sep='\t')
#     cohort_name = os.path.split(loc_list[i])[1].split("_")[0]
    merge_temp = pd.merge(merge_temp,cohort,how='outer',left_on='SNP',right_on='SNP') #,suffixes=('',"_"+cohort1_name)
    merge_temp['NMISS_x'].fillna(0,inplace=True)
    merge_temp['NMISS_y'].fillna(0,inplace=True)
    merge_temp['NMISS'] = merge_temp['NMISS_x'] + merge_temp['NMISS_y'] #calculate phenotypes for each snp
    #print(merge_temp.columns)
    merge_temp = merge_temp.loc[:,cols_to_keep]
    print("openning ",loc_list[i],"cols to keep: ",cols_to_keep)
    #merge_temp.to_csv("/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/compareNMISS_10cohort.txt",sep='\t')
merge_temp.to_csv("/exports/reum/CKe/Pipelinerun_withPC/RunMeta/noMAFfilter/compareNMISS_Allcohort.txt",sep='\t')