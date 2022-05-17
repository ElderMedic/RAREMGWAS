library(SNPlocs.Hsapiens.dbSNP144.GRCh37)

snp_locs <- SNPlocs.Hsapiens.dbSNP144.GRCh37
inputfile = commandArgs(trailingOnly = T)[1]
dat <- read.delim(paste0(inputfile), header = F, stringsAsFactors = F)
#my_pos <- dat[,2]
#snps_ref <- snpsBySeqname(snp_locs, c(as.character(1:22)))

#idx <- match(my_pos, start(snps_ref))
#rsids <- mcols(snps_ref)$RefSNP_id[idx]
#dat[!is.na(rsids),2] <- rsids[!is.na(rsids)]
 
#write.table(dat, file = paste0(inputfile,"_rsids.txt"), quote = F, col.names = F, row.names = F)

#convert bim rsid to loc
my_rsid <- dat[,2]
my_snps <- snpsById(snp_locs,c(my_rsid),ifnotfound="drop")
write.table(my_snps, file = paste0(inputfile,"_chrbp.txt"), quote = F, col.names = F, row.names = F)