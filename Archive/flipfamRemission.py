import pandas as pd
import os
import numpy as np

#correct remission indicatiors in .fam files, case=2 control=1
#not for tacera/leeds
# Update 2022.1.17, this script did not work for several cohorts.

loc_list = []
for root, dirs, files in os.walk(os.getcwd()):
    for file in files:
        if file.endswith('_merged.fam'):
            loc = os.path.join(root, file)
            loc_list.append(loc)

for run in loc_list:
    for i in run.split('/'):
        if (i != 'mergedChr') and (i != 'Final_imputed'):
            cohort = i
        else:
            break       
    famfile = pd.read_csv(run,sep='\s',header=None)
    index_case = famfile[5]==1
    index_control = famfile[5]==2
    famfile.loc[index_case,5] = 2
    famfile.loc[index_control,5] = 1
    new_name = cohort + "_merged.fam"
    new_loc = os.path.join(os.path.split(run)[0],new_name)
    print("complete for cohort:",cohort," file save to:",new_loc)
    famfile.to_csv(new_loc,sep=' ',header=None,index=None)
