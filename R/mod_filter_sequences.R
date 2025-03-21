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
      pr2$sequence_length_min,
      value = pr2$sequence_length_min,
      min = pr2$sequence_length_min,
      max = 2500,
      step = 250,
      width = NULL
    )
  )
}


mod_filter_sequences_sample_type_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Select Sample types"),

    shinyWidgets::pickerInput(ns("sample_type"), "Sample type", choices = pr2$sample_types,
                              selected = pr2$sample_types, multiple = TRUE, options= options_picker),

  )
}

mod_filter_sequences_gene_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Select Sample types"),

    shinyWidgets::pickerInput(ns("genes"), "Genes", choices = pr2$genes,
                              selected = pr2$genes, multiple = TRUE, options= options_picker),

  )
}

mod_filter_sequences_reference_ui <- function(id) {
  ns <- NS(id)
  tagList(

    checkboxInput(ns("reference_sequence_only"), label = "Only reference sequences", value = FALSE),

  )
}

mod_filter_species_HAB_ui <- function(id) {
  ns <- NS(id)
  tagList(

    checkboxInput(ns("HAB_species_only"), label = "Only sequences from Harmful algal blooms (HAB) species", value = FALSE),

  )
}

mod_filter_species_mixoplankton_ui <- function(id) {
  ns <- NS(id)
  tagList(

    checkboxInput(ns("mixoplankton_species_only"), label = "Only sequences from Mixoplankton species", value = FALSE),

  )
}


data_organelle_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Select Organelle (NA for bacteria/archeae)"),

    shinyWidgets::pickerInput(ns("organelle"), "Organelle (NA for bacteria/archea)", choices = pr2$organelles,
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
      sequences <- pr2$main %>%
        filter(.data[[taxo_selected()$level]] %in% taxo_selected()$name,
               sequence_length >= input$sequence_length_min,
               gene %in% input$genes,
               pr2_sample_type %in% input$sample_type) %>%
        arrange(across(any_of(pr2$taxo_levels)))
      if(input$reference_sequence_only) {
        sequences <- sequences %>%
          filter(reference_sequence == "Yes")
      }
      if(input$HAB_species_only) {
        sequences <- sequences %>%
          filter(!is.na(HAB_species))
      }
      if(input$mixoplankton_species_only) {
        sequences <- sequences %>%
          filter(!is.na(mixoplankton))
      }

      return(sequences)
    })

    return(sequences_filtered)
  })
}

