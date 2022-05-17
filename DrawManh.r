library(qqman)
args<-commandArgs(T)
setwd(system("pwd", intern = T))
results_log <- read.table(args[1], head=TRUE)

#for individual cohort
jpeg(paste(args[2],"Logistic_manhattan.jpeg"))
manhattan(results_log,chr="CHR",bp="BP",p="P",snp="SNP", main = "Manhattan plot of individual cohort")
dev.off()

jpeg(paste(args[2],"QQ-Plot_logistic.jpeg"))
qq(results_log$P, main = "Q-Q plot of GWAS analysis p-values : log")
dev.off()

#for meta-analysis
#jpeg(paste(args[2],"Logistic_manhattan_meta.jpeg"))
#manhattan(results_log,chr="CHR",bp="BP",p="P-value",snp="SNP", main = "Manhattan plot: meta-analysis of 10 cohorts")
#dev.off()

#jpeg(paste(args[2],"QQ-Plot_logistic_meta.jpeg"))
#qq(results_log$P-value, main = "Q-Q plot of GWAS meta-analysis p-values : log")
#dev.off()
