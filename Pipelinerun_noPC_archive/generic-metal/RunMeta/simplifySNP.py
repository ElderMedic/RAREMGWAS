import pandas as pd
import numpy as np

# remove alleles in SNP col for all cohorts in order to be in accordance with tacera
# wrong way, deserted :) function already merged into meta_prepare.py


array_cohorts=["EARTH_B","EARTH_A","Madrid","RAMS","Vienna","EAC","SERA","EIRA","PEAC","ACPA"]

         
for run in array_cohorts:
    loc = "/exports/reum/CKe/generic-metal/RunMeta/"+run+"_noNA_meta.txt"
    summary_origin = pd.read_csv(loc,sep='\t')
    SNP = summary_origin['SNP'].str.split(':',expand=True)[0]+":"+summary_origin['SNP'].str.split(':',expand=True)[1]
    summary_origin['SNP'] = SNP
    new_loc = "/exports/reum/CKe/generic-metal/RunMeta/"+run+"_noNA_simp_meta.txt"
    summary_origin.to_csv(new_loc,sep='\t',index=0)