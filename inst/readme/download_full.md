
## Files with full database

We recommend that you use these files for analysis of metabarcoding data.

[Information about format of files.](https://pr2-database.org/documentation/pr2-files/)

Each version has a 3 number code: version_x.y.z, e.g. 5.0.0

---
### Files for metabarcoding assignement

#### File for [dada2](https://benjjneb.github.io/dada2/index.html)
* **[pr2_version_x.y.z_SSU_dada2.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU_dada2.fasta.gz)** 

#### Files for [Mothur](https://mothur.org/) or [Qiime](http://qiime.org/)
**Note** :Qiime only use 7 taxonomical levels by default.
* **[pr2_version_x.y.z_SSU_mothur.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU_mothur.fasta.gz)**: sequences in fasta format with accession in description line
* **[pr2_version_x.y.z_SSU_mothur.tax.gz](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU_mothur.tax.gz)**: taxonomy of each sequence separated from the accession number by a tabulation

#### File for [USEARCH](http://www.drive5.com/usearch/) or [VSEARCH](https://github.com/torognes/vsearch) 
Fasta file with accession number and full taxonomy on the description line in the UTAX format.
* **[pr2_version_x.y.z_SSU_UTAX.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU_UTAX.fasta.gz)**: 

#### [DECIPHER](http://www2.decipher.codes/) training set
File can be used with the DECIPHER IDTaxa function to assign metabarcodes. Use the readRDS() function of R to load the file.
* **[pr2_version_x.y.z_SSU.decipher.trained.rds](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU.decipher.trained.rds)**

---

### Other files

#### Taxonomy structure
* **[pr2_version_x.y.z_taxonomy.xlsx](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_taxonomy.xlsx)** 

#### Fasta file
Accession number, the name of  sequence and  full taxonomy on the description line. It is suitable to build a local database for BLAST search
* **[pr2_version_x.y.z_SSU_taxo_long.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_18S_taxo_long.fasta.gz)**

#### Full database as Excel file
Includes sequences, taxonomy and metadata.
* **[pr2_version_x.y.z_merged.xlsx](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_merged.xlsx)** 

#### Updated and new sequences
* **[pr2_version_x.y.z_updated.xlsx](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_updated.xlsx)** 

#### Sequences annotated as chimeric
* **[pr2_version_x.y.z_chimera.xlsx](https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_chimera.xlsx)** 


#### Previous releases

* [Link to previous releases](https://github.com/pr2database/pr2database/releases)

