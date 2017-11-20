## Version 4.7.0
**Annotators** : Charles Bachy and Wei-Ting Chen, Daniel Vaulot (Roscoff)  
**Date** : 27-09-2017

#### New file type for download
* pr2_version_4.7_merged_Eukaryota.zip
contains the whole PR2 database as flat file (sequence, assignation, metadata)
#### Updates for constraints for new sequences
* Number of ambiguities <= 20
* Length > 600 (to accommodate EukRef)
#### **Ciliates, Class Spirotrichea, Orders Oligotrichia and Choreotrichia** (3081 sequences)
##### Removal of sequences
* 60 sequences (AB640624 to AB640683) that are questionable in terms of species identification and sequence quality have been removed (Kazama et al., 2012).
##### Revision in Classification Systems of Choreotrichia and Oligotrichia
* The order Choreotrichia Oligotrichia is now Subclass Choreotrichia Oligotrichia (note that SubClass is not taken into account in PR2)
* There are 2 orders in Choreotrichia
   +  Choreotrichida
   +  Tintinnida.
* There is 1 order in Oligotrichia. 
   + Strombidiida
##### Tintinnida
* Change “Choreotrichia” to “Tintinnida”.
* Updated informal classification of incertae sedis in Tintinnida.
* Tintinnopsis clades I-IX which are shortened as TIPS I-IX are informal classification for Tintinnopsis (Bachy et al., 2012; Agatha and Strüder-Kypke, 2014; Zhang et al., 2017). Santoferrara et al. ( 2017) added Tintinnopsis and related related genera (Climacocylis, Helicostomella, Leprotintinnus, Rhizodomus and Stylicauda) which are labeled as Tintinnida 1 to 11(TIN_1-11 in PR2).    
* Correction and updated Family names 
   + Choreotrichida
      - Change all “Choreotrichia” to “Choreotrichida” 
      - Add “Leegaardiellidae”
   + Strombidiida
      - Change all “Oligotrichia” to “Strombidiida”
      - Add “Cyrtostrombidiidae” and “Pelagostrombidiidae”
##### New sequences
* 183 sequences were added including 15 sequences submitted to Genbank (accession number MF*)
   + Choreotrichida - 14
   + Strombidiida - 46
   + Tintinnida – 123
##### References :
* Agatha, S. and Strüder-Kypke, M.C. (2014) What Morphology and Molecules Tell Us about the Evolution of Oligotrichea (Alveolata, Ciliophora). Acta Protozool. 2014: 7790.
* Bachy, C., Gómez, F., López-García, P., Dolan, J.R., and Moreira, D. (2012) Molecular Phylogeny of Tintinnid Ciliates (Tintinnida, Ciliophora). Protist 163: 873–887.
* Kazama, T., Ishida, S., Shimano, S., and Urabe, J. (2012) Discrepancy between conventional morphological systematics and nuclear phylogeny of tintinnids (Ciliophora: Choreotrichia). Plankton Benthos Res. Jt. J. Plankton Soc. Jpn. Jpn. Assoc. Benthol. 7: 111–125.
* Santoferrara, L.F., Alder, V.V., and McManus, G.B. (2017) Phylogeny, classification and diversity of Choreotrichia and Oligotrichia (Ciliophora, Spirotrichea). Mol. Phylogenet. Evol. 112: 12–22.
* Zhang, Q., Agatha, S., Zhang, W., Dong, J., Yu, Y., Jiao, N., and Gong, J. (2017) Three rDNA Loci-Based Phylogenies of Tintinnid Ciliates (Ciliophora, Spirotrichea, Choreotrichida). J. Eukaryot. Microbiol. 64: 226–241.

## Version 4.6.2
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** : 11-09-2017

*Minor changes*
* Remove 59 sequences which were duplicated
* All files now are DOS compatible (lines terminated by /r /n)

## Version 4.6.1
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** : 06-09-2017

*Minor changes*
* Removed 3091 sequences that had more than 20 ambiguities ("N")
* **Haptophyta** : 32 chimeras detected by B. Edvardsen added (these are not exported but latter we will provide a list of chimeras on the web site)
* Mothur taxonomy file fixed (taxonomy was separated by tab and not ;)

## Version 4.6.0 
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** : 25-08-2017
* **Bolidophyceae**
   + Correct taxonomy based on Kuwata et al. Frontiers in Microbiology in prep.
   + Define a new environmental clade III
   + 5 chimeras removed
   + Add 18 new sequences
