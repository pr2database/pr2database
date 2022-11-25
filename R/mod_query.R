
# UI ----------------------------------------------------------------------

mod_query_ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns('ui_query')),
    shinycssloaders::withSpinner(uiOutput(ns('ui_query_results'))),
    # uiOutput(ns('ui_map_asv')),
    # shinycssloaders::withSpinner(DT::dataTableOutput(ns("pr2_filtered")))
  )
}



# Server ------------------------------------------------------------------


mod_query_server <- function(id) {

  moduleServer(id, function(input, output, session) {

    ns <- NS(id)



    # Compute similarity between query sequence and all ASVs
    pr2_blast <- eventReactive(input$button_match, {

      iv_query <- shinyvalidate::InputValidator$new()
      iv_query$add_rule("query", ~ if(!sequence_check(.)) " Please enter valid sequence at least 130 bp long.")

      iv_query$enable()

      req(iv_query$is_valid())

      # cat("N rows fasta: ", nrow(fasta_all()), "\n")

      blast <- blaster_sequence(pr2$main, input$query)
      if(!is.null(blast)){
        blast <- blast %>%
          # tibble::column_to_rownames(var = "pr2_accession") %>% # This is only needed if one neeed to select sequences
          arrange(desc(pid))
      }
      return(blast)
    })

    # Filter the Sequences based on % ID
    pr2_filtered <- eventReactive(
      {input$button_match
        input$pct_id_min},
      {
        req(!is.null(pr2_blast()))
        pr2_blast()  %>%
          dplyr::filter(pid >= input$pct_id_min)
      })


    # output$query_valid <- renderText(pr2_blast())

    # Download files (zip) ----------------------------------------------------
    #
    # See:  https://stackoverflow.com/questions/43916535/download-multiple-csv-files-with-one-button-downloadhandler-with-r-shiny


    output$download_pr2_query_zip <- downloadHandler(

      # filename = function() {str_c(file_head(), ".zip")},
      filename = function() {str_c("pr2_query_", Sys.Date(), ".zip")},


      content = function(path) {


        setwd(tempdir()) # This is needed to avoid problems with file path (on windows tempdir() returns the path as windows path)

        file_pr2 <- str_c("pr2_query_", Sys.Date(), ".xlsx")
        file_fasta <- str_replace(file_pr2, "xlsx", "fasta")

        files = c(file_pr2, file_fasta)

        sequences_export <- pr2_filtered()

      # Export Xlsx file with 2 tables
        rio::export(list("sequences"=sequences_export),
                    file=file_pr2,
                    zoom=80, firstActiveRow = 2, firstActiveCol = 2, colWidths="auto",
                    overwrite = TRUE)

        # Export fasta file
        sequences_export %>%
          rename(seq_name = pr2_accession) %>%
          fasta_write(file_fasta)

          system2("zip", args=(paste("--junk-paths", path, files,sep=" "))) # remove the paths of the files
      }
    )

    # UI for Query ------------------------------------------------------------

    output$ui_query <- renderUI({
      tagList(

        h3("BLAST-like search for  PR2 sequences similar to query sequence."),
        p("All PR2 sequences are searched but only those above % identity min are shown"),
        p(),

        sliderInput(ns("pct_id_min"), label ="% identity min", min = 80.0, max = 100.0,
                    step = 0.2, value = 95, width = "500px"),

        textAreaInput(ns("query"), label = "Query - at least 130 bp", value = "",
                      width = "100%", height = "100px",
                      cols = NULL, rows = NULL,
                      placeholder = "GTAGTTGGATTTCTGTTGAGGACGGC...", resize = NULL),

        actionButton(ns("button_match"), "Search - be patient"),
        tags$hr()
      )
    })



    # UI <- Make a table of the filtered sequences ------------------------------


    output$pr2_filtered <-   DT::renderDT(pr2_filtered() %>%
                                            # mutate(sequence = gsub("(.{80})","\\1\n",sequence)) %>%
                                            select(-sequence) %>%
                                            relocate(species, .before = pid),
                                          rownames = FALSE,
                                          selection = 'single',
                                          options = list(pageLength = 50,
                                                         autoWidth = TRUE,
                                                         scrollX=TRUE,
                                                         columnDefs = list(list(width = '10%', targets = c(1)),
                                                                           list(width = '20%', targets = c(9:11)))
                                          )
    )

    output$ui_query_results <- renderUI({
      req(pr2_filtered())
      tagList(
        p(),
        fluidRow(
          column(3, h3("Matching PR2 sequences")),
          column(4, style = "margin-top: 20px;",  # This to align the download box to the legend on the left
                 downloadButton(ns('download_pr2_query_zip'), 'Download filtered results (zip)', class = "btn-primary"))
        ),
        p(),
        DT::dataTableOutput(ns("pr2_filtered")),
        # renderPrint({
        #   cat("ASV selected: ",  pr2_selected())
        # })

      )
    })



  })

}
