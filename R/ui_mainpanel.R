  mainpanel <- function() {mainPanel(
  tabsetPanel(
    id = 'panel' ,

    # tabPanel("Datasets",
    #          data_datasets_table_UI("pr2_select")
    # ),
    tabPanel("Taxonomy",
             mod_table_taxonomy_ui("table_taxonomy")
             ),
    tabPanel("Sequences",
             mod_table_sequences_ui("table_sequences")
             ),
    # tabPanel("Map",
    #          mapUI("map")
    # ),
    # tabPanel("Barplot",
    #          barplotUI("barplot")
    # ),
    # tabPanel("Diversity",
    #
    tabPanel("Download selected sequences",
             mod_download_UI("download")
    ),

    tabPanel("Download full database",
             mod_download_full_UI("download")
             ),

    tabPanel("Query",
             mod_query_ui("query")
             ),


    tabPanel("About",
             column(8, includeMarkdown(app_sys("readme/README.md")))
             )
    # column(8, includeMarkdown('README.md')))

    # ,
    #
    # tabPanel("Settings",
    #          # data_settings_UI("data")
    #          )


    # tabPanel("Debug",
    #          textOutput("test1"),
    #          textOutput("test2"),
    #          DT::dataTableOutput("test3")
    #          # dataTableOutput("test4")
    # )
  )
)

}


