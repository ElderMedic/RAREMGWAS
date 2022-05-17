#!/usr/bin/env python
# coding: utf-8
# GWAS and Meta pipeline v5
# ### GWAS and Meta-analysis pipeline untill meta-analysis preparation
# cohorts: ALL Cohorts

import sys
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from tqdm import trange,tqdm
import argparse

def getloclist(wd,end,filter_out):
    loc_list = []
    EIRA_found = False
    for root, dirs, files in os.walk(wd):
        for file in files:
            if file.endswith(end) and not file.endswith(filter_out):
                if root.split("/")[-2]=="EIRA":
                    loc = os.path.join(root, file)
                    loc_list.insert(0,loc)
                    EIRA_found = True
                else:
                    loc = os.path.join(root, file)
                    loc_list.append(loc) #get bim file location
    if EIRA_found == True:
        print("EIRA detected!")
    else:
        print("Warning! No EIRA bim detected! Use first scanned cohort as ref!")
    return loc_list
    
def get_unique(x): # which alleles are used in all cohorts for a snp
    u = list(x.unique())
    while "NotAvailable" in u:
        u.remove("NotAvailable")
    u = "".join(map(str,u))
    return u
    
def compareA1(cwd=os.getcwd(),out="compareA1.txt",test=False):
    #detects prepared inputs of METAL in cwd and generate a table comparing A1s used
    loc_list = getloclist(os.getcwd(),".bim",("_A1corr.bim","_noDup.bim"))
    multiallelics = pd.DataFrame(columns=["SNP"])
    if test:
        loc_list = loc_list[2:4] # only Madrid and Tacera
        print(loc_list)
    #use leeds as primary ref
    Leeds = pd.read_csv("/exports/reum/CKe/Pipelinerun_withPC/Leeds/mergedChr/Leeds_noNA_maf_meta.txt",sep='\t')
    Leeds = Leeds[Leeds['A1']!=Leeds['A2']]
    Leeds.rename(columns={"A1":"A1_Leeds"},inplace=True)
    merge_temp = Leeds.loc[:,['SNP','A1_Leeds']]
    cols_to_keep = ['SNP','A1_Leeds']
    for i in range(len(loc_list)):
        cohort_name = loc_list[i].split("/")[-3]
        print("reading cohort ",cohort_name)
        bim_cohort = pd.read_csv(loc_list[i],sep='\t',header=None)
        bim_cohort.rename(columns={0:"CHR",1:"SNP",3:"BP",4:"A1",5:"A2"},inplace=True)   
        if cohort_name != "Tacera": # convert snp id format to chr:bp
            bim_cohort['SNP']=bim_cohort['SNP'].str.split(":",expand=True)[0]+":"+bim_cohort['SNP'].str.split(":",expand=True)[1]
        #multiallelics_inCohort = bim_cohort[bim_cohort.duplicated('SNP')]
        #multiallelics = multiallelics.merge(multiallelics_inCohort,how="outer",on="SNP").loc[:,['SNP']]
        #bim_cohort.drop_duplicates('SNP', inplace=True) #keep first 
        merge_temp = pd.merge(merge_temp,bim_cohort,how='outer',on="SNP") 
        cols_to_keep.append('A1')
        merge_temp = merge_temp.loc[:,cols_to_keep]
        merge_temp = merge_temp.rename({'A1':'A1_'+cohort_name},axis=1)
        cols_to_keep = merge_temp.columns.tolist()
        print("cols to keep: ",cols_to_keep)
        #merge_temp.to_csv("/exports/reum/CKe/"+cohort1_name+"_compareA1.txt",sep='\t') #save after done with each cohort
    merge_temp['Uniqueness'] = "NotAvailable"
    #multiallelics.drop_duplicates(inplace=True)
    #multiallelics['SNP'].to_csv("duplist_within.txt",sep='\t',index=False,header=False) 
    merge_temp.to_csv(out,sep='\t')
    print("saved initial table!")
    return merge_temp
    
