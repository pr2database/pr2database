#' UI Function
#'
#' @description Shiny module to display taxonomy table.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'

mod_select_taxonomy_ui <- function(id){

  ns <- NS(id)

  tagList(
    h3("Select Taxa"),

    div(actionButton(ns("validate_taxo"), "Validate Taxa", class = "btn-primary"), style="display:inline-block"),
    div(actionButton(ns("reset_taxo"), "Reset Taxa", class = "btn-primary"), style="display:inline-block"),
    p(),
    p("VALIDATE after changes to update screen."),
    p("RESET + VALIDATE to cancel choices"),
    p(),

    shinyWidgets::pickerInput(ns("domain"), "Domain",
                              choices = unique(pr2$taxonomy$domain), selected = "Eukaryota",
                              multiple = TRUE, options= options_picker_taxo_domain),

    # Use the purr map function to create the pickerInput
    purrr::map(global$taxo_levels[2:global$taxo_levels_number],
               ~  shinyWidgets::pickerInput(ns(.x), str_to_title(.x) ,
                                            choices = NULL, selected = NULL,
                                            multiple = TRUE, options= options_picker_taxo)),

    p(),

    h3("Save/Load Taxa"),
    downloadButton(ns('save_taxo'), 'Save taxonomy', class = "btn-primary"),
    p(),
    p(),
    fileInput(ns('load_taxo'), NULL, buttonLabel = 'Load taxonomy', multiple = FALSE, accept = ".yaml"),

    # Next line is for debugging
    # verbatimTextOutput(ns("taxo_list"))

  )

}

#' Server Functions
#'
#' @noRd
#'

# Taxonomy is now selected for the full dataset and not only for the selected samples


mod_select_taxonomy_server <- function(id){
  moduleServer( id, function(input, output, session){

    # ns <- session$ns
    ns <- NS(id)

    # Reactive Value to prevent update of pickers when uploading-------------
    update_taxo_auto <- reactiveVal(TRUE)

    # Validate Domain selection -----------------------------------------------

    iv_taxonomy <- shinyvalidate::InputValidator$new()

    iv_taxonomy$add_rule("domain", shinyvalidate::sv_required(message = "Choose at least one taxon"))

    iv_taxonomy$enable()



    # ===========================================
    # Update taxonomy selected
    # ===========================================

    taxo <- reactive({
      # Do not use req because if one member is NULL it will not be activated
      taxo_return(input$domain, input$supergroup, input$division, input$subdivision,
                  input$class, input$order, input$family, input$genus, input$species)
    })


    taxo_final <- eventReactive(c(input$validate_taxo), {
      c(taxo())
      # ignoreNULL is necessary so that the plots are created at initial time
    }, ignoreNULL = FALSE, ignoreInit = TRUE)

    # Next line is for debugging
    # output$taxo_list <- renderPrint(taxo())


    # ===========================================
    # Update taxonomic lists (reactive variables)
    # ===========================================

    # See: https://mastering-shiny.org/action-dynamic.html#freezing-reactive-inputs
    #   In this case freezeReactiveValue does not work....



    # Define a function to update each Picker -------------

    update_taxo_picker <- function(taxo_level){

      observeEvent(input[[taxo_level]], {
        # update_taxo_auto = FALSE

        # This line prevents automatic update when resetting and loading new values from yaml file
        req(update_taxo_auto())

        # The next line prevents update of taxonomy selector when loading new values from yaml file
        req((taxo_level_number(taxo_level) >= taxo_level_number(taxo()$level)))

        taxo_level_below = global$taxo_levels[taxo_level_number(taxo_level) + 1]

        # 2022-11-15 - Added to prevent initial resetting (cf Hadley p. 159)
        freezeReactiveValue(input, taxo_level_below)

        taxon_list <-    pr2$taxonomy %>%
          filter(.data[[taxo_level]] %in% input[[taxo_level]]) %>%
          pull(.data[[taxo_level_below]]) %>%
          unique()

        shinyWidgets::updatePickerInput(session = session,  inputId = taxo_level_below, choices = taxon_list)

      }, ignoreNULL = TRUE)

    }

    # Update all Pickers using the map function ----------------

    purrr::map(global$taxo_levels[1:global$taxo_levels_number-1], ~ update_taxo_picker(.x))

    # Save settings --------

    output$save_taxo <- downloadHandler(

      filename = function() {str_c("pr2_taxonomy", "_", Sys.Date(), ".yaml")},
      content = function(path) {
        yaml::write_yaml(taxo(), file = path)

      }
    )

    # Load settings --------


    observeEvent(input$load_taxo, {

      tryCatch(
        {taxo_new <- yaml::read_yaml(file = input$load_taxo$datapath)

        # Prevent update when taxo is loaded
        update_taxo_auto(FALSE)

        purrr::map(global$taxo_levels[1:global$taxo_levels_number], ~ freezeReactiveValue(input, .x))

        purrr::map(global$taxo_levels[1:global$taxo_levels_number], ~ shinyWidgets::updatePickerInput(session = session,
                                                                                                      inputId = .x,
                                                                                                      choices = taxo_new[[.x]],
                                                                                                      selected = taxo_new[[.x]]))
        update_taxo_auto(TRUE)

        },
        error=function(cond) {
          message("Invalid yaml file")
          showModal(modalDialog(title = "Loading settings", "Invalid YAML file", size = "s", easyClose = TRUE))
          return(NA)
        }
      )
    })

    # Reset settings --------

    observeEvent( input$reset_taxo, {

      shinyWidgets::updatePickerInput(session = session,  inputId = "domain",
                                      choices = unique(pr2$taxonomy$domain), selected = NULL, )
      purrr::map(global$taxo_levels[2:global$taxo_levels_number], ~ shinyWidgets::updatePickerInput(session = session,  inputId = .x,
                                                                                                    choices = character(0), selected = character(0)))
      update_taxo_auto(TRUE)

    }, ignoreInit = TRUE, ignoreNULL = TRUE) # 2022-11-15 - Ignore init is critical so that the list is not Reset initially


    # Use taxo and not taxo(), ie return the function and not its value...
    return(taxo_final)

  })

}

## To be copied in the UI
# mod_select_taxonomy_ui("select_taxonomy")

## To be copied in the server
# mod_select_taxonomy_server("select_taxonomy")
