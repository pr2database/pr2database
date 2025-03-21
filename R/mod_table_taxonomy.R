#' UI Function
#'
#' @description Shiny module to display taxonomy table.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'

mod_table_taxonomy_ui <- function(id){

  ns <- NS(id)

  tagList(
    includeMarkdown(app_sys("readme/taxonomy.md")),
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


mod_table_taxonomy_server <- function(id, taxonomy, taxo_selected){
  moduleServer( id, function(input, output, session){

    # ns <- session$ns
    ns <- NS(id)


    taxonomy_filtered <- reactive({
      req(taxo_selected())
      taxonomy %>%
        filter(.data[[taxo_selected()$level]] %in% taxo_selected()$name) %>%
        arrange(across(any_of(pr2$taxo_levels))) %>%
        mutate(species = species_url) %>%
        select(-species_url) %>%
        relocate(any_of(c("n_sequences_SSU", "n_sequences_operon")), .after = "species")
    })

    table <- reactive(
      DT::datatable(taxonomy_filtered() ,
      rownames = FALSE ,
      escape = FALSE,
      options = list(
        autoWidth = TRUE,
        selection = 'none',
        scrollX=FALSE,
        pageLength = 50
        # columnDefs = list(list(width = '10px', targets = 9))
        )
      )
    )

    output$table <- DT::renderDT(table())

    output$taxo_selected <- renderText({stringr::str_c("Taxo level: <b>",
                                                       taxo_selected()$level,
                                                       "</b>- Taxon name: <b>",
                                                       str_c(taxo_selected()$name,
                                                             collapse = ";"),
                                                       "</b> - Number of species:<b>",
                                                       nrow(taxonomy_filtered()),
                                                       "</b>",
                                                       sep=" ")})



  })
}

## To be copied in the UI
# mod_table_taxonomy_ui("table_taxonomy")

## To be copied in the server
# mod_table_taxonomy_server("table_taxonomy", pr2$taxonomy, taxo_selected)
