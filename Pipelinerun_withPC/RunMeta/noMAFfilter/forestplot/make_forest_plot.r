library(meta)
library(stringr)
args<-commandArgs(T)
#setwd(system("pwd", intern = T))
tophit <- read.table(args[1], head=FALSE)
or <- tophit$V7
p <- tophit$V13
se <-tophit$V8
logor <- log(or) #beta
study = str_extract(tophit$V1,"noMAFfilter/(.+)_noNA")
study = str_replace_all(study,"noMAFfilter/","")
study = str_replace_all(study,"_noNA","")
#study = c("ACPA","EAC","EARTHA","EARTHB","EIRA","GLASGOW","LEEDS","MADIRD","MANCHESTER","PEAC","RAMS","SERA","TACERA","VIENNA")
or.fem <- metagen(logor, se, sm = "OR")
count <- unlist(strsplit(args[1],"_"))[2]
png(paste(args[2],count,"_meta_forest_plot.png",sep = ""),, width = 2800, height = 2400, res = 300)
forest.meta(or.fem,studlab=study)
dev.off()
