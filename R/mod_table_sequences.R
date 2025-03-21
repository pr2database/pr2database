#' UI Function
#'
#' @description Shiny module to display taxonomy table.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'

mod_table_sequences_ui <- function(id){

  ns <- NS(id)

  tagList(
    includeMarkdown(app_sys("readme/sequences.md")),
    p(),
    htmlOutput(ns("taxo_selected")),
    p(),
    DT::DTOutput(ns('table'))

  )
}

#' Server Functions
#'
#' @noRd
#'


mod_table_sequences_server <- function(id, sequences, taxo_selected){
  moduleServer( id, function(input, output, session){

    # ns <- session$ns
    ns <- NS(id)

    cols_to_keep = c("accession_genbank_link", "gene", "species_url", "gb_organism", "sequence_length",
                     "pr2_sample_type", "reference_sequence")

    table <- reactive({
      req(sequences())
      DT::datatable(sequences() %>%
                      select(any_of(cols_to_keep)) %>%
                      rename(species = species_url),
      rownames = FALSE ,
      escape = FALSE,
      selection = 'none',
      options = list(
        autoWidth = TRUE,
        scrollX=FALSE,
        pageLength = 50
        # columnDefs = list(list(width = '20px', targets = 9))
        )
      )
    })

    output$table <- DT::renderDT(table())

    output$taxo_selected <- renderText({stringr::str_c("Taxo level: <b>",
                                                       taxo_selected()$level,
                                                       "</b>- Taxon name: <b>",
                                                       str_c(taxo_selected()$name,
                                                             collapse = ";"),
                                                       "</b> - Number of sequences:<b>",
                                                       nrow(sequences()),
                                                       "</b>",
                                                       sep=" ")})



  })
}

## To be copied in the UI
# mod_table_sequences_ui("table_sequences")

## To be copied in the server
# mod_table_sequences_server("table_sequences", pr2$taxonomy)
