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

Similar to what Mingdong's research finds out, GWAS findings sometimes do not explain heritability, for diseases hold 30%-80% heritability from twins and family study, GWAS gives no more than 5%-10%.[1] There're many theories explaining this problem including uncovered rare variants, complex associations/epistasis, lack of power(need more data), epigenetic effects, maybe a better way out is to continue and extend GWAS with further analysis. A preliminary study considering all SNPs simultaneously [2] can be conducted to prove heritability has been well detected. According to the results shared on GWAS catalog (https://www.ebi.ac.uk/gwas/efotraits/EFO_0000685), it's possible to find genes with significant P-val, and some genes identified by Mingdong are also annotated by other researchers. 

In another recent study on Covid-19 [3], GWAS is unable to improve on 6.5% heritability estimate, post-GWAS analyses like Mendelian randomization and transcriptome-wide association study (TWAS) with extra data considered are performed, integration of eQTL is a direction to find causal genes[9]. Summary association statistics is a powerful and common evidence source to dissect the genetics of complex trait (like RA) which has a large number of causal variants with small effects. Combining our current GWAS result with other existing GWAS archive on ieu open gwas project [5] (https://gwas.mrcieu.ac.uk/, a database of 184,790,518,159 genetic associations from 39,603 GWAS summary datasets) enables many further analyses including:
1. Fine-mapping: conditional and joint multiple-SNP analysis (GCTA-COJO, SOJO)[6,7].
2. Inferences about causal relationships and genetic correlations among traits (between RA and other autoimmune disease or BMI, smoking history...) also worths exploring[8]. 
3. GWAS meta-analysis: p-val, bayes...
4. heritability from summary statistics: LD Score regression [10]. Partitioning heritability by functional annotation [11].

Complex traits are often controlled by multiple genes, and there are interactions between genes. Many GWAS methods only consider monogenic, traditional detection methods are based on regression analysis to perform statistical tests on all gene combinations, they require a lot of time and are difficult to process high-dimensional data. Multifactor Dimensionality Reduction, derived from machine learning, first considers all possible combinations of reciprocal loci and treats these combinations as a series of polygenic factors, then integrates the available data into a new variable and uses the phenotypic information to classify genotypes into low and high risk[14]. Another way to solve the problem of low effect size is implementing Genome-wide polygenic risk scores(GPS), GPS can find a lot more patients at high disease risk than clinical application simply relying on monogenic mutations[12,13].

References
1. Maher, Brendan. "Personal genomes: The case of the missing heritability." Nature News 456.7218 (2008): 18-21.
2. Yang, J., Benyamin, B., McEvoy, B. et al. Common SNPs explain a large proportion of the heritability for human height. Nat Genet 42, 565–569 (2010). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.608
3. Pairo-Castineira, E., Clohisey, S., Klaric, L. et al. Genetic mechanisms of critical illness in COVID-19. Nature 591, 92–98 (2021). https://doi-org.vu-nl.idm.oclc.org/10.1038/s41586-020-03065-y
4. Pasaniuc, B., Price, A. Dissecting the genetics of complex traits using summary association statistics. Nat Rev Genet 18, 117–127 (2017). https://doi-org.vu-nl.idm.oclc.org/10.1038/nrg.2016.142
5. Lyon, M.S., Andrews, S.J., Elsworth, B. et al. The variant call format provides efficient and robust storage of GWAS summary statistics. Genome Biol 22, 32 (2021). https://doi.org/10.1186/s13059-020-02248-0
6. Yang, J., Ferreira, T., Morris, A. et al. Conditional and joint multiple-SNP analysis of GWAS summary statistics identifies additional variants influencing complex traits. Nat Genet 44, 369–375 (2012). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.2213
7. Ning Z, Lee Y, Joshi PK, Wilson JF, Pawitan Y, Shen X. A Selection Operator for Summary Association Statistics Reveals Allelic Heterogeneity of Complex Traits. Am J Hum Genet. 2017;101(6):903-912. doi:10.1016/j.ajhg.2017.09.027
8. Pickrell, J., Berisa, T., Liu, J. et al. Detection and interpretation of shared genetic influences on 42 human traits. Nat Genet 48, 709–717 (2016). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.3570
9. Zhu, Z., Zhang, F., Hu, H., Bakshi, A., Robinson, M. R., Powell, J. E., ... & Yang, J. (2016). Integration of summary data from GWAS and eQTL studies predicts complex trait gene targets. Nature genetics, 48(5), 481-487.
10. Bulik-Sullivan, B., Loh, PR., Finucane, H. et al. LD Score regression distinguishes confounding from polygenicity in genome-wide association studies. Nat Genet 47, 291–295 (2015). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.3211
11. Finucane, H., Bulik-Sullivan, B., Gusev, A. et al. Partitioning heritability by functional annotation using genome-wide association summary statistics. Nat Genet 47, 1228–1235 (2015). https://doi-org.vu-nl.idm.oclc.org/10.1038/ng.3404
12. Khera, A. V., Chaffin, M., Wade, K. H., Zahid, S., Brancale, J., Xia, R., ... & Kathiresan, S. (2019). Polygenic prediction of weight and obesity trajectories from birth to adulthood. Cell, 177(3), 587-596.
13. Khera, A.V., Chaffin, M., Aragam, K.G. et al. Genome-wide polygenic scores for common diseases identify individuals with risk equivalent to monogenic mutations. Nat Genet 50, 1219–1224 (2018). https://doi-org.vu-nl.idm.oclc.org/10.1038/s41588-018-0183-z
14. Damian Gola, Jestinah M. Mahachie John, Kristel van Steen, Inke R. König, A roadmap to multifactor dimensionality reduction methods, Briefings in Bioinformatics, Volume 17, Issue 2, March 2016, Pages 293–308, https://doi.org/10.1093/bib/bbv038
