def compareA2(cwd=os.getcwd(),out="compareA2.txt",test=False):
    #detects prepared inputs of METAL in cwd and generate a table comparing A1s used
    loc_list = getloclist(os.getcwd(),".bim",("_A1corr.bim","_noDup.bim"))
    if test:
        loc_list = loc_list[2:4] # only Madrid and Tacera
        print(loc_list)
    #use leeds as primary ref
    Leeds = pd.read_csv("/exports/reum/CKe/Pipelinerun_withPC/Leeds/mergedChr/Leeds_noNA_maf_meta.txt",sep='\t')
    Leeds = Leeds[Leeds['A1']!=Leeds['A2']]
    Leeds.rename(columns={"A2":"A2_Leeds"},inplace=True)
    merge_temp = Leeds.loc[:,['SNP','A2_Leeds']]
    cols_to_keep = ['SNP','A2_Leeds']
    for i in range(len(loc_list)):
        cohort_name = loc_list[i].split("/")[-3]
        print("reading cohort ",cohort_name)
        bim_cohort = pd.read_csv(loc_list[i],sep='\t',header=None)
        bim_cohort.rename(columns={0:"CHR",1:"SNP",3:"BP",4:"A1",5:"A2"},inplace=True)   
        if cohort_name != "Tacera": # convert snp id format to chr:bp
            bim_cohort['SNP']=bim_cohort['SNP'].str.split(":",expand=True)[0]+":"+bim_cohort['SNP'].str.split(":",expand=True)[1]
        #bim_cohort.drop_duplicates('SNP', inplace=True)
        merge_temp = pd.merge(merge_temp,bim_cohort,how='outer',on="SNP") 
        cols_to_keep.append('A2')
        merge_temp = merge_temp.loc[:,cols_to_keep]
        merge_temp = merge_temp.rename({'A2':'A2_'+cohort_name},axis=1)
        cols_to_keep = merge_temp.columns.tolist()
        print("cols to keep: ",cols_to_keep)
        #merge_temp.to_csv("/exports/reum/CKe/"+cohort1_name+"_compareA1.txt",sep='\t') #save after done with each cohort
    merge_temp['Uniqueness'] = "NotAvailable"
    merge_temp.to_csv(out,sep='\t')
    print("saved initial table!")
    return merge_temp
    
def getUnique(compareFile="compareA1.txt",out="compareA1_stat.txt"):
    merge_temp = pd.read_csv(compareFile,sep='\t',index_col=0)
    merge_temp.fillna("NotAvailable",inplace=True)
    list_unique = merge_temp['Uniqueness'].tolist()
    for index,row in merge_temp.iterrows():
        list_unique[index] = get_unique(row[1:-1])
    merge_temp['Uniqueness'] = list_unique
    lens = merge_temp['Uniqueness'].map(len)
    merge_temp[lens!=1].loc[:,['SNP','Uniqueness']].to_csv("duplist_all.txt",sep='\t',index=False) #save all duplicate snps, to exclude them, generate list for each cohort in jupyter
    merge_temp.to_csv(out,sep='\t')
    print("saved with uniqueness")
    # count how consistent the use of effect allele for each snp
    dict_count = {}
    unique_keys = lens.unique()
    for i in unique_keys:
        dict_count[i] = (lens==i).sum()
    return dict_count 
    
