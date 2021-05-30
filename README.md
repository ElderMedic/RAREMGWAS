# RAstudy
## Content
focus on alternatieve methods for GWAS (e.g. capables of capturing things missed by GWAS): so more powerful method and secondly method that are able to identify combinations of genes or pathways.

这种技术路线有很多的局限性。首先，并不是生病组中的每个个体都有那些SNP突变，即那些SNP突变的发生与疾病并不是必然性的关系，而仅仅是一种概率。其次，基因突变有很多种，除了点突变之外，还有染色体畸变等等，而并不是任何疾病都是由SNP突变产生的。再三，很多疾病的产生并不是由于基因的改变，而是环境的影响

第一，鉴定driver gene，即哪些基因容易mutation；第二，从pathway的角度看mutation可能造成的影响。

主要针对大型家族进行分析。大型家族研究的优势在于，家族成员共有的基因突变更为普遍，也就更容易检测到。不过这样检测到的基因突变，可能在人群中并不常见。

TWAS and Meta-TWAS (transcriptome-wide association study)
Mendelian randomization
some other gwas results: over 10,000 complete GWAS summary datasets converted to this format (https://gwas.mrcieu.ac.uk).
summary association statistics
- fine mapping: conditional analysis of SNPs, conditional and joint multiple-SNP analysis (GCTA-COJO)
- causal inference
- colocalization analysis
- multi-trait analysis for pleiotropy 
- LDSC
- HDL
genome-wide polygenetic risk score(GPS)
incorprate other clinical data
other autoimmune disease data

meta analysis

Similar to what Mingdong's research finds out, GWAS findings sometimes do not explain heritability, for diseases hold 30%-80% heritability from twins and family study, GWAS gives no more than 5%-10%.[1] There're many theories explaining this problem including uncovered rare variants, complex associations/epistasis, lack of power(need more data), epigenetic effects, maybe a better way out is to continue and extend GWAS with further analysis. A preliminary study considering all SNPs simultaneously [2] can be conducted to prove heritability has been well detected. According to the results shared on GWAS catalog (https://www.ebi.ac.uk/gwas/efotraits/EFO_0000685), it's possible to find genes with significant P-val, and some genes identified by Mingdong are also annotated by other researchers. In another recent study on Covid-19 [3], GWAS is unable to improve on 6.5% heritability estimate, post-GWAS analyses like Mendelian randomization and transcriptome-wide association study (TWAS) with extra data considered are performed. Summary association statistics is a powerful and common evidence source to dissect the genetics of complex trait (like RA) which has a large number of causal variants with small effects. Inferences about causal relationships among traits (between RA and other autoimmune disease) also worths exploring.

References
1. Maher, Brendan. "Personal genomes: The case of the missing heritability." Nature News 456.7218 (2008): 18-21.
2. Yang, J., Benyamin, B., McEvoy, B. et al. Common SNPs explain a large proportion of the heritability for human height. Nat Genet 42, 565–569 (2010). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.608
3. Pairo-Castineira, E., Clohisey, S., Klaric, L. et al. Genetic mechanisms of critical illness in COVID-19. Nature 591, 92–98 (2021). https://doi-org.vu-nl.idm.oclc.org/10.1038/s41586-020-03065-y
4. 




