#just to take a note of what's done on interactive terminal, code in this script have not actually run! 
#so no .sh script to run it

import numpy as np
import pandas as pd
from tqdm import tqdm,trange

summary_origin = pd.read_csv("/exports/reum/CKe/ACPA/mergedChr/ACPA_noNA_meta.txt",sep='\s+')
bimfile = pd.read_csv("/exports/reum/CKe/ACPA/mergedChr/ACPAneg_merged.bim",sep='\t',header=None)

