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

# Read global ----------------------------------------------------------

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


# Read global ----------------------------------------------------------

# message("Message - app_sys output: ", app_sys("app/data-qs/global.qs"))

file_loaded  <- tryCatch(
  {
    global <- qs::qread(app_sys("app/data-qs/global.qs"))
    TRUE              # Returns true if loaded
  },
  error=function(cond) {
    message("Cannot use system.file")
    return(FALSE)
  }
)

## Using the explicit way

if(!file_loaded){
  global <- qs::qread("inst/app/data-qs/global.qs")
  print("Using full path")
}


# Read pr2 ----------------------------------------------------------

file_loaded  <- tryCatch(
  {
    pr2 <- qs::qread(app_sys("app/data-qs/pr2.qs"))
    TRUE              # Returns true if loaded
  },
  error=function(cond) {
    message("Cannot use system.file")
    return(FALSE)
  }
)

## Using the explicit way

if(!file_loaded){
  pr2 <- qs::qread("inst/app/data-qs/pr2.qs")
  print("Using full path")
}

# Change factors to character ----------------------------------------------------

global$sequence_length_min <- min(pr2$main$sequence_length , na.rm = TRUE)
global$sequence_length_max <- max(pr2$main$sequence_length , na.rm = TRUE)

global$sample_types <- purrr::discard(sort(unique(pr2$main$pr2_sample_type)), ~ is.na(.x))

global$organelles <- purrr::discard(sort(unique(pr2$main$organelle)), ~ is.na(.x))
global$organelles <- c(global$organelles, "NA") # Add not applicable for bacteria

global$kingdoms <- purrr::discard(sort(unique(pr2$taxonomy$kingdom)), ~ is.na(.x))


# Done --------------------------------------------------------------------


print("global.R done")
