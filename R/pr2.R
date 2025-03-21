#'@title PR2 database - Eukaryotic 18S rRNA sequences.
#'@description
#'
#' The PR2 database is provided as a data frame.
#'
#' This is a join between the following tables:
#' \itemize{
#'        \item{pr2_main}
#'        \item{pr2_taxonomy}
#'        \item{pr2_sequence}
#'        \item{pr2_metadata}
#'        \item{pr2_traits}
#'        \item{pr2_silva}
#'        \item{euribo}
#'   }
#' The metadata contains different types of fields
#' \itemize{
#'        \item{gb_ : originating from the GenBank entry}
#'        \item{eukref_ : annotated by the Eukref project}
#'        \item{pr2_ : annotated by pr2 such latitude and longitude}
#'        \item{eukribo_: information from the EukRibo database}
#'   }
#' Description of fields: \url{https://pr2-database.org/documentation/pr2-fields}
#'
#'
#' @return A data frame
#' @export
#'
#' @examples
#'
#' # Read the whole database
#' my_pr2 <- pr2_database()
#'
#' # Select a specific genus
#' pr2_ostreo <- pr2_database()
#' pr2_ostreo <- dplyr::filter(pr2_ostreo , genus == "Ostreococcus")
#' pr2_ostreo <-  dplyr::select(pr2_ostreo, pr2_accession, species)
#' head(pr2_ostreo)

pr2_database <- function(){
  pr2$main %>% dplyr::filter(gene %in% c("16S_rRNA", "18S_rRNA")) # To remove other gene databases
}
# ------------------------------------------------------------------------------

#'@title PR2 database - Taxonomy.
#'@description
#'
#' The PR2 database taxonomy is provided as a data frame with the number of sequences for each taxon
#'
#' @return A data frame
#' @export
#'
#' @examples
#'
#' # Read the whole database taxonomy
#' my_pr2_taxo <- pr2_taxonomy()
#'
#' # Select a specific genus
#' my_pr2_taxo <- dplyr::filter( my_pr2_taxo , genus == "Ostreococcus")
#' head(my_pr2_taxo)


pr2_taxonomy<- function(){
  pr2$taxonomy
}

