# Protist Ribosomal Reference database (PR2) - SSU rRNA gene database

The Protist Ribosomal Reference database (PR2) provides a unique access to eukaryotic small sub-unit (SSU) ribosomal RNA and DNA sequences, with curated taxonomy. The database mainly consists of nuclear-encoded protistan sequences. However, metazoans, land plants, macrosporic fungi and eukaryotic organelles (mitochondrion, plastid and others) are also included because they are useful for the analysis of high-troughput sequencing data sets. Introns and putative chimeric sequences have been also carefully checked. Taxonomic assignation of sequences consists of eight unique taxonomic fields.

The original web site (http://ssu-rrna.org/pr2) does not exist any more.  We are proposing updated version of PR2 as flat files to use for annotating metabarcodes. In 2018, a new web site will be constructed.

## Current version
* Current version : 4.7.2
* Last update : 21 November 2017
* DOI : https://doi.org/10.6084/m9.figshare.3803709
* [Link to latest release](https://github.com/vaulot/pr2_database/releases)

## Files PR2 database
* **pr2_mothur.zip** contains two files for use with Qiime or Mothur.
  + pr2_mothur.fasta contains all sequences in fasta format with the accession in the description line
  + pr2_mothur.tax contains the taxonomy of each sequence separated from the accession number by a tabulation
  Note :Qiime only use 7 taxonomical levels by default.
* **pr2_UTAX.zip** contains one fasta file with the accession number of the sequence and its full taxonomy on the description line in the UTAX format. It is suitable to use with USEARCH and VSEARCH.
* **pr2_taxo_long.zip** contains one fasta file with the accession number of the sequence, the name of the sequence and its full taxonomy on the description line. It is suitable to build a local database for BLAST search
* **pr2_metadata.zip** contains a tabulation separated file with all the metadata from genbank as well as annotation made to the PR2 database.
* **pr2_merged.zip** contains a tabulation separated file the full PR2 database including sequences, taxonomy and metadata.

## Files PR2 history
* **pr2_version_history.md** contains the revision history
* **PR2 versions.xls** is a condensed list of the different versions

## Contact
Daniel VAULOT, Laure GUILLOU and Fabrice NOT
DIPO team, Plankton Group, UMR 7144 CNRS-UPMC
Station Biologique,
Place G. Tessier
29680 Roscoff FRANCE
email: vaulot@sb-roscoff.fr

## Contributors
- Tristan Biard
- Margot Tragin
- Bente Edvardsen
- Charles Bachy and Wei Ting Chen

## Please cite
* Guillou, L., Bachar, D., Audic, S., Bass, D., Berney, C., Bittner, L., Boutte, C. et al. 2013. The Protist Ribosomal Reference database (PR2): a catalog of unicellular eukaryote Small Sub-Unit rRNA sequences with curated taxonomy. Nucleic Acids Res. 41:D597–604.

## References
* Edvardsen, B., Egge, E.S. & Vaulot, D. 2016. Diversity and distribution of haptophytes revealed by environmental sequencing and metabarcoding – a review. Perspect. Phycol. in press
* Tragin, M., Lopes dos Santos, A., Christen, R. & Vaulot, D. 2016. Diversity and ecology of green microalgae in marine systems: an overview based on 18S rRNA gene sequences. Perspect. Phycol. in press.

## PhytoRef (16S plastid database)
https://figshare.com/articles/PhytoREF_a_reference_database_of_the_plastidial_16S_rRNA
