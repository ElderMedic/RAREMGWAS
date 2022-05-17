#!/usr/bin/env python
# coding: utf-8
# GWAS and Meta pipeline v4
# ### GWAS and Meta-analysis pipeline
# cohorts: ALL Cohorts

# In[3]:


import sys
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from tqdm import trange,tqdm
import argparse
import time
import random


# copy files from cohorts dir to generic-metal for meta-analysis
# can also be achieved by command:   
# find . -iname *_maf_meta.txt | xargs -i cp {} "/exports/reum/CKe/generic-metal/RunMeta/"
def autoCopyPaste(end='_noNA_maf_meta.txt',cwd=os.getcwd(),to="/exports/reum/CKe/generic-metal/RunMeta/"):
    loc_list=[]
    for root, dirs, files in os.walk(cwd):
        for file in files:
            if file.endswith(end):
                loc = os.path.join(root, file)
                loc_list.append(loc)
    for i in loc_list:
        os.system("cp "+i+" "+to)
    os.system("mv "+mainwk+"/RunMeta/"+"EARTH_A_noNA_maf_meta.txt "+mainwk+"/RunMeta/"+"EARTHA_noNA_maf_meta.txt")
    os.system("mv "+mainwk+"/RunMeta/"+"EARTH_B_noNA_maf_meta.txt "+mainwk+"/RunMeta/"+"EARTHB_noNA_maf_meta.txt") #WHY WOULD ANYONE INCLUDE A DAMN UNDERSCORE IN THEIR COHORT NAME, DON'T DO THIS ANYMORE! 

# In[3]:


def run_GWAS(cwd=os.getcwd()):
# run gwas script in each cohort
    loc_list = []
    for root, dirs, files in os.walk(cwd):
        for file in files:
            if file.endswith('.bed'):
                loc_list.append(root)
    for run in loc_list:
        os.system(run+"/Run_gwas.sh")


# In[4]:


def meta_prepare(cwd=os.getcwd(),dosage="/exports/reum/CKe/Leeds/old_dosage_file/mergedCHR.assoc.dosage"):
# detect noNA.assoc.logistic files and prepare them for meta-analysis not applicable for leeds
# get correct major allele A2, calculate BETA from OR, drop all biallelic snps
# to upgrade:exclude certain cohort
    loc_list = []
    write_log(cwd)
    for root, dirs, files in os.walk(cwd):
        for file in files:
            if file.endswith('noNA.assoc.logistic'): # detected noNA.assoc.logistic fiies are generated by awk in Run_gwas.sh
                loc = os.path.join(root, file)
                loc_list.append(loc)
    for run in loc_list:
        for i in run.split('/'):
            if (i != 'mergedChr') and (i != 'Final_imputed'):
                cohort = i
            else:
                break
        if cohort == 'Tacera': 
            summary_origin = pd.read_csv(run,sep='\s+')
            bimfile = pd.read_csv(os.path.split(run)[0]+'/TACERA_HRCv1_1_FINAL.bim',sep='\t',header=None)
            temp = pd.merge(summary_origin,bimfile,how='left',left_on='SNP',right_on=1)
            A2 = temp[5]
            index_to_correct = temp[temp['A1']==temp[5]].index
            A2[index_to_correct]=temp[4][index_to_correct]
            BETA = np.log(summary_origin['OR'])
            summary_origin.drop_duplicates('SNP', keep = False, inplace=True)
            summary_origin.insert(4,'A2',A2)
            summary_origin.insert(8,'BETA',BETA)
            write_log(cohort+": ",summary_origin.shape[0])
            summary_origin.to_csv(os.path.split(run)[0]+'/TACERA_noNA_maf_meta.txt',sep='\t',index=0)
        elif cohort == 'Leeds':
            summary_origin = pd.read_csv(run,sep='\s+')
            summary_origin.drop(summary_origin[summary_origin['OR']=='OR'].index,axis=0,inplace=True) #remove duplicated col names after concatenate gwas outputs
            dosage_file = pd.read_csv(dosage,sep='\s+')
            dosage_file.drop(dosage_file[dosage_file['OR']=='OR'].index,axis=0,inplace=True)
            temp = pd.merge(summary_origin,dosage_file,how='left',on='SNP')
            A2=temp['A2']
            BETA=np.log(np.array(summary_origin['OR'], dtype=float))
            summary_origin.insert(4,'A2',A2)
            summary_origin.insert(8,'BETA',BETA)
            summary_origin['CHR']=summary_origin['SNP'].str.split(':',expand=True)[0]
            summary_origin['BP']=summary_origin['SNP'].str.split(':',expand=True)[1]
            summary_origin.drop_duplicates('SNP', keep = False, inplace=True)
            new_name = cohort + "_noNA_maf_meta.txt"
            new_loc = os.path.join(os.path.split(run)[0],new_name)
            write_log(cohort+": ",summary_origin.shape[0])
            summary_origin.to_csv(new_loc,sep='\t',index=0)
        else:
            summary_origin = pd.read_csv(run,sep='\s+')