* **Pelagophyceae**
   + Align taxonomy on Algaebase (2 orders)
   + Create a Pelagomonadaceae_clade_A_sp. which corresponds to endosymbiont of Amphisolenia
   + Include 47 new sequences
   + Remove 3 sequences that seem very noisy
* **Chrysophyceae**
   + Add "Chrysophyceae_" to genus and species corresponding to clades, e.g. : "Chrysophyceae_Clade-F_X_sp." replaces "Clade-F_X_sp."
* **Picobiliphyta** changed to Picozoa
* **Chlorophyta** : clade "Indien" moved to "Chlorophyta_X"
* Species containing "strain" have been cleaned by removing the string "strain"
* Metadata from GenBank added as an additional file available for download

## Version 4.5.0
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** :17-01-2017

* Correct inconsistencies in taxonomy
   -	If ranks 1 to 6 are inconsistent with ranks 7 and 8 (genus, species), rank 7 and 8 are changed to reflect the real taxonomy (this occurs in particular when sequence of parasites are attributed to the host)
   -	When one level (e.g. 7 = genus) corresponds to two different upstream levels, then the taxonomy has been fixed.
*	**Following this correction**
    -	No taxonomic name occurs at two different levels (e.g. the same name occurs at the class and order)
    -	Any taxonomic name have only a single parent name (e.g. a given order is always part of the same class)
    -	If a parasite has been detected in a host the genus and species are named after the parasite and not the host
*	Break Chrysophyceae-Synurophyceae into Chrysophyceae vs. Synurophyceae according to Algaebase
*	Correct Haptophyta taxonomy to follow PR2 rules (_X, _XX etc…)
* Change CW-Chlamydomonadales to Chlamydomonadales
* Correct minor dinoflagellates taxonomy (Karlodinium)

## Version 4.4.0
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** : 10-11-2016

*	**Bolidophyceae** taxonomy corrected according to Ichinomiya, M., dos Santos, A.L., Gourvil, P., Yoshikawa, S., Kamiya, M., Ohki, K., et al. (2016) Diversity and oceanic distribution of the Parmales (Bolidophyceae), a picoplanktonic group closely related to diatoms. ISME J. 10: 2419–2434.
*	Insertion in sequences removed
*	Sequences not in GenBank removed
*	Sequences with a large number of N removed

## Version 4.3.0
**Annotators** : Daniel Vaulot (Roscoff)  
**Date** : 04-09-2016

*	"Eukaryota;Archaeplastida;Chlorophyta" replaced by "Eukaryota;Archaeplastida;Chlorophyta" in 199 entries

## Version 4.2.0
**Annotators** : Bente Edvardsen (Oslo)  
**Date** : 13-04-2016

*	**Haptophyta**.  Chimeras checked.

## Version 4.1.0
**Annotators** : Margot Tragin (Roscoff)  
**Date** : 23-10-2015

*	223 Chlorophyta sequences from the RCC (accession number ZZ*) were deleted and replaced by 199 RCC Chlorophyta sequences submitted to Genbank (accession number KT*)

## Version 4.0.0 
**Annotators** : Bente Edvardsen (Oslo)  
**Date** : 21-10-2015

*	**Haptophyta** - Taxonomy updated according to Edvardsen, B., Egge, E. S., and Vaulot, D. (2016). Diversity and distribution of haptophytes revealed by environmental sequencing and metabarcoding – a review. Perspect. Phycol. 3, 77–91. doi:10.1127/pip/2016/0052.

## Version 3.0
**Annotators** : Margot Tragin (Roscoff)  
**Date** : 14-09-2015

* Inspection and Corrections of Taxonomical Classification for the **Chlorophyta**
   + 1225 (on 8777) taxonomical assignations modified 
   + Name class Prasino-clade-I corrected in in Prasino-clade-9
   + 3 sequences of Nephroselmidophyceae reassigned to Prasino-clade-VIII: 
     - EU143504
     - EU143505
     - EU143506
   + Ulvophyceae, Trebouxiophyceae and Chlorophyceae taxonomical assignation not checked.
* **Chimera check**: 76 sequences tagged and removed from the mothur files but not from the Access database
* 223 addition of new sequences from the RCC (accession number ZZ*). These sequences are not submitted to GenBank yet

