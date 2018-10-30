Aim
===

The PR2 database is now provided as a R package

Installation
============

Install from the GitHub web site using the devtools package

``` r
install.packages(devtools)
devtools::install_github("vaulot/pr2database")
```

    * installing *source* package 'pr2database' ...
    ** R
    ** data
    *** moving datasets to lazyload DB
    ** byte-compile and prepare package for lazy loading
    ** help
    *** installing help indices
      converting help for package 'pr2database'
        finding HTML links ... fini
        pr2                                     html  
    ** building package indices
    ** testing if installed package can be loaded
    *** arch - i386
    *** arch - x64
    * DONE (pr2database)
    In R CMD INSTALL

Loading the database
====================

The PR2 database is provided as a data frame (or a tibble). This is a join between the following tables: \* pr2\_main \* pr2\_taxonomy \* pr2\_sequence \* pr2\_metadata

``` r
library("pr2database")

data("pr2")

# List of the different columns available - see the help of the package for information on each field

colnames(pr2)
#>  [1] "pr2_main_id"                "pr2_accession"             
#>  [3] "genbank_accession"          "start"                     
#>  [5] "end"                        "label"                     
#>  [7] "species"                    "chimera"                   
#>  [9] "chimera_remark"             "reference_sequence"        
#> [11] "added_version"              "removed_version"           
#> [13] "edited_version"             "edited_by"                 
#> [15] "edited_remark"              "remark"                    
#> [17] "taxo_id"                    "kingdom"                   
#> [19] "supergroup"                 "division"                  
#> [21] "class"                      "order"                     
#> [23] "family"                     "genus"                     
#> [25] "taxo_edited_version"        "taxo_edited_by"            
#> [27] "taxo_removed_version"       "taxo_remark"               
#> [29] "reference"                  "seq_id"                    
#> [31] "sequence"                   "sequence_length"           
#> [33] "ambiguities"                "pr2_metadata_id"           
#> [35] "gb_date"                    "gb_locus"                  
#> [37] "gb_definition"              "gb_organism"               
#> [39] "gb_taxonomy"                "gb_strain"                 
#> [41] "gb_culture_collection"      "gb_clone"                  
#> [43] "gb_isolate"                 "gb_isolation_source"       
#> [45] "gb_specimen_voucher"        "gb_host"                   
#> [47] "gb_collection_date"         "gb_environmental_sample"   
#> [49] "gb_country"                 "gb_lat_lon"                
#> [51] "gb_collected_by"            "gb_note"                   
#> [53] "pubmed_id"                  "gb_publication"            
#> [55] "gb_authors"                 "gb_journal"                
#> [57] "eukref_publication"         "eukref_authors"            
#> [59] "eukref_journal"             "eukref_name"               
#> [61] "eukref_source"              "eukref_env_material"       
#> [63] "eukref_env_biome"           "eukref_biotic_relationship"
#> [65] "eukref_specific_host"       "eukref_geo_loc_name"       
#> [67] "eukref_notes"               "pr2_sample_type"           
#> [69] "pr2_sample_method"          "pr2_ocean"                 
#> [71] "pr2_latitude"               "pr2_longitude"             
#> [73] "pr2_sequence_origin"        "pr2_size_fraction"         
#> [75] "pr2_size_fraction_min"      "pr2_size_fraction_max"     
#> [77] "metadata_remark"
```

Working with the database
=========================

Install and load the libraries
------------------------------

The following examples makes use of the specifc R libraries

Install the libraries

``` r
install.packages("dplyr")
install.package("ggplot2")

source("https://bioconductor.org/biocLite.R")
biocLite("Biostrings")
```

Load the libraries

``` r
  library(dplyr)
  library(Biostrings)
```

Selecting sequences from a specific taxon
-----------------------------------------

We want to have all the available sequences for the Mamiellophyceae *Ostreococcus*

``` r


  # Filter only the sequences for which the column genus contains Ostreococcus
  pr2_ostreo <- pr2 %>% dplyr::filter(genus == "Ostreococcus")

  # Select only the columns of interest
  pr2_ostreo <- pr2_ostreo %>% dplyr::select( genbank_accession, species, 
                                              pr2_sample_type, gb_strain, gb_clone, 
                                              pr2_latitude, pr2_longitude, 
                                              sequence_length, sequence  )
  
  pr2_ostreo
#> # A tibble: 293 x 9
#>    genbank_accessi~ species pr2_sample_type gb_strain gb_clone pr2_latitude
#>    <chr>            <chr>   <chr>           <chr>     <chr>           <dbl>
#>  1 AF525872         Ostreo~ environmental   <NA>      UEPACIp5         NA  
#>  2 EU562149         Ostreo~ environmental   <NA>      IND2.6           NA  
#>  3 AY425309         Ostreo~ environmental   <NA>      RA01041~         NA  
#>  4 GQ426346         Ostreo~ culture         CB6       <NA>             NA  
#>  5 KC583118         Ostreo~ environmental   <NA>      RS.12f.~         NA  
#>  6 JN862906         Ostreo~ culture         BCC48000  <NA>             NA  
#>  7 JQ692065         Ostreo~ environmental   <NA>      PUPF_60         -43.3
#>  8 FR874749         Ostreo~ environmental   <NA>      1815F12          60.3
#>  9 FJ431431         Ostreo~ environmental   <NA>      RA07100~         NA  
#> 10 EU561670         Ostreo~ environmental   <NA>      IND1.11         -35.0
#> # ... with 283 more rows, and 3 more variables: pr2_longitude <dbl>,
#> #   sequence_length <int>, sequence <chr>
```

