#!/usr/bin/env python
# coding: utf-8

# In[2]:


# slightly process metal output to draw manhattan plot
import pandas as pd
import os
import numpy as np
import sys

TBLfile = sys.argv[1]
summary_origin = pd.read_csv(TBLfile,sep='\s+')

summary_origin.sort_values("P-value", ascending=True, inplace=True)

suggestiveHits = summary_origin[summary_origin['P-value']<=1E-5]

#summary_origin.to_csv("/exports/reum/CKe/generic-metal/RunMeta/TophitsMeta.txt",sep='\t',index=0)


CHR = suggestiveHits['MarkerName'].str.split(":",expand=True)[0]
BP = suggestiveHits['MarkerName'].str.split(":",expand=True)[1]

suggestiveHits.insert(2,'CHR_POS',CHR+':'+BP)
root = os.path.split(TBLfile)[0]
suggestiveHits.to_csv(root+"/SuggestiveSnpsMeta.txt",sep='\t',index=0)