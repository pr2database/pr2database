#' @import shiny

#' @import markdown

#' @import dplyr
#' @import stringr
#' @import forcats
#' @import ggplot2

# Javascript function for timer -----------------------------------------------------

#  See: https://stackoverflow.com/questions/35306295/how-to-stop-running-shiny-app-by-closing-the-browser-window
#   * Will close windows after x msec 60 000 -> 1 min - 600 000 -> 10 min - 1800 000 -> 30 min

inactivity <- "function idleTimer() {
  var t = setTimeout(logout, 1800000);
  window.onmousemove = resetTimer; // catches mouse movements
  window.onmousedown = resetTimer; // catches mouse movements
  window.onclick = resetTimer;     // catches mouse clicks
  window.onscroll = resetTimer;    // catches scrolling
  window.onkeypress = resetTimer;  //catches keyboard actions

  function logout() {
    window.close();  //close the window
  }

  function resetTimer() {
    clearTimeout(t);
    t = setTimeout(logout, 1800000);  // time is in milliseconds (1000 is 1 second)
  }
}
idleTimer();"

# Messages ----------------------------------------------------------

messages <- list()
messages$no_data = tags$div(
  tags$h4(tags$b("No data for this taxon in selected samples:")),
  # tags$br(),
  tags$span(style="color:red","You may want to change minimum number of reads or select more samples")
)

messages$too_many_seqs = tags$div(
  tags$h4(tags$b("Too many sequences:")),
  # tags$br(),
  tags$span(style="color:red","You may want to change taxonomy to lower level or filters the sequences")
)


# # Read global ----------------------------------------------------------
#
# # message("Message - app_sys output: ", app_sys("data-qs/global.qs"))
#
# ## Try Read from system file - for local
#
# file_loaded  <- tryCatch(
#   {
#     global <- qs::qread(app_sys("data-qs/global.qs"))
#     print("Using System file")
#     TRUE              # Returns true if loaded
#   },
#   error=function(cond) {
#     message("Cannot use system.file")
#     return(FALSE)
#   }
# )
#
# ## Try Read from full path _ for google server
# if(!file_loaded){
#   file_loaded  <- tryCatch(
#     {
#       global <- qs::qread("inst/data-qs/global.qs")
#       print("Using full path")
#       TRUE              # Returns true if loaded
#     },
#     error=function(cond) {
#       message("Cannot use full path")
#       return(FALSE)
#     }
#   )
# }
#
# ## Read from Gcloud bucket with pins - for people who install the library
#
# if(!file_loaded){
#   global <- read_qs_from_url("https://storage.googleapis.com/pr2database-data/pr2database/data-qs/global.qs")
#   print("Using cloud bucket")
# }

#
# # Read pr2 ----------------------------------------------------------
#

## Try Read from system file - for local

file_loaded  <- tryCatch(
  {
    pr2 <- qs::qread(app_sys("data-qs/pr2.qs"))
    print("Using System file")
    TRUE              # Returns true if loaded
  },
  error=function(cond) {
    message("Cannot use system.file")
    return(FALSE)
  }
)

## Try Read from full path _ for google server
if(!file_loaded){
  file_loaded  <- tryCatch(
    {
      pr2 <- qs::qread("inst/data-qs/pr2.qs")
      print("Using full path")
      TRUE              # Returns true if loaded
    },
    error=function(cond) {
      message("Cannot use full path")
      return(FALSE)
    }
  )
}

## Read from Gcloud bucket with pins - for people who install the library

if(!file_loaded){
  pr2 <- read_qs_from_url("https://storage.googleapis.com/pr2database-data/pr2database/data-qs/pr2.qs")
  print("Using cloud bucket")
}

# Change factors to character ----------------------------------------------------

pr2$sequence_length_min <- min(pr2$main$sequence_length , na.rm = TRUE)
pr2$sequence_length_max <- max(pr2$main$sequence_length , na.rm = TRUE)

pr2$sample_types <- purrr::discard(sort(unique(pr2$main$pr2_sample_type)), ~ is.na(.x))

pr2$organelles <- purrr::discard(sort(unique(pr2$main$organelle)), ~ is.na(.x))
pr2$organelles <- c(pr2$organelles, "NA") # Add not applicable for bacteria

pr2$domains <- purrr::discard(sort(unique(pr2$taxonomy$domain)), ~ is.na(.x))

pr2$taxonomy <- dplyr::mutate(pr2$taxonomy,
                       species_url = dplyr::case_when(!is.na(worms_id) ~ glue::glue("<a href='https://www.marinespecies.org/aphia.php?p=taxdetails&id={worms_id}'
                                                      target='_blank'>{species}</a>."),
                                               TRUE ~  species))
pr2$main <- dplyr::mutate(pr2$main,
                   species_url = dplyr::case_when(!is.na(worms_id) ~ glue::glue("<a href='https://www.marinespecies.org/aphia.php?p=taxdetails&id={worms_id}'
                                                  target='_blank'>{species}</a>."),
                                           TRUE ~  species))


# Done --------------------------------------------------------------------


print("global.R done")
