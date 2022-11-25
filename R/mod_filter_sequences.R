options_picker <- shinyWidgets::pickerOptions(
  actionsBox = TRUE,
  selectedTextFormat = "count > 5",
  liveSearch = TRUE
)


#' UI Function
#'
#' @description Shiny module to display taxonomy table.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#'

mod_filter_sequences_length_min_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # h3("Select Sequence length"),
    sliderInput(
      ns("sequence_length_min"),
      label = "Minimum sequence length",
      global$sequence_length_min,
      value = global$sequence_length_min,
      min = global$sequence_length_min,
      max = 2000,
      step = 250,
      width = NULL
    )
  )
}


mod_filter_sequences_sample_type_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Select Sample types"),

    shinyWidgets::pickerInput(ns("sample_type"), "Sample type", choices = c(global$sample_types, "unknown"),
                              selected = c(global$sample_types, "unknown"), multiple = TRUE, options= options_picker),

  )
}

data_organelle_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Select Organelle (NA for bacteria/archeae)"),

    shinyWidgets::pickerInput(ns("organelle"), "Organelle (NA for bacteria/archea)", choices = global$organelles,
                              selected = "nucleus", multiple = TRUE, options= options_picker),

  )
}

# =====================================================================================================

#' Server Functions
#'
#' @noRd
#'

mod_filter_sequences_server <- function(id, taxo_selected){
  moduleServer( id, function(input, output, session){

    # ns <- session$ns
    ns <- NS(id)

    sequences_filtered <- reactive({
      req(taxo_selected())
      pr2$main %>%
        mutate(pr2_sample_type = tidyr::replace_na(pr2_sample_type, "unknown")) %>%
        filter(.data[[taxo_selected()$level]] %in% taxo_selected()$name,
               sequence_length >= input$sequence_length_min,
               pr2_sample_type %in% input$sample_type) %>%
        arrange(across(any_of(global$taxo_levels)))
    })

    return(sequences_filtered)
  })
}

