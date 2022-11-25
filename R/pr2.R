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
#'        \item{pr2_silva}
#'   }
#' The metadata contains three types of fields
#' \itemize{
#'        \item{gb_ : originating from the GenBank entry}
#'        \item{eukref_ : annotated by the Eukref project}
#'        \item{pr2_ : annotated by pr2 such latitude and longitude}
#'   }
#' Description of fields: \url{https://pr2-database.org/documentation/pr2-fields}
#'
#'
#' @return A data frame
#' @export
#'
#' @examples
#' # Read the whole database
#' my_pr2 <- pr2_database()
#'
#' # Select a specific genus
#' pr2_ostreo <- pr2_database() %>%
#'    dplyr::filter(genus == "Ostreococcus") %>%
#'    dplyr::select(pr2_accession, species)
#' head(pr2_ostreo)

pr2_database <- function(){
  pr2$main
}
