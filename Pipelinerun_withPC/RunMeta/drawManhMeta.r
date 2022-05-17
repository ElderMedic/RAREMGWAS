library(qqman)
args<-commandArgs(T)
setwd(system("pwd", intern = T))
results_log <- read.table(args[1], head=TRUE, fill = TRUE)

jpeg(paste(args[2],"QQ-Plot_logistic_meta_STDERR.jpeg"))
qq(results_log$P.value, main = "Q-Q plot of GWAS meta-analysis of 11 cohorts p-values : log")
dev.off()

jpeg(paste(args[2],"Logistic_manhattan_meta_STDERR.jpeg"))
manhattan(results_log,chr="CHR", bp="BP", p="P.value",snp="MarkerName", main = "Manhattan plot: meta-analysis of 11 cohorts") #
dev.off()