# =========================================================================
# --- Check that sequence is valid --------------------------------------------
# =========================================================================


sequence_clean <- function(sequence){
  sequence <- str_to_upper(sequence)
  sequence <- str_replace_all(sequence, "^>.*" , "") # Remove fasta header in case it is present
  sequence <- str_replace_all(sequence, "[\\r\\n]" , "")
}


# =========================================================================
# --- Check that sequence is valid --------------------------------------------
# =========================================================================


sequence_check <- function(sequence){
  sequence <- sequence_clean(sequence)
  ((nchar(sequence) >= 130) &
      (str_detect(sequence, "[^ACGTRYSWKMBDHVN]", negate = TRUE)))
}

# =========================================================================
# --- Match all ASVs (pattern) to query sequences NOT USED-----------------------
# =========================================================================

# Compute % of ID for each ASV versus query sequence and order by decreasing PID

match_sequence <- function(fasta.df, query){

  query <- sequence_clean(query)

  query <-  Biostrings::DNAString(query)

  pattern <- Biostrings::DNAStringSet(fasta.df$sequence)
  names(pattern) <- fasta.df$asv_code

  asv_align <- Biostrings::pairwiseAlignment(pattern = pattern, subject = query, type = "global-local")

  scores <- data.frame(score=Biostrings::score(asv_align), pid = Biostrings::pid(asv_align) )

  df <- bind_cols(fasta.df, scores) %>%
    arrange(desc(pid)) %>%
    mutate(pid = round(pid, 2)) %>%  # Only 2 decimals
    select(pr2_accession, pid, domain:species, sequence)

  return(df)
}

# =========================================================================
# --- Match all Sequences (pattern) to query sequences using blaster ------
# =========================================================================

# Compute % of ID for each ASV versus query sequence and order by decreasing PID

blaster_sequence <- function(fasta.df, query,
                        minIdentity = 0.80,
                        maxAccepts = 100){

  query <- sequence_clean(query)
  query <-  data.frame(Id = "query", Seq =query)

  n_seq = nrow(fasta.df)
  slice_size = 50000
  # slice_size = 5000 # for testing

  db <- fasta.df %>%
    select(Id = pr2_accession,
           Seq = sequence) %>%
    mutate(slice = ggplot2::cut_width(1:n_seq,labels=FALSE, width=slice_size, boundary = 1))


  n_slices = max(db$slice)
  df_slices <- list()

  for (one_slice in 1:n_slices){
  # for (one_slice in 1:1){ # for testing

    message("Slice #: ", one_slice)

    db_slice <- db %>%
       filter(slice == one_slice)

    df_one_slice <- blaster::blast(query, db_slice,
                         minIdentity = minIdentity,
                         maxAccepts = maxAccepts)

    # Necessary if one of the slice is null
    if(nrow(df_one_slice) > 0) df_slices[[one_slice]] <-  df_one_slice
  }


  if (length(df_slices)!= 0) {
    df <- purrr::reduce(df_slices, bind_rows)
    }
  else {
    df <- NULL
    }

  if(!is.null(df) && nrow(df) > 0) {
    df <- df %>%
      select(pid = Identity,
             pr2_accession = TargetId,
             mismatches = NumMismatches,
             gaps = NumGaps,
             query_start = QueryMatchStart,
             query_end = QueryMatchEnd,
             target_start = TargetMatchStart,
             target_end = TargetMatchEnd) %>%
      mutate(pid = 100*pid,
             pid = round(pid, 2)) %>%
      arrange(desc(pid)) %>%
      inner_join(fasta.df) %>%
      select(pr2_accession, pid, mismatches, gaps,
             query_start, query_end, target_start, target_end,
             pr2_sample_type,
             domain:species, sequence)
  } else {
    df <- NULL
  }

  return(df)
}


# =========================================================================
# --- Write fasta file with taxo ------------------------------------------
# =========================================================================

# fasta_write : Write fasta file with taxo ----------------------------------------------

#' @title Write a fasta file with the taxonomy
#'
#' @description
#' Write a fasta file from a set of sequences
#' Option : add to the definition line the the taxonomy separated by separator character (e.g. |)
#'
#' >Otu0001|Alveolata|Dinophyta|Syndiniales|Dino-Group-I|Dino-Group-I-Clade-1|Dino-Group-I-Clade-1_X|Dino-Group-I-Clade-1_X_sp.
#'
#' AGCTCCAATAGCGTATATTAAAGTTGTTGCGGTTAAAAAGCTCGTAGTTGGA...
#' @param df The data frame with the otu names, the taxonomy and the sequences. It should have the following columns (with exactly these names)
#'
#'       * seq_name : the sequence name
#'       * supergroup: species
#'       * sequence
#' @param file_name Character, where to save the fasta file
#' @param compress If TRUE produces a gz file
#' @param taxo_include If TRUE then add taxo information which must be provided
#' @param taxo_separator Character used to separate the different taxonomic levels
#' TRUE if it terminates OK
#'
#' @examples
#' fasta_write(df,"otu_taxo.fasta", compress=FALSE, include_taxo=TRUE, taxo_separator=";")
#' @noRd
#'

fasta_write <- function(df,file_name, compress=FALSE, taxo_include=TRUE, taxo_separator="|") {

  # First remove the gaps (can be - or .)
  df <-  df %>%  mutate(sequence = str_replace_all(sequence, "(-|\\.)",""))

  seq_out <- Biostrings::DNAStringSet(df$sequence)

  if (taxo_include==TRUE) {
    names(seq_out) <- str_c(df$seq_name,
                            df$supergroup,
                            df$division,
                            df$class,
                            df$order,
                            df$family,
                            df$genus,
                            df$species,
                            sep=taxo_separator)
  }
  else { names(seq_out) <- df$seq_name
  }

  Biostrings::writeXStringSet(seq_out, file_name, compress=compress, width = 20000)

  return(TRUE)
}