def unifyA1(cwd=os.getcwd(),compareFile="compareA1.txt"): #DEPRECATED
# make sure all snps across different cohorts use the same A1 effect allele (minor)
    merge_temp = pd.read_csv(compareFile,sep='\t',index_col=0)
    merge_temp.fillna("NotAvailable",inplace=True)
    #merge_temp.drop(['Unnamed: 0'],axis=1,inplace=True)
    dict_final = {}
    for i in range(merge_temp.shape[1]-2,0,-1): #if there's uniqueness col, start from merge_temp.shape[1]-2 in range. If with NMISS, ends at 1
    # make sure EIRA is the second last and Leeds is the last dict to be updated to final 
        dict_temp = merge_temp[merge_temp.iloc[:,i]!="NotAvailable"].iloc[:,[0,i]].set_index('SNP')
        name = dict_temp.columns.tolist()[0]
        dict_temp = dict_temp.to_dict('dict')[name]
        print("updating dict ",name)
        #dict_final = dict_final | dict_temp  # new function to merge dicts in python3.9
        dict_final.update(dict_temp)
    print("get A1 dict_final!")
    np.save("final_dict_A1.npy",dict_final)
    return dict_final
    
def unifyA2(cwd=os.getcwd(),compareFile="compareA2.txt"): #DEPRECATED
# make sure all snps across different cohorts use the same A1 effect allele (minor)
    merge_temp = pd.read_csv(compareFile,sep='\t',index_col=0)
    merge_temp.fillna("NotAvailable",inplace=True)
    #merge_temp.drop(['Unnamed: 0'],axis=1,inplace=True)
    dict_final = {}
    for i in range(merge_temp.shape[1]-2,0,-1): #if there's uniqueness col, start from merge_temp.shape[1]-2 in range. If with NMISS, ends at 1
    # make sure EIRA is the second last and Leeds is the last dict to be updated to final 
        dict_temp = merge_temp[merge_temp.iloc[:,i]!="NotAvailable"].iloc[:,[0,i]].set_index('SNP')
        name = dict_temp.columns.tolist()[0]
        dict_temp = dict_temp.to_dict('dict')[name]
        print("updating dict ",name)
        #dict_final = dict_final | dict_temp  # new function to merge dicts in python3.9
        dict_final.update(dict_temp)
    print("get A2 dict_final!")
    np.save("final_dict_A2.npy",dict_final)
    return dict_final

def updateAlleles(dict_a1,cwd=os.getcwd()): #generate text table for --reference-allele input
    loc_list = getloclist(os.getcwd(),".bim",("_A1corr.bim","_noDup.bim")) #change second param to get only raw files, len=13 (no leeds)
    for i in range(len(loc_list)):
        cohort_name = loc_list[i].split("/")[-3]
        print("reading cohort ",cohort_name)
        bim_cohort = pd.read_csv(loc_list[i],sep='\t',header=None)
        bim_cohort.rename(columns={0:"CHR",1:"SNP",3:"BP",4:"A1",5:"A2"},inplace=True)
        update_table = bim_cohort.loc[:,['SNP']]   
        if cohort_name != "Tacera": # convert snp id format to chr:bp
            bim_cohort['SNP']=bim_cohort['SNP'].str.split(":",expand=True)[0]+":"+bim_cohort['SNP'].str.split(":",expand=True)[1]
        #bim_cohort.drop_duplicates('SNP', keep = False, inplace=True) #move to further step
        update_table['corrA1'] = bim_cohort['SNP'].map(dict_a1)
        new_loc = loc_list[i].split(".")[0]+"_AllelesCorr.txt"
        update_table.to_csv(new_loc,sep='\t',index=False,header=False)
        print("work done on cohort ",cohort_name," count: ",bim_cohort.shape[0])
        
