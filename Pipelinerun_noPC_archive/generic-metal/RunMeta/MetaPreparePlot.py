#!/usr/bin/env python
# coding: utf-8

# In[2]:


# slightly process metal output to draw manhattan plot
# update: modified file names to include tacera
import pandas as pd
import os
import numpy as np


summary_origin = pd.read_csv("/exports/reum/CKe/generic-metal/RunMeta/METALresult_refEIRA_flipped_A1corr_maf1.TBL",sep='\s+')


# summary_origin


CHR = summary_origin['MarkerName'].str.split(":",expand=True)[0]
BP = summary_origin['MarkerName'].str.split(":",expand=True)[1]

summary_origin.insert(1,'BP',BP)
summary_origin.insert(2,'CHR',CHR)

summary_proc = summary_origin[summary_origin['Direction'].str.contains('\?')==False]


summary_proc.to_csv("/exports/reum/CKe/generic-metal/RunMeta/METALresult_refEIRA_flipped_A1corr_maf1_noMiss.TBL",sep='\t',index=0)