Exporting the sequences to fasta
--------------------------------

This is easy done with the bioconductor package BioStrings

``` r

  # Importing the sequence in a Biostring set 

  seq_ostreo <- Biostrings::DNAStringSet(pr2_ostreo$sequence)

  # Constructing the name of each sequecne (the first line of the fasta file)
  # using the genbank accession, species name, strain name and clone name

  names(seq_ostreo) <- paste(pr2_ostreo$genbank_accession, pr2_ostreo$species,
                             "strain",pr2_ostreo$gb_strain,
                             "clone",pr2_ostreo$gb_clone, 
                              sep="|")

  # Displaying the Biostring set
  seq_ostreo
#>   A DNAStringSet instance of length 293
#>       width seq                                        names               
#>   [1]  1766 ACCTGGTTGATCCTGCCAGT...TGAACCTGCAGAAGGATCA AF525872|Ostreoco...
#>   [2]   836 AAAGCTCGTAGTCGGATTTT...GGGCCGCACGCGCGCTACA EU562149|Ostreoco...
#>   [3]  1728 GCCAGTAGTCATATGCTTGT...AAGTCGTAACAAGGTTTCC AY425309|Ostreoco...
#>   [4]  1652 AGCCATGCATGTCTAAGTAT...ATTACCGTGGGAAATTCGT GQ426346|Ostreoco...
#>   [5]  1764 CCTGGTTGATCCTGCCAGTA...GTGAACCTGCAGAAGGATC KC583118|Ostreoco...
#>   ...   ... ...
#> [289]   610 CATCGTATATTTAGTTGTTG...CACGGGGAAACTTACCAGG KT878675|Ostreoco...
#> [290]   671 GCTCGTAGTCGGACTTTGGC...TGGTGGAGTGATTTGTCTG KT860804|Ostreoco...
#> [291]   550 TATTTAAGTTGTTGCAGTTA...TGACGGAAGGGCACCACCA KT860644|Ostreoco...
#> [292]  1595 TGGCTCATTAAATCAGCAAT...GTTCGCCATTGGATTACCG KT860912|Ostreoco...
#> [293]  1766 ACCTGGTTGATCCTGCCAGT...TGAACCTGCGGAAGGATCA CR954212|Ostreoco...
    
  # Saving the sequences as a fasta file
  Biostrings::writeXStringSet(seq_ostreo, "examples/pr2_ostreo.fasta", width = 80)
```

The fasta file will looks as follows

    >AF525872|Ostreococcus_lucimarinus|strain|NA|clone|UEPACIp5
    ACCTGGTTGATCCTGCCAGTAGTCATATGCTTGTCTCAAAGATTAAGCCATGCATGTCTAAGTATAAGCGTTATACTGTG
    AAACTGCGAATGGCTCATTAAATCAGCAATAGTTTCTTTGGTGGTGTTTACTACTCGGATAACCGTAGTAATTCTAGAGC
    TAATACGTGCGTAAATCCCGACTTCGGAAGGGACGTATTTATTAGATAAAGACCG...
    >EU562149|Ostreococcus_lucimarinus|strain|NA|clone|IND2.6
    AAAGCTCGTAGTCGGATTTTGGCTGAGAACGGTCGGTCCGCCGTTAGGTGTGCACTGACTGGTCTCAGCTTCCTGGTGAG
    GAGGTGTGCTTCATCGCCACTTAGTCACCGTGGTTACTTTGAAAAAATTAGAGTGTTCAAAGCGGGCTTACGCTTGAATA
    TATTAGCATGGAATAACACCATAGGACTCCTGTCCTATTTCGTTGGTCTCGGGACGGGAGTAATGATTAAGATGAACAGT
    TGGGGGCATTCGTATTTCATTGTCAGAGGTGAAATTCTTGGATTT...
    >AY425309|Ostreococcus_lucimarinus|strain|NA|clone|RA010412.39
    GCCAGTAGTCATATGCTTGTCTCAAAGATTAAGCCATGCATGTCTAAGTATAAGCGTTATACTGTGAAACTGCGAATGGC
    TCATTAAATCAGCAATAGTTTCTTTGGTGGTGTTTACTACTCGGATAACCGT...