def updateAlleles_both(dict_a1,dict_a2,cwd=os.getcwd()): #generate text table for --update-alleles input
    loc_list = getloclist(os.getcwd(),".bim",("_A1corr.bim","_noDup.bim")) #change second param to get only raw files, len=13 (no leeds)
    for i in range(len(loc_list)):
        cohort_name = loc_list[i].split("/")[-3]
        print("reading cohort ",cohort_name)
        bim_cohort = pd.read_csv(loc_list[i],sep='\t',header=None)
        bim_cohort.rename(columns={0:"CHR",1:"SNP",3:"BP",4:"A1",5:"A2"},inplace=True)
        update_table = bim_cohort.loc[:,['SNP','A1','A2']]   
        if cohort_name != "Tacera": # convert snp id format to chr:bp
            bim_cohort['SNP']=bim_cohort['SNP'].str.split(":",expand=True)[0]+":"+bim_cohort['SNP'].str.split(":",expand=True)[1]
        #bim_cohort.drop_duplicates('SNP', keep = False, inplace=True) #move to further step
        update_table['corrA1'] = bim_cohort['SNP'].map(dict_a1)
        update_table['corrA2'] = bim_cohort['SNP'].map(dict_a2)
        new_loc = loc_list[i].split(".")[0]+"_AllelesCorr.txt"
        update_table.to_csv(new_loc,sep='\t',index=False,header=False)
        print("work done on cohort ",cohort_name," count: ",bim_cohort.shape[0])
        
def run_GWAS(cwd=os.getcwd()):
# run gwas script in each cohort
    loc_list = getloclist(os.getcwd(),".bim",("_A1corr.bim","_noDup.bim"))
    for run in loc_list:
        root = os.path.split(run)[0]
        os.system(root+"/Run_gwas.sh")
        
def meta_prepare(cwd=os.getcwd(), key="noNA.assoc.logistic", skip_key=" ", out_suffix="_noNA_maf_meta.txt",cohort_skip=[]):
# list of cohorts could be skipped:['EIRA', 'RAMS', 'Madrid', 'Manchester', 'Tacera', 'EARTH_B', 'Glasgow', 'ACPA', 'SERA', 'EARTH_A', 'PEAC', 'Vienna', 'EAC']
# detect noNA.assoc.logistic files and prepare them for meta-analysis
# get correct Minor allele a1, calculate BETA from OR, drop all biallelic snps
# to upgrade:exclude certain cohort
# Leeds is processed separately 
    loc_list = getloclist(os.getcwd(),key,skip_key)
    for run in loc_list: 
        cohort_name = run.split("/")[-3]
        if cohort_name not in cohort_skip:
            summary_origin = pd.read_csv(run,sep='\s+')
            BETA = np.log(summary_origin['OR'])
            summary_origin.insert(8,'BETA',BETA)
            SNP = summary_origin['SNP'].str.split(':',expand=True)[0]+":"+summary_origin['SNP'].str.split(':',expand=True)[1]+":"+summary_origin['A1']
            summary_origin['SNP'] = SNP
            if summary_origin['SNP'].duplicated().sum() != 0:
                print("duplicate snp detected in summary stat file! check for multiallelics?")
            summary_origin.drop_duplicates('SNP', keep = False, inplace=True)
            new_name = cohort_name + out_suffix
            new_loc = os.path.join(os.path.split(run)[0],new_name)
            summary_origin.to_csv(new_loc,sep='\t',index=0)
            print(cohort_name+": ",summary_origin.shape[0],"saved to: ",new_loc)
        else:
            print("skipping cohort",cohort_name)
           

# PLEZ PRETEND THIS IS THE __MAIN__ FUNCTION BELOW:
# A2 RELATED FUNCTION NOT NECESSARY       
      
#merge_temp1 = compareA1()
#merge_temp2 = compareA2()
#dict_final_a1 = unifyA1()
#dict_final_a2 = unifyA2()
#updateAlleles(dict_final_a1)
#run_GWAS(cwd="/exports/reum/CKe/Pipelinerun_withPC/")
#dict_count = getUnique(compareFile="compareA1.txt",out="compareA1_stat.txt")
#print(dict_count)

#meta_prepare(out_suffix="_noNA_noMAFfilter_MTX_meta.txt",key="noNA_noMAFfilter_MTX.assoc.logistic")
meta_prepare(out_suffix="_noNA_noMAFfilter_sDAI_meta.txt",key="noNA_noMAFfilter_sDAI.assoc.logistic")
meta_prepare(out_suffix="_noNA_noMAFfilter_cDAI_meta.txt",key="noNA_noMAFfilter_cDAI.assoc.logistic")