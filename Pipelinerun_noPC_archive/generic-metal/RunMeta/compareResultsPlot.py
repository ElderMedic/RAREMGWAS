import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import os
import numpy as np

from scipy.stats import gaussian_kde
from matplotlib.colors import LogNorm

#summary_origin = pd.read_csv("/exports/reum/CKe/generic-metal/RunMeta/METALforPlots_STDERR_noMiss.TBL",sep='\s+')
summary_origin = pd.read_csv("/exports/reum/CKe/generic-metal/RunMeta/METALforPlots_withTACERA_STDERR_noMiss.TBL",sep='\s+')
gwas_samantha = pd.read_csv("/exports/reum/CKe/generic-metal/RunMeta/gwas_version8_merged_simp.assoc.logistic",sep='\s+')

OR = np.exp(summary_origin['Effect'])
summary_origin.insert(6,'OR',OR)

Merged = pd.merge(summary_origin,gwas_samantha,left_on=['MarkerName'],right_on=['SNP'],how='inner')

print("Merge complete!\n")

#plt.figure(dpi=500)
plt.xlabel('CKe Meta-analysis')
plt.ylabel('Samantha GWAS on merged cohort')
# plt.xlim(xmax=10,xmin=0)
# plt.ylim(ymax=10,ymin=0)
# plt.xticks([])
# plt.yticks([])

# colors1 = '#00CED1'
# colors2 = '#DC143C'

plt.scatter(Merged['P-value'],Merged['P'],c='#DC143C',s=0.5)


#plt.legend()

#plt.savefig("/exports/reum/CKe/generic-metal/RunMeta/comparePlots.jpg",dpi=500)

#draw density plot with loop
#for i in range(0,50): 
#  split_index = i*100000
#  x = Merged['P-value'][split_index:split_index+100000]
#  y = Merged['P'][split_index:split_index+100000]
#  xy = np.vstack([x,y])
#  z = gaussian_kde(xy) 
#  z = np.reshape(z(xy).T, x.shape) 
#  idx = z.argsort()
#  x = x.reset_index(drop=True)
#  y = y.reset_index(drop=True)
#  x, y, z = x[idx], y[idx], z[idx]
#  plt.scatter(x, y,c=z,  s=1,cmap='Spectral')
#  print("run ",i," success!") 



# Calculate the point density
#x = Merged['P-value'][:100000]
#y = Merged['P'][:100000]

#print("Good xy!\n")
#xy = np.vstack([x,y])
#z = gaussian_kde(xy)
#z = np.reshape(z(xy).T, x.shape) 

#print("gaussian kde z got!\n")
 # Sort the points by density, so that the densest points are plotted last
#idx = z.argsort()
#x, y, z = x[idx], y[idx], z[idx]

#print("argsorted!\n")
#fig, ax = plt.subplots()
#plt.scatter(x, y,c=z,  s=20,cmap='Spectral')

#plt.colorbar()
#plt.show()
 
print("Got figure!\n")

# import seaborn as sns
#plot = sns.kdeplot(Merged['P-value'][:100000],Merged['P'][:100000],shade=True,cmap='Purples_d',cbar=True)
#plt.show()

#plt.savefig("/exports/reum/CKe/generic-metal/RunMeta/comparePlots_density_all.jpg",dpi=300)
plt.savefig("/exports/reum/CKe/generic-metal/RunMeta/comparePlots_withTACERA.jpg",dpi=300)

# Calculate the point density
x = Merged['P-value']
y = Merged['P']

print("Good xy!\n")
xy = np.vstack([x,y])
z = gaussian_kde(xy)
z = np.reshape(z(xy).T, x.shape) 

print("gaussian kde z got!\n")
# Sort the points by density, so that the densest points are plotted last
idx = z.argsort()
x, y, z = x[idx], y[idx], z[idx]

print("argsorted!\n")
fig, ax = plt.subplots()
plt.xlabel('CKe Meta-analysis')
plt.ylabel('Samantha GWAS on merged cohort')
plt.scatter(x, y,c=z,  s=1,cmap='Spectral')

plt.colorbar()
print("Got denstity plot!")
plt.savefig("/exports/reum/CKe/generic-metal/RunMeta/comparePlots_density_withTACERA.jpg",dpi=300)