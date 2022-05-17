import sys
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from tqdm import trange,tqdm
import argparse

merge_a1 = pd.read_csv("/exports/reum/CKe/Pipelinerun_withPC/compareA1.txt",sep='\t',index_col=0)
merge_a2 = pd.read_csv("/exports/reum/CKe/Pipelinerun_withPC/compareA2.txt",sep='\t',index_col=0)
merge_a1.fillna("NotAvailable",inplace=True)
merge_a2.fillna("NotAvailable",inplace=True)

def commonpairs(dict_final_a1,dict_final_a2,stop=1000):
    common_pairs = dict()
    count = 0
    for key in dict_final_a1:
        if (key in dict_final_a2 and dict_final_a1[key] == dict_final_a2[key]):
            common_pairs[key] = dict_final_a1[key]
            print(key,common_pairs[key])
        count += 1
        if count == stop:
            print("breaking!")
            break
    return common_pairs

dict_final_a1 = {}
dict_final_a2 = {}
for i in range(merge_a1.shape[1]-2,0,-1): #if there's uniqueness col, start from merge_temp.shape[1]-2 in range. If with NMISS, ends at 1
# make sure EIRA is the second last and Leeds is the last dict to be updated to final 
    dict_temp_a1 = merge_a1[merge_a1.iloc[:,i]!="NotAvailable"].iloc[:,[0,i]].set_index('SNP')
    dict_temp_a2 = merge_a2[merge_a2.iloc[:,i]!="NotAvailable"].iloc[:,[0,i]].set_index('SNP')
    name_a1 = dict_temp_a1.columns.tolist()[0]
    name_a2 = dict_temp_a2.columns.tolist()[0]
    print("updating dict ",name_a1,name_a2)
    dict_temp_a1 = dict_temp_a1.to_dict('dict')[name_a1]
    dict_temp_a2 = dict_temp_a2.to_dict('dict')[name_a2]
    #dict_final = dict_final | dict_temp  # new function to merge dicts in python3.9
    dict_final_a1.update(dict_temp_a1)
    dict_final_a2.update(dict_temp_a2)
    commonpairs(dict_final_a1,dict_final_a2,max(len(dict_final_a1),len(dict_final_a2)))
print("get both dict_final!")
#np.save("final_dict_A1.npy",dict_final_a1)
#np.save("final_dict_A2.npy",dict_final_a2)
