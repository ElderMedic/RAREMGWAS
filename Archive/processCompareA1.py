from tqdm import tqdm,trange
import pandas as pd
import numpy as np

def get_unique(x): # which alleles are used in all cohorts for a snp
     u = list(x.unique())
     while np.nan in u:
             u.remove(np.nan)
     u = "".join(map(str,u))
     return u

merge_temp = pd.read_csv("/exports/reum/CKe/compareA1.txt",sep='\t')
merge_temp.drop(['Unnamed: 0'],axis=1,inplace=True)
#merge_temp.set_index("SNP",inplace=True)
merge_temp['Uniqueness'] = 'NA'
list_unique = merge_temp['Uniqueness'].tolist()

count_inconsistent = 0

for index,row in merge_temp.iterrows():
    list_unique[index] = get_unique(row[2:-1])
    if len(list_unique[index]) != 1:
        count_inconsistent += 1
    
merge_temp['Uniqueness'] = list_unique
merge_temp.to_csv("/exports/reum/CKe/compareA1_Unique.txt",sep='\t')

# count how consistent the use of effect allele for each snp
list_u = list_unique
dict_count = {}
for i in trange(len(list_u)):
    list_u[i] = list_u[i].replace("nan","")
    if len(list_u[i]) in dict_count:
        dict_count[len(list_u[i])] += 1
    else:
        dict_count[len(list_u[i])] = 1
        print(list_u[i])
        
print(dict_count)

#primary dictionary powered by EIRA, 13,168,462 key-values
#dict_EIRA = merge_temp.loc[merge_temp['A1_EIRA'].isnull()!=True,['A1_EIRA','SNP']].set_index("SNP")
#dict_EIRA = dict_EIRA.to_dict("dict")
##How to make a query
##dict_EIRA['A1_EIRA']['1:730087'] 
##'C'

#secondary dict by TACERA, 5,307,301 key-values
#dict_TACERA = merge_temp.loc[merge_temp['A1_TACERA'].isnull()!=True,['A1_TACERA','SNP']].set_index("SNP")
#dict_TACERA = dict_TACERA.to_dict('dict')

#dict_final = {}

#for i in range(1,merge_temp.shape[1]-1): #if there's uniqueness col then -1 in range
#    dict_temp = merge_temp[merge_temp.iloc[:,i].isnull()!=True].iloc[:,[0,i]].set_index('SNP')
#    name = dict_temp.columns.tolist()[0]
#    dict_temp = dict_temp.to_dict('dict')[name]
#    dict_final = dict_final | dict_temp #new function to merge dicts in python3.9

#df_dict = pd.DataFrame(dict_final,index=range(15709515))