#             write_log(summary_origin['SNP'].str.split(':'))
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
            write_log(cohort+": ",summary_origin.shape[0])
            summary_origin.to_csv(new_loc,sep='\t',index=0)
    write_log("Done meta prepare!")


# In[63]:


# os.chdir("/exports/reum/CKe/Pipeline_GO/")
#meta_prepare()


# In[4]:


def get_unique(x): # which alleles are used in all cohorts for a snp
    u = list(x.unique())
    while np.nan in u:
        u.remove(np.nan)
    u = "".join(map(str,u))
    return u


# In[5]:


def compareA1(cwd=os.getcwd(),out="/exports/reum/CKe/compareA1.txt"):
    #detects prepared inputs of METAL in cwd and generate a table comparing A1s used
    loc_list = []
    for root, dirs, files in os.walk(cwd):
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
        write_log("cols to keep: ",cols_to_keep)
        #merge_temp.to_csv("/exports/reum/CKe/"+cohort1_name+"_compareA1.txt",sep='\t')
        #below parts for processing compareA1
    merge_temp['Uniqueness'] = 'NA'
    list_unique = merge_temp['Uniqueness'].tolist()
    count_inconsistent = 0
    for index,row in merge_temp.iterrows():
        list_unique[index] = get_unique(row[2:-1])
        if len(list_unique[index]) != 1:
            count_inconsistent += 1
    merge_temp['Uniqueness'] = list_unique
    merge_temp.to_csv(out,sep='\t')
    # count how consistent the use of effect allele for each snp
    list_u = list_unique
    dict_count = {}
    for i in range(len(list_u)):
        list_u[i] = list_u[i].replace("nan","")
        if len(list_u[i]) in dict_count:
            dict_count[len(list_u[i])] += 1
        else:
            dict_count[len(list_u[i])] = 1
#             write_log(list_u[i])
    return merge_temp, dict_count


# In[7]:


def unifyA1(compareFile="/exports/reum/CKe/compareA1.txt",metaDir="/exports/reum/CKe/generic-metal/RunMeta/"):
# make sure all snps across different cohorts use the same A1 effect allele (minor)
    array_cohorts=["EARTHB","EARTHA","Madrid","RAMS","Vienna","EAC","SERA","EIRA","PEAC","ACPA","TACERA","Leeds"] #actual cohort name
    #array_cohorts=["EAC","TACERA"]
    merge_temp = pd.read_csv(compareFile,sep='\t')
    merge_temp.drop(['Unnamed: 0'],axis=1,inplace=True)
    dict_final = {}
    for i in range(2,merge_temp.shape[1]-1): #start from 2 if with NMISS col. if there's uniqueness col then -1 in range
        dict_temp = merge_temp[merge_temp.iloc[:,i].isnull()!=True].iloc[:,[0,i]].set_index('SNP')
        name = dict_temp.columns.tolist()[0]
        dict_temp = dict_temp.to_dict('dict')[name]
        #dict_final = dict_final | dict_temp  #new function to merge dicts in python3.9
        dict_final.update(dict_temp)

    write_log("get dict_final!")
    #df_dict = pd.DataFrame(dict_final,index=range(15709515)) #skipped, too computationaly expensive

    for run in array_cohorts:
        loc = metaDir+run+"_noNA_maf_meta.txt"
        summary_origin = pd.read_csv(loc,sep='\t')
        summary_origin['A1'] = summary_origin['SNP'].map(dict_final) 
        new_loc = metaDir+run+"_noNA_A1corr_maf_meta.txt"
        summary_origin.to_csv(new_loc,sep='\t',index=0)
        write_log("work done on cohort ",run," count: ",summary_origin.shape[0])


def filterbySample(comparison,cwd=os.getcwd(),metaJob='METALresult_refEIRA_A1corr_maf_withPC1.TBL',out="METALresult_filtered.TBL"):
    #optional: filter out snps in metal result with less than 4000 patients supporting
    METALresult = pd.read_csv(metaJob,sep='\s+')
    merged = pd.merge(METALresult,comparison,left_on="MarkerName",right_on="SNP",how="left")
    index_postqc = merged[merged['NMISS']>=4000].index
    CHR = METALresult['MarkerName'].str.split(":",expand=True)[0]
    BP = METALresult['MarkerName'].str.split(":",expand=True)[1]
    METALresult.insert(1,'BP',BP)
    METALresult.insert(2,'CHR',CHR)
    summary_proc = METALresult.iloc[index_postqc,:]
    write_log("saving file to ",cwd+"/"+out)
    summary_proc.to_csv(cwd+"/"+out,sep='\t',index=0)


# In[7]:


