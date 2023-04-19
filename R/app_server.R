#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Your application server logic

  # Stop the application of the session is closed (after 30 min) - ACTIVATE  for web application
  session$onSessionEnded(stopApp)

  # Disconnection

  observeEvent(input$button_disconnect, {session$close()})

  # To track usage - needs to erase and reload the logs directory
  dir.create(path = "logs", showWarnings = FALSE, recursive = FALSE, mode = "0775")
  shinylogs::track_usage(storage_mode = shinylogs::store_sqlite(path = "logs/"))


  # Taxonomy selection on left menu
  taxo_selected <- mod_select_taxonomy_server("select_taxonomy")


  # Separate sequences filtration from display so can be used in different panels
  sequences_filtered <- mod_filter_sequences_server("filter_sequences", taxo_selected)

  mod_table_taxonomy_server("table_taxonomy", pr2$taxonomy, taxo_selected)

  # Display table of sequences... It is necessary to pass taxo_selected to display correctly number of sequences
  mod_table_sequences_server("table_sequences", sequences_filtered, taxo_selected)

  # Download the data full and selected sequences
  mod_download_server("download", sequences_filtered, taxo_selected)

  # Query all sequences
  mod_query_server("query")


}
