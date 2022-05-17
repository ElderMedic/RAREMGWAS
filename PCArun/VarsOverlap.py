# Title     : Find common SNPS
# Objective : Look for common SNP's in multiple .BIM files (plink files) and give a list of chr:position as output
# Input     : .bim file(s)
# Output    : One .txt file with CHR:POSITION from the common snps
# Created by: Samantha Jurado Zapata
# Created on: 03-9-2020
# updated oct 18 C.Ke

import time

def import_cohorts(cohort_name):
    #Open the cohort file and read it, splitting on tab and taking the 2nd word (variant ID) and putting these in a list
    import_name = cohort_name+".bim"
    variantID_list = []
    with open(import_name, "r") as ch_name:
        for line in ch_name:
            variantID = line.strip().split("\t")[1:2]
            variantID_list.append(variantID[0].split(':')[0]+":"+variantID[0].split(':')[1])
    print("Length list variantID's", cohort_name, len(variantID_list))
    return variantID_list

def matcher():
    #Call the import function for the cohorts you want to match with eachother. Make sets of the lists that are returned.
    EA127 = import_cohorts("/exports/reum/CKe/EARTH_A/mergedChr/EA127genotypes_merged")
    ACPA = import_cohorts("/exports/reum/CKe/ACPA/mergedChr/ACPAneg_merged")
    rams = import_cohorts("/exports/reum/CKe/RAMS/mergedChr/RAMS_merged")
    EAC = import_cohorts("/exports/reum/CKe/EAC/mergedChr/EAC_merged")
    madrid = import_cohorts("/exports/reum/CKe/Madrid/mergedChr/madrid_merged")
    EARTH_setB = import_cohorts("/exports/reum/CKe/EARTH_B/mergedChr/EARTH_setB_merged")
    sera = import_cohorts("/exports/reum/CKe/SERA/mergedChr/sera_merged")
    vienna = import_cohorts("/exports/reum/CKe/Vienna/mergedChr/vienna_merged")
    PEAC = import_cohorts("/exports/reum/CKe/PEAC/mergedChr/PEAC_merged")
    EIRA = import_cohorts("/exports/reum/CKe/EIRA/mergedChr/EIRA_merged")
    Tacera = import_cohorts("/exports/reum/CKe/Tacera/Final_imputed/TACERA_HRCv1_1_FINAL")
    ref = import_cohorts("/exports/reum/knevel_lab/Scripts_Samantha/PCA_files/G1000/G1000.chr_merged")

    snplist = list(set(ACPA) & set(rams) & set(EAC) & set(madrid) & set(sera) & set(EA127) & set(EARTH_setB) & set(vienna) & set(PEAC) & set(EIRA) & set(Tacera) 
                   & set(ref))

    print("Common variants: ", len(snplist))

    #We want only the chr [0] and name [1] and not the actual snp ref/alt
    snplist_chr_start_fin = []
    for i in snplist:
        snplist_chr_start_fin.append(i)

    snplist_chr_start_fin = sorted(snplist_chr_start_fin)

    with open("/exports/reum/CKe/PCArun/snplist.txt", "w") as snp:
        snp.write("\n".join(snplist_chr_start_fin))

def check_file():
    # Print the first 50 lines of snplist.txt (it wont unpack the whole file, so you can open this safely
    # without worrying of the size)
    print("\nFirst 50 lines of snplist.txt")
    with open("/exports/reum/CKe/PCArun/snplist.txt", "r") as id:
        head = [next(id) for x in range(50)]
        [print(x) for x in head]



def main():
    # Record the time it takes to run the whole program
    start_time = time.time()

    # Get the snps that the cohorts have and put them in a new file called "snplist.txt"
    matcher()
    check_file()

    print("--- runtime %s seconds ---" % (time.time() - start_time))
main()