def ManhandQQplotforMeta(cwd=os.getcwd(),metaJob='METALresult_filtered.TBL'):
# Due to problem in SHARK, this function may not work properly.
    meta_result = cwd+"/"+metaJob
    write_log("saving plots to: ",cwd)
    os.system("sbatch drawManhMeta.sh" +" "+meta_result+" "+cwd)
    write_log("Manh&QQ-plot submitted for metal result!")

# Before running in a new env and path, Check and Change paths and file names
def main(file_towrite,mainwk=os.getcwd(),GWAS=True,metaPrepare=True,makeA1compare=True,correctA1=True,meta=True,postmeta=True,time_to_wait=1200):
    #write_log("cwd: ",mainwk)
    file_towrite = mainwk+file_towrite
    os.chdir(mainwk)
    if GWAS:
        run_GWAS(cwd=mainwk)
        #os.system("sbatch DrawManh.sh")
    if metaPrepare:
        meta_prepare(cwd=mainwk)
        if not os.path.exists(mainwk+"/RunMeta/"):
            os.makedirs(mainwk+"/RunMeta/")
            write_log("created RunMeta folder!") # BE ADVISED: THIS IS NOT ORIGINALLY USED RunMeta location! check CKE/generic-metal/RunMeta for legacy files.
    if makeA1compare:
        autoCopyPaste(end='_noNA_maf_meta.txt',cwd=mainwk,to=mainwk+"/RunMeta/")
        merge_temp, dict_count = compareA1(cwd=mainwk+"/RunMeta",out=mainwk+"/compareA1.txt")
        write_log(dict_count)
    if correctA1:    
        unifyA1(compareFile=mainwk+"/compareA1.txt",metaDir=mainwk+"/RunMeta/")
    if postmeta:
        try:
            write_log(merge_temp.shape)
        except NameError:
            merge_temp = pd.read_csv(mainwk+"/compareA1.txt",sep='\t')
    if meta:
        os.chdir(mainwk+"/RunMeta")
        mainwk=os.getcwd()
        os.system("sbatch run_metal.sh")
        if postmeta:
            time.sleep(time_to_wait) #spare some time (20min) to run metal
    if postmeta:
        if not meta:
            os.chdir(mainwk+"/RunMeta")
        filterbySample(merge_temp,metaJob="METALresult_refEIRA_A1corr_maf1.TBL")
        ManhandQQplotforMeta()


def parse_args():
    """
        Parses inputs from the commandline.
        :return: inputs as a Namespace object
    """
    parser = argparse.ArgumentParser(description='Generates pipeline')
    # Arguments
    parser.add_argument('-wk', help='working directory,ends with / ',default=os.getcwd())
    parser.add_argument('--GWAS', help='exclude GWAS running',action="store_false")
    parser.add_argument('--metaPrepare', help='exclude metaPrepare procedure',action="store_false")
    parser.add_argument('--makeA1compare', help='exclude makeA1compare procedure',action="store_false")
    parser.add_argument('--correctA1', help='exclude correctA1 procedure',action="store_false")
    parser.add_argument('--meta', help='exclude meta-analysis',action="store_false")
    parser.add_argument('--postmeta', help='exclude post-meta analysis and visualize procedure',action="store_false")
    parser.add_argument('-t','--timetowait', help='time(sec) to wait after meta-analysis before further steps',default=1200)
    parser.add_argument('-f','--file_towrite', help='location of log file for the pipeline run',default='log_pipeline.txt')
    return parser.parse_args()

def update_loc(file_towrite):
    def decorator(func):
        def wrapper(*args,**kwargs):
            return func(*args,**kwargs,file_towrite=file_towrite)
        return wrapper
    return decorator

@update_loc(file_towrite=parse_args().file_towrite)
def write_log(*text,file_towrite="log_pipeline.txt"):
#to get real-time feedback from SHARK (submitted) job, log file is generated and updated. If it malfunctions, do not enable.
    to_print = " ".join([str(i) for i in text])
    if file_towrite == "log_pipeline.txt":
        file_towrite = str(random.randint(1000,10000))+file_towrite    
    os.system("echo "+ "\"" + to_print +"\" >> "+file_towrite)
    
# In[5]:


if __name__ == "__main__":
    args = parse_args()
    mainwk = args.wk
    GWAS = args.GWAS
    metaPrepare = args.metaPrepare
    makeA1compare = args.makeA1compare
    correctA1 = args.correctA1
    meta = args.meta
    postmeta = args.postmeta
    time_to_wait = args.timetowait
    file_towrite = args.file_towrite
    write_log("Hi! For this GwasMeta Run, the parameters of your choice: \n")
    write_log("mainWorkingDir: ",mainwk,"GWAS:",GWAS,"METAPREPARE:",metaPrepare,"MAKEA1COMPARE:",makeA1compare,"CORRECTA1:",correctA1,"META:",meta,"TIME TO WAIT FOR METAL(s):",time_to_wait,"POST META:",postmeta,"log file loc:",file_towrite)
    main(file_towrite,mainwk,GWAS,metaPrepare,makeA1compare,correctA1,meta,postmeta,time_to_wait)


