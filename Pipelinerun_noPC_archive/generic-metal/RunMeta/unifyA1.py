import pandas as pd
import numpy as np

#make sure all snps across different cohorts use the same A1 effect allele (minor)
array_cohorts=["EARTHB","EARTHA","Madrid","RAMS","Vienna","EAC","SERA","EIRA","PEAC","ACPA","TACERA"]

merge_temp = pd.read_csv("/exports/reum/CKe/compareA1.txt",sep='\t')
merge_temp.drop(['Unnamed: 0'],axis=1,inplace=True)
dict_final = {}
for i in range(2,merge_temp.shape[1]): #start from 2 if with NMISS col. if there's uniqueness col then -1 in range
    dict_temp = merge_temp[merge_temp.iloc[:,i].isnull()!=True].iloc[:,[0,i]].set_index('SNP')
    name = dict_temp.columns.tolist()[0]
    dict_temp = dict_temp.to_dict('dict')[name]
    #dict_final = dict_final | dict_temp #new function to merge dicts in python3.9
    dict_final.update(dict_temp)

print("get dict_final!")
#df_dict = pd.DataFrame(dict_final,index=range(15709515)) #too computationaly expensive
         
for run in array_cohorts:
    loc = "/exports/reum/CKe/generic-metal/RunMeta/"+run+"_noNA_maf_meta.txt"
    summary_origin = pd.read_csv(loc,sep='\t')
    summary_origin['A1'] = summary_origin['SNP'].map(dict_final) 
    new_loc = "/exports/reum/CKe/generic-metal/RunMeta/"+run+"_noNA_A1corr_maf_meta.txt"
    summary_origin.to_csv(new_loc,sep='\t',index=0)
    print("work done on cohort ",run)