for root, dirs, files in os.walk(os.getcwd()):
    for file in files:
        if file.endswith('_noNA_maf_meta.txt'):
            loc = os.path.join(root, file)
            loc_list.append(loc)

for i in loc_list:
    os.system("cp "+i+" /exports/reum/CKe/generic-metal/RunMeta/")

# can also be achieved by command:   
# find . -iname *_maf_meta.txt | xargs -i cp {} "/exports/reum/CKe/generic-metal/RunMeta/"