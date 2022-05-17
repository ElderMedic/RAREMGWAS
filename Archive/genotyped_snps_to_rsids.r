library(SNPlocs.Hsapiens.dbSNP144.GRCh37)

snp_locs <- SNPlocs.Hsapiens.dbSNP144.GRCh37

inputfile = commandArgs(trailingOnly = T)[1]
outputfile = commandArgs(trailingOnly = T)[2]


tmp <- read.delim(inputfile, header = F, stringsAsFactors = F)

tmp <- tmp[!tmp[,1] == "SNP",]

dat <- strsplit(tmp, ":")

dat <- do.call("rbind", dat)

dat <- split(dat[,2], as.factor(dat[,1]))

rsids <- vector()

invisible(
lapply(1:22, function(x){

	my_pos <- dat[[x]]
 
  snps_ref <- snpsBySeqname(snp_locs, c(as.character(x)))

	idx <- match(my_pos, start(snps_ref))

	rsids <<- append(rsids, mcols(snps_ref)$RefSNP_id[idx])
 
})
)

write.table(rsids, file = outputfile, row.names = F, col.names = F, quote = F)