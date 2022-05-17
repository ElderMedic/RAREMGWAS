#process filtered.tbl file to get snp-loc input and sample sizes for MAGMA
#DEPRECATED: already incorporated in pipeline script
import numpy as np
import pandas as pd
import os,sys,time

tblfile=pd.read_csv("/exports/reum/CKe/RunMeta/METALresult_filtered.TBL",sep='\t')
inputfile=tblfile.loc[:,['MarkerName','CHR','BP']]
A1compare=pd.read_csv("/exports/reum/CKe/compareA1.txt",sep='\t')
merge=pd.merge(tblfile,A1compare,left_on="MarkerName",right_on="SNP",how="left")
tblfile['NMISS']=merge['NMISS']

inputfile.to_csv("/exports/reum/CKe/gene_analysis/Metal_snploc_samplesize.txt",header=0,index=0,sep='\t')
tblfile.to_csv("/exports/reum/CKe/gene_analysis/METALresult_filtered_withSamplesize.TBL",sep='\t',index=0)