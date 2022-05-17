## Identification of Genetic Factors for Remission of Rheumatoid Arthritis

**A meta-analysis of genome-wide association study on RA remission**

### Abstract
Rheumatoid arthritis (RA), a systemic, inflammatory autoimmune disorder characterized by inflammation of the lining or synovium of the joints, is a complex polygenic disease with a complicated inheritance mode. Previous research has found various aspects of the genetic contribution to the etiology, pathogenesis, and outcome of RA. Rapid diagnosis and a treat-to-target treatment are effective in controlling the progression of the disease and reducing the chance of disability; although many patients can achieve remission, however, some individuals fail to respond adequately to treatment. To study the genetic effect on reaching RA (early) remission, we performed a genome-wide association study and meta-analysis combining multiple cohorts. We identified one significant disease-associated SNP and 13 SNPs showing suggestive associations; they are functional annotated, mapped to gene, and enriched for pathway analysis. We discovered the RA-associated gene CLEC16A, and the findings suggest a link between Cardiomyopathy and RA. With the expectation to aid precision medicine for different patients, our study provided a theoretical basis for clinical diagnosis and treatment.

**Keywords**: GWAS, SNP, Rheumatoid Arthritis, remission, meta-analysis, functional annotation

### What is in this repo?
- jupyter notebooks as records and process reports, all python-based analysis were conducted in these notebooks and were visualized directly. Some of them were used to examine or check for certain facts or phenomenon.
- shell scripts combined with python and R script to run the whole pipeline or just components. (in shark only shell script can be submitted to job queue)
- shell scripts in each cohort to conduct individual GWAS
- log files as reference for steps not covered here, in case you need to know what happened.
- part of summary statistics and meta-analysis of them
- archive of steps taken but deprecated or not finished

#### How to replicate the pipeline?
- [x] Prepare .bim .fam .bed files and clinical files, or summary stat for cohorts in main working dir
- [x] Run GWASwithMetaPipeline_v4.py(preferred) or GWASwithMetaPipeline_v5.py (slight difference in how they work, for v4 you can interact with script in cmd, for v5 you have to modify the main func at the bottom), parameters specified will mute related process, at least 20min of 'time_to_wait' is recommended 
- [x] You need to run all scripts on LUMC SHARK cluster, it is designed for analysis to work with SHARK and SLURM effieciently.

#### Dependencies
Python: pandas, numpy, seaborn, tqdm, argparse, matplotlib. Latest versions and anaconda env are preferred.
R: qqman, meta, stringr
Other software: Plink 1.9p, metal(not necessary)

### Data Availability
Genetic and clinical data in all cohorts are not open to public now, projects based on these cohorts are actively ongoing. Please contact Marc Maurits m.p.maurits@lumc.nl for data access.  

### Correspondence
Changlin Ke, MSc student in Bioinformatics and system biology

VU & UvA

changlin.ke@student.uva.nl  c.ke@student.vu.nl
