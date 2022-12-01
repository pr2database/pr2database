
### Files with full database

We recommend that you use these files for analysis of metabarcoding data.

[Information about format of files.](https://pr2-database.org/documentation/pr2-files/)

Each version has a 3 number code: version_x.y.z, e.g. 4.14.0

---

#### File for [dada2](https://benjjneb.github.io/dada2/index.html)
* **[pr2_version_x.y.z_SSU_dada2.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_dada2.fasta.gz)** 

#### Files for [Mothur](https://mothur.org/) or [Qiime](http://qiime.org/)
**Note** :Qiime only use 7 taxonomical levels by default.
* **[pr2_version_x.y.z_SSU_mothur.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_mothur.fasta.gz)**: sequences in fasta format with accession in description line
* **[pr2_version_x.y.z_SSU_mothur.tax.gz](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_mothur.tax.gz)**: taxonomy of each sequence separated from the accession number by a tabulation

#### File for [USEARCH](http://www.drive5.com/usearch/) or [VSEARCH](https://github.com/torognes/vsearch) 
Fasta file with accession number and full taxonomy on the description line in the UTAX format.
* **[pr2_version_x.y.z_SSU_UTAX.fasta.gz](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_UTAX.fasta.gz)**: 

#### [DECIPHER](http://www2.decipher.codes/) training set
File can be used with the DECIPHER IDTaxa function to assign metabarcodes. Use the readRDS() function of R to load the file.
* **[pr2_version_x.y.z_SSU.decipher.trained.rds](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU.decipher.trained.rds)**

#### Fasta file
Accession number, the name of  sequence and  full taxonomy on the description line. It is suitable to build a local database for BLAST search
* **[pr2_version_x.y.z_SSU_taxo_long.fasta.gz](https://github.com/pr2database/pr2database/releases)**

#### Full database as Excel file
Includes sequences, taxonomy and metadata.
* **[pr2_version_x.y.z_merged.xlsx](https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_merged.xlsx)** 

#### Previous releases

* [Link to previous releases](https://github.com/pr2database/pr2database/releases)

