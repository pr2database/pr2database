n_seq_max = 50000



# UI ----------------------------------------------------------------------

mod_download_full_UI <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns('download_full_ui'))
  )
}

mod_download_UI <- function(id) {
  ns <- NS(id)
  tagList(
    h3("Download selected sequences, taxonomy and metadata"),
    hr(),
    HTML("Press <b>Validate Taxa</b> to update taxonomy before downloading"),
    p(),
    HTML("Maximum number of sequences for download: <b>50,000</b>.If you need more, download the full database."),
    p(),
    uiOutput(ns('download_ui'))
  )
}


# Server ------------------------------------------------------------------


mod_download_server <- function(id, sequences_filtered, taxo_selected) {
  # stopifnot(is.reactive(taxo))

  moduleServer(id, function(input, output, session) {

    ns <- NS(id)

    n_seq_valid <- reactive({nrow(sequences_filtered()) <= n_seq_max})

    output$taxo_selected <- renderText({stringr::str_c("Taxo level: ",
                                                       tags$b(taxo_selected()$level),
                                                       "- Taxon name: ",
                                                       tags$b(str_c(taxo_selected()$name,
                                                             collapse = ";")),
                                                       " - Number of sequences:",
                                                       tags$b(nrow(sequences_filtered())),
                                                       tags$p(),
                                                       tags$span(style="color:red", HTML(if_else(n_seq_valid(), "", str_c(tags$b("Too many sequence !"), " Must be below ", tags$b(n_seq_max))))),
                                                       sep=" ")})



    # Download files (zip) ----------------------------------------------------
    #
    # See:  https://stackoverflow.com/questions/43916535/download-multiple-csv-files-with-one-button-downloadhandler-with-r-shiny

      # ! Must replace ":" by "_" in file names !


      output$download_pr2_zip <- downloadHandler(

      # filename = function() {str_c(file_head(), ".zip")},
      filename = function() {str_c("pr2_",
                                   str_replace(str_c(taxo_selected()$name, collapse = "-"), ":", "_"),
                                   "_", Sys.Date(), ".zip")},


      content = function(path) {


        setwd(tempdir()) # This is needed to avoid problems with file path (on windows tempdir() returns the path as windows path)

        file_pr2 <- str_c("pr2_", str_c(taxo_selected()$name, collapse = "-"), "_", Sys.Date(), ".xlsx")
        file_pr2 <- gsub(":", "_", file_pr2) # For some mysterious reason str_replace does not work with ":"
        file_fasta <- str_replace(file_pr2, "xlsx", "fasta")


         files = c(file_pr2, file_fasta)

        sequences_export <- sequences_filtered() %>%
          mutate(species_old = species) %>%
          relocate(species_old, .after = species) %>%
          select(-starts_with("taxo_"))

        taxonomy_export <- sequences_export %>%
          count(kingdom, supergroup, division, class, order, family, genus, species)

        # Export Xlsx file with 2 tables
        rio::export(list("taxonomy"=taxonomy_export, "sequences"=sequences_export),
                    file=file_pr2,
                    zoom=80, firstActiveRow = 2, firstActiveCol = 11, colWidths="auto",
                    overwrite = TRUE)

        # Export fasta file
        sequences_filtered() %>%
          rename(seq_name = pr2_accession) %>%
          fasta_write(file_fasta)


        system2("zip", args=(paste("--junk-paths", path, files,sep=" "))) # remove the paths of the files
      }
    )


    # UI ----------------------------------------------------------------------


    # Export only selected sequences

    output$download_ui <- renderUI({
      tagList(
        if(nrow(sequences_filtered()) == 0) {messages$no_data},
        p(),
        htmlOutput(ns("taxo_selected")),
        # https://cran.r-project.org/web/packages/dipsaus/vignettes/shiny_customized_widgets.html
        p(),
        fluidRow(
          column(4, if(n_seq_valid()) downloadButton(ns('download_pr2_zip'), 'Download PR2 sequences (zip)', class = "btn-primary")),
        ),
        p(),
        includeMarkdown(app_sys("app/readme/download.md")),
      )
    })


    # Export full database

    output$download_full_ui <- renderUI({
      tagList(

        includeMarkdown(app_sys("app/readme/download_full.md")),


      )
    })

  })

}
