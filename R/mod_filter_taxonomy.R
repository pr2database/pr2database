# DOES NOT WORK....

#' UI Function
#'
#' @description Shiny module to display taxonomy table.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#'

# =====================================================================================================

#' Server Functions
#'
#' @noRd
#'

mod_filter_taxonomy_server <- function(id, taxo_selected){
  moduleServer( id, function(input, output, session){

    # ns <- session$ns
    ns <- NS(id)

    taxo_filtered <- reactive({
      req(taxo_selected())
      taxonomy <-  pr2$taxonomy %>%
        filter(.data[[taxo_selected()$level]] %in% taxo_selected()$name)

      if(input$HAB_species_only) {
        taxonomy <- taxonomy %>%
            filter(!is.na(HAB_species))
        }
      if(input$mixoplankton_species_only) {
        taxonomy <- taxonomy %>%
          filter(!is.na(mixoplankton))
      }

      return(taxonomy)
    })

    return(taxo_filtered)
  })
}

