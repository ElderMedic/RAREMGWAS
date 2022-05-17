#just to take a note of what's done on interactive terminal, code in this script have not actually run! 
#so no .sh script to run it
#this script should work just the same as meta_prepare.py

import numpy as np
import pandas as pd


summary_origin = pd.read_csv("/exports/reum/CKe/Tacera/Final_imputed/noNA.assoc.logistic",sep='\s+')
bimfile = pd.read_csv("/exports/reum/CKe/Tacera/Final_imputed/TACERA_HRCv1_1_FINAL.bim",sep='\t',header=None)

temp = pd.merge(summary_origin,bimfile,how='left',left_on='SNP',right_on=1)
A2 = temp[5]
index_to_correct = temp[temp['A1']==temp[5]].index
A2[index_to_correct]=temp[4][index_to_correct]

BETA = np.log(summary_origin['OR'])

summary_origin.drop_duplicates('SNP', keep = False, inplace=True)
summary_origin.insert(4,'A2',A2)
summary_origin.insert(8,'BETA',BETA)
summary_origin.to_csv("/exports/reum/CKe/Tacera/Final_imputed/TACERA_noNA_maf_meta.txt",sep='\t',index=0)