import numpy as np
import pandas as pd
from tqdm import tqdm,trange


def chr_modify(x):
    chunks = x.split(":")
    new_chrpos = ":".join([chunks[0].lstrip("chr"),chunks[1]]) 
    return new_chrpos

bimfile = pd.read_csv("/exports/reum/CKe/Tacera/Final_imputed/TACERA_HRCv1_1_FINAL.bim",sep='\t',header=None)
#bimfile = pd.read_csv("/exports/reum/CKe/Tacera/By Chrom/ALL.pbwt_reference_impute.bim",sep='\t',header=None)

bimfile['SNP']=''

old_chrpos = bimfile[1][bimfile[1].str.startswith("chr")].apply(chr_modify)

#after got old_chrpos we fill snp and move on to rsids
bimfile['SNP']=old_chrpos

SNP = []
for index,row in tqdm(bimfile.iterrows()):
    if row[1].startswith("rs"):
        #print(SNP)
        SNP.append(str(row[0])+":"+str(row[3]))
        #time.sleep(1)
    else:
        SNP.append(row['SNP'])

bimfile[1] = SNP
print("nan left in bim snpid: ",bimfile[1].isna().sum())
bimfile.drop(['SNP'],axis=1,inplace=True)

#no idea why but somehow two rows can't match, guess missing in original bim, process manually
bimfile.iloc[8406415,1]='6:30704986'
bimfile.iloc[8431384,1]='6:32632749'

bimfile.to_csv("TACERA_HRCv1_1_FINAL_sorted.bim",sep='\t',header=None,index=None)
#bimfile.to_csv("TACERA_byChrom.bim",sep='\t',header=None,index=None